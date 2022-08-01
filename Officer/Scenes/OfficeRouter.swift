//
//  OfficeRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeRoutingLogic: AnyObject {
    
}

protocol OfficeDataPassing: class {
    var dataStore: OfficeDataStore? { get }
}

final class OfficeRouter: OfficeRoutingLogic, OfficeDataPassing {
    
    weak var viewController: OfficeViewController?
    var dataStore: OfficeDataStore?
    
}
