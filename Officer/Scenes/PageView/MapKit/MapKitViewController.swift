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
        mapView.showsUserLocation = true
        
        print("mapkit view did load")
        
        
        setPins()
        
//        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.latitude ?? 41.114104, longitude: viewModel?.longitude ?? 29.022484), title: "Kollektif House Maslak", subtitle: "42 Maslak, Maslak Mah., Ahi Evran Cd. No:6 D:3, 34398 Maslak/İstanbul"))
//
//        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.latitude ?? 41.03104, longitude: viewModel?.longitude ??
//                                                           29.022484), title: "Kollektif House Kadıköy", subtitle: "42 Maslak, Maslak Mah., Ahi Evran Cd. No:6 D:3, 34398 Kadıköy/İstanbul"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func setPins() {
        
        viewModel?.officesListViewModel.forEach { model in
            mapView.addAnnotation(Annotation(coordinate: .init(latitude: model.latitude ?? 0.0,
                                                               longitude: model.longitude ?? 0.0),
                                             title: model.name ?? "",
                                             subtitle: model.address ?? ""))
            
            
            
        }

        
        
//        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.officesListViewModel[1].latitude ?? 0.0,
//                                                           longitude: viewModel?.officesListViewModel[1].longitude ?? 0.0),
//                                         title: "Kollektif House Maslak",
//                                         subtitle: "42 Maslak, Maslak Mah., Ahi Evran Cd. No:6 D:3, 34398 Maslak/İstanbul"))
//
//        mapView.addAnnotation(Annotation(coordinate: .init(latitude: viewModel?.officesListViewModel[2].latitude ?? 0.0,
//                                                           longitude: viewModel?.officesListViewModel[2].longitude ??
//                                                           0.0),
//                                         title: "Kollektif House Kadıköy",
//                                         subtitle: "42 Maslak, Maslak Mah., Ahi Evran Cd. No:6 D:3, 34398 Kadıköy/İstanbul"))
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationIdentifier = "identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .roundedRect)
        }

         if let annotationView = annotationView {

            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "building")
            
        }
          return annotationView
    }
    
    
    
    
    
}

extension MapKitViewController: CLLocationManagerDelegate {
    
    //CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locationManager.location?.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: location!, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

extension MapKitViewController: MapKitDisplayLogic {
    func displayLocation(viewModel: MapKit.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
