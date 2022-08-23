//
//  MapKitRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitRoutingLogic: AnyObject {
    func routeToDetails(indexID: Int)
}

protocol MapKitDataPassing: AnyObject {
    var dataStore: MapKitDataStore? { get }
}

final class MapKitRouter: MapKitRoutingLogic, MapKitDataPassing {
    
    weak var officeViewController: OfficeViewController?
    weak var viewController: MapKitViewController?
    var dataStore: MapKitDataStore?
    
    func routeToDetails(indexID: Int) {
        officeViewController?.router?.routeToDetails(index: indexID)
    }
    
}
