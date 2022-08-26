//
//  MapKitViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol MapKitDisplayLogic: AnyObject {
    func displayLocation(viewModel: MapKit.Fetch.ViewModel)
}

final class MapKitViewController: UIViewController {
    
    var interactor: MapKitBusinessLogic? {
        didSet {
            interactor?.fetchData(request: MapKit.Fetch.Request())
        }
    }
    var router: (MapKitRoutingLogic & MapKitDataPassing)?
    var viewModel: MapKit.Fetch.ViewModel?
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .standard
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        
        locationManagerSetup()
        
        setPins()
        
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MapKitInteractor()
        let presenter = MapKitPresenter()
        let router = MapKitRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: Custom Functions
    private func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.showsScale = true
    }
    
    private func setPins() {
        viewModel?.officesListViewModel.forEach { model in
            mapView.addAnnotation(Annotation(id: model.id ?? 0,
                                             coordinate: .init(latitude: model.latitude ?? 0.0,
                                                               longitude: model.longitude ?? 0.0),
                                             title: model.name ?? "",
                                             subtitle: model.address ?? ""))
        }
    }
    
    //MARK: IBActions
    @IBAction func changeMapViewTapped(_ sender: UIButton) {
        
        if mapView.mapType == .standard {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
            mapView.tintColor = .systemGray6
        }
    }
    
    
}

//MARK: - MapKit Delegates
extension MapKitViewController: MKMapViewDelegate {
    
    //MARK: Setting annotation and annotation items
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "annotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            
            let navigationButton = UIButton(type: .detailDisclosure)
            navigationButton.setImage(UIImage(named: "golocation"), for: .normal)
            annotationView?.rightCalloutAccessoryView = navigationButton
            
            let closeButton = UIButton(type: .detailDisclosure)
            closeButton.setImage(UIImage(named: "info"), for: .highlighted)
            closeButton.tag = 1
            annotationView?.leftCalloutAccessoryView = closeButton
        }

        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "building")
            annotationView.backgroundColor = .white
        }
          return annotationView
    }
    
    
    //MARK: Setting annotation buttons
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //Birden fazla buton ve tek fonksiyon olduğu için tag'ladık.
        if control.tag == 0 {
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
        } else {
            let routeID = (view.annotation as! Annotation).id
            router?.routeToDetails(indexID: routeID)
        }
    }
}

//MARK: - Core Location Delegates
extension MapKitViewController: CLLocationManagerDelegate {
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locationManager.location?.coordinate else {
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}


//MARK: - Display Logic
extension MapKitViewController: MapKitDisplayLogic {
    func displayLocation(viewModel: MapKit.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
