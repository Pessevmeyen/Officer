//
//  OfficeRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation
import UIKit

protocol OfficeRoutingLogic: AnyObject {
    func routeToDetails(index: Int)
    func routeToFavorites()
}

protocol OfficeDataPassing: AnyObject {
    var dataStore: OfficeDataStore? { get }
}

final class OfficeRouter: OfficeRoutingLogic, OfficeDataPassing {
    
    weak var viewController: OfficeViewController?
    var dataStore: OfficeDataStore?
    
    func routeToDetails(index: Int) {
        let storyboard = UIStoryboard(name: Constants.detailsStoryboardName, bundle: nil)
        let destVC: DetailsViewController = storyboard.instantiateViewController(identifier: Constants.detailsIdentifier)
        destVC.router?.dataStore?.officeData = dataStore?.filteredOffices?[index] //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e. indexten aldığımız için array'i teklile düşürüyoruz. o yüzden sol taraf array değil.
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func routeToFavorites() {
        let storyboard = UIStoryboard(name: Constants.favoriteStoryboardName, bundle: nil)
        let destVC: FavoriteScreenViewController = storyboard.instantiateViewController(identifier: Constants.favoriteIdentifier)
        self.viewController?.present(destVC, animated: true) // Burada pop'up olarak açılacak ekran. kullanıcı açısından daha basit olur.
    }
}
