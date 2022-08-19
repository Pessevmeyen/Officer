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
    
    var interactor: MapKitBusinessLogic?
    var router: (MapKitRoutingLogic & MapKitDataPassing)?
    var viewModel: MapKit.Fetch.ViewModel?
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        interactor?.fetchData(result: MapKit.Fetch.Request())
        
        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.latitude ?? 0.0, longitude: viewModel?.longitude ?? 0.0), title: "Kollektif House Levent", subtitle: "çok güzel ofis"))
        
        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.latitude ?? 0.0, longitude: viewModel?.longitude ?? 0.0), title: "Kollektif House Maslak", subtitle: "çok güzel ofis"))
        
        
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
}

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

extension MapKitViewController: MKMapViewDelegate {
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
    
    
    
}

extension MapKitViewController: CLLocationManagerDelegate {
    
    //CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locationManager.location?.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location!, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapKitViewController: MapKitDisplayLogic {
    func displayLocation(viewModel: MapKit.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
