//
//  DetailsViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import AVFoundation
import AVKit

protocol DetailsDisplayLogic: AnyObject {
    func displayDetailsList(viewModel: Details.Fetch.ViewModel)
}

final class DetailsViewController: UIViewController {
    
    //MARK: Variables and Constants
    var isGridLayout = false
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    var viewModel: Details.Fetch.ViewModel? {
        didSet { //Details'a ilk girişte viewModel'ın içine data girene kadar title nil gelecek, o yüzden didSet'e aktardık ki, viewModel dolduğu anda tetiklensin.
            self.title = viewModel?.name ?? ""
        }
    }
    var locationManager = CLLocationManager()
    var videoPlayer: AVPlayer!
    let playerController = AVPlayerViewController()
    var bool = true
    
    //MARK: @IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .standard
        }
    }
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.alpha = 0.05
        }
    }
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            registerCollectionView()
        }
    }
    
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.topItem?.backButtonTitle = "Offices"

        collectionView.setCollectionViewLayout(setCollectionView(), animated: true)
        
        setRightBarButtonItem(buttonImage: "gridlayoutimage") //Navigation bar'daki buttonu oluşturacak.
        
        interactor?.fetchDetails(request: Details.Fetch.Request())
        
        setInformation()
        
        setOfficeAnnotation()
        
        locationManagerSetup()
        
        configureVideoPlayer()
       
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    
    //MARK: - Custom Functions
    private func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsScale = true
    }
    
    // Right Bar Button
    private func setRightBarButtonItem(buttonImage: String) {
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Photos", style: .plain, target: self, action: #selector(changeLayout)) //????
        let changeLayoutButton = UIBarButtonItem.init(image: UIImage(named: buttonImage), style: .done, target: self, action: #selector(changeLayout))
        changeLayoutButton.customView?.borderWidth = 1
        navigationItem.rightBarButtonItems = [changeLayoutButton]
    }
    
    private func setInformation() {
        imageView.sd_setImage(with: URL(string: viewModel?.image ?? ""))
        nameLabel.text = viewModel?.name ?? "nil"
        addressLabel.text = viewModel?.address ?? "nil"
        capacityLabel.text = "Capacity: \(viewModel?.capacity ?? "nil")"
        spaceLabel.text = "Space: \(viewModel?.space ?? "nil")"
        roomLabel.text = "Rooms: \(viewModel?.rooms ?? "nil")"
    }
    
    private func setOfficeAnnotation() {
        mapView.addAnnotation(Annotation(id: viewModel?.id ?? 0, coordinate: .init(latitude: viewModel?.latitude ?? 0.0, longitude: viewModel?.longitude ?? 0.0), title: viewModel?.name ?? "", subtitle: viewModel?.address ?? ""))
    }
    
    private func configureVideoPlayer() {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            debugPrint("video not found")
            return
        }
        
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.player = videoPlayer
        playerController.view.frame.size.height = videoView.frame.size.height
        playerController.view.frame.size.width = videoView.frame.size.width
        playerController.videoGravity = .resizeAspectFill
        videoView.addSubview(playerController.view)
        videoView.addSubview(playPauseButton)
        

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: playerController.player?.currentItem,
                                               queue: OperationQueue.main) { [weak self] _ in
            if (self?.playerController.player?.currentItem) != nil {
                self?.playerController.player?.seek(to: .zero)
                self?.playerController.player?.pause()
            }
        }
    }
    
    
    private func playPause() {
        switch videoPlayer.timeControlStatus {
        case .playing:
            pause()
        case .paused:
            play()
        default:
            break
        }
    }
    
    //play()'ler farklı, biri func ismi diğeri AVPlayerın fonksiyonu
    private func play() {
        videoPlayer.play()
    }
    
    private func pause() {
        videoPlayer.pause()
    }
    
    
    //MARK: - @objc functions
    //MARK: The Action When Right Bar Button Tapped
    @objc func changeLayout() {
        
        if isGridLayout { // If user on Listing ViewConstants.gridLayoutImage
            collectionView.setCollectionViewLayout(setCollectionView(), animated: true)
            setRightBarButtonItem(buttonImage: Constants.gridLayoutImage)
            title = viewModel?.name
            isGridLayout = false
            
        } else { // If user on Grid View
            setRightBarButtonItem(buttonImage: Constants.listingLayoutImage)
            collectionView.setCollectionViewLayout(setGridLayout(), animated: true)
            title = "All Photos"
            isGridLayout = true
        }
    }
    
    
    //MARK: - @IBActions
    @IBAction func websitePressed(_ sender: UIButton) {
        router?.routeToWebKitScreen()
    }
    
    @IBAction func changeMapViewTapped(_ sender: UIButton) {
        if mapView.mapType == .standard {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
        }
    }
    
    @IBAction func playPauseClicked(_ sender: UIButton) {
        playPause()
    }
    
}




//MARK: - Setting Flow Layout and Grid Layout
extension DetailsViewController {
    
    // Setting Custom Collection View
    private func setCollectionView() -> UICollectionViewFlowLayout {
        let listLayout = UICollectionViewFlowLayout()
        listLayout.collectionView?.layoutIfNeeded()
        listLayout.scrollDirection = .horizontal
        listLayout.itemSize = CGSize(width: (view.frame.size.width - 30), height: (collectionView.frame.size.width - 135))
        listLayout.minimumInteritemSpacing = 5
        listLayout.minimumLineSpacing = 5
        collectionView.setCollectionViewLayout(listLayout, animated: true)
        return listLayout
    }
    
    // Setting Grid Layout
    private func setGridLayout() -> UICollectionViewFlowLayout { //İki farklı layout verdiğim için bunu böyle yaptım. Doğrusunu sor.
        let gridLayout = UICollectionViewFlowLayout()
        gridLayout.scrollDirection = .vertical
        gridLayout.itemSize = CGSize(width: (view.frame.size.width / 4) - 5, height: (view.frame.size.width / 4) - 10)
        gridLayout.minimumLineSpacing = 5
        gridLayout.minimumInteritemSpacing = 1
        collectionView.setCollectionViewLayout(gridLayout, animated: true)
        return gridLayout
    }
}



//MARK: - Collection View Delegate and Data Source
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // How much section will occure
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // How much item will occure in one section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images?.count ?? 0
    }
    
    // This items occurs from what
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.detailsCellReuseIdentifier, for: indexPath) as? DetailsCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(images: model.images?[indexPath.row] ?? "")
        return cell
    }
    
    // What happen when a cell tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.row) //????? row? item?
    }
}


//MARK: - Collection View Flow Layout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    // Her bir sectionda sağdan soldan yukarıdan aşağıdan ne kadar boşluk istediği.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
    }
}


//MARK: - Full Screen Ekranından gelen index'in delegesi, oradan gelen indexi buradaki collection view'a aktaracak.
extension DetailsViewController: FullScreenDelegate {
    func fullScreenDidScroll(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}


//MARK: - MapView Delegate
extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "annotationId"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            
            let navigationButton = UIButton(type: .detailDisclosure)
            navigationButton.setImage(UIImage(named: "golocation"), for: .normal)
            annotationView?.rightCalloutAccessoryView = navigationButton
        }

        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "building")
            annotationView.backgroundColor = .white
        }
          return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //Birden fazla buton ve tek fonksiyon olduğu için tag'ladık.
            guard let selectedAnnotation = view.annotation else {
                return
            }

            let requestLocation = CLLocation(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemark, error in
                
                if let placemarks = placemark {
                    if placemarks.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        
                        item.name = selectedAnnotation.title ?? ""
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
    }
}

//MARK: - Core Location Delegate
extension DetailsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
        let region = MKCoordinateRegion(center: .init(latitude: viewModel?.latitude ?? 0.0, longitude: viewModel?.longitude ?? 0.0), span: span)
        mapView.setRegion(region, animated: true)
    }
}


//MARK: - Display Logic
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetailsList(viewModel: Details.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
