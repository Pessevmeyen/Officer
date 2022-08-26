//
//  MapKitRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import UIKit

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
        
        let storyboard = UIStoryboard(name: Constants.detailsStoryboardName, bundle: nil)
        let destVC: DetailsViewController = storyboard.instantiateViewController(identifier: Constants.detailsIdentifier)
        destVC.router?.dataStore?.officeData = dataStore?.officeArray?[indexID] //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e. indexten aldığımız için array'i teklile düşürüyoruz. o yüzden sol taraf array değil.
        viewController?.navigationController?.pushViewController(destVC, animated: true)
        
        //officeViewController?.router?.routeToDetails(index: indexID)
    }
    
}
