//
//  MapKitRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitRoutingLogic: AnyObject {
    
}

protocol MapKitDataPassing: AnyObject {
    var dataStore: MapKitDataStore? { get }
}

final class MapKitRouter: MapKitRoutingLogic, MapKitDataPassing {
    
    weak var viewController: MapKitViewController?
    var dataStore: MapKitDataStore?
    
}
