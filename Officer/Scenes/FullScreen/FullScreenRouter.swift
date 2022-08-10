//
//  FullScreenRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import Foundation

protocol FullScreenRoutingLogic: AnyObject {
}

protocol FullScreenDataPassing: class {
    var dataStore: FullScreenDataStore? { get }
}

final class FullScreenRouter: FullScreenRoutingLogic, FullScreenDataPassing {
    
    weak var viewController: FullScreenViewController?
    var dataStore: FullScreenDataStore?
    
}
