//
//  MapKitViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import UIKit
import MapKit

protocol MapKitDisplayLogic: AnyObject {
    
}

final class MapKitViewController: UIViewController {
    
    var interactor: MapKitBusinessLogic?
    var router: (MapKitRoutingLogic & MapKitDataPassing)?
    
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
        
        mapView.addAnnotation(Annotation(coordinate: .init(latitude: 40, longitude: 30), title: "pin"))
        
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
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}

extension MapKitViewController: MapKitDisplayLogic {
    
}
