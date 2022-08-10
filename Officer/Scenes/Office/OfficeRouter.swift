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
}

protocol OfficeDataPassing: class {
    var dataStore: OfficeDataStore? { get }
}

final class OfficeRouter: OfficeRoutingLogic, OfficeDataPassing {
    
    weak var viewController: OfficeViewController?
    var dataStore: OfficeDataStore?
    
    func routeToDetails(index: Int) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let destVC: DetailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController")
        destVC.router?.dataStore?.officeData = dataStore?.offices?[index] //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e. indexten aldığımız için array'i teklile düşürüyoruz. o yüzden sol taraf array değil.
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
}
