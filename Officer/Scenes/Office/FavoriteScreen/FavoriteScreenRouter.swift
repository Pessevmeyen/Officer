//
//  FavoriteScreenRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenRoutingLogic: AnyObject {
    
}

protocol FavoriteScreenDataPassing: class {
    var dataStore: FavoriteScreenDataStore? { get }
}

final class FavoriteScreenRouter: FavoriteScreenRoutingLogic, FavoriteScreenDataPassing {
    
    weak var viewController: FavoriteScreenViewController?
    var dataStore: FavoriteScreenDataStore?
    
}
