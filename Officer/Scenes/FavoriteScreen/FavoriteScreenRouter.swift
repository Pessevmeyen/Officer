//
//  FavoriteScreenRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import UIKit

protocol FavoriteScreenRoutingLogic: AnyObject {
    func routeToDetails(index: Int)
}

protocol FavoriteScreenDataPassing: AnyObject {
    var dataStore: FavoriteScreenDataStore? { get }
}

final class FavoriteScreenRouter: FavoriteScreenRoutingLogic, FavoriteScreenDataPassing {
    
    weak var viewController: FavoriteScreenViewController?
    var dataStore: FavoriteScreenDataStore?
    var selected: OfficeData?
    
    func routeToDetails(index: Int) {
        
        let item = dataStore?.dataStore?[index]
        selected = item.map {
            OfficeData(address: $0.address,
                       capacity: $0.capacity,
                       id: Int($0.id ?? 0),
                       image: $0.image,
                       images: $0.images ?? [],
                       location: Location.init(latitude: $0.latitude,
                                               longitude: $0.longitude),
                       name: $0.name,
                       rooms: Int($0.rooms ?? ""),
                       space: $0.space)
            }

        let storyboard = UIStoryboard(name: Constants.detailsStoryboardName, bundle: nil)
        let destVC: DetailsViewController = storyboard.instantiateViewController(identifier: Constants.detailsIdentifier)
        destVC.router?.dataStore?.officeData = selected
        viewController?.presentAsSheet(controller: destVC, contentMode: .fullScreen, syncViewHeightWithKeyboard: false)
    }
    
}
