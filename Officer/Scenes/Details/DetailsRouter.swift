//
//  DetailsRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation
import UIKit

protocol DetailsRoutingLogic: AnyObject {
    func routeToFullScreen(index: Int)
}

protocol DetailsDataPassing: class {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    var officeData: [OfficeData]?
    
    func routeToFullScreen(index: Int) {
        let storyboard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destVC: FullScreenViewController = storyboard.instantiateViewController(identifier: "FullScreenViewController")
        destVC.router?.dataStore?.fullScreenData = dataStore?.officeData //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e.
        destVC.modalPresentationStyle = .popover //Navigation bağlı olduğu için popover yapamıyor
        self.viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

