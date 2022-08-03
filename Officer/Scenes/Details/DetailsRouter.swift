//
//  DetailsRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol DetailsRoutingLogic: AnyObject {
    
}

protocol DetailsDataPassing: class {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
}
