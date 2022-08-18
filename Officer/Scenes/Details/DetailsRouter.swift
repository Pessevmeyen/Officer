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
    func routeToWebKitScreen()
}

protocol DetailsDataPassing: AnyObject {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    var officeData: [OfficeData]?
    
    //MARK: Verileri İlgili ViewController'dan İstenilen View Controller'a aktardıktan sonra Ekranları bağladığımız delege fonksiyonu. Burada data tipleri Response Modelini tutan Structtır.
    func routeToFullScreen(index: Int) {
        let storyboard = UIStoryboard(name: Constants.fullScreenStoryboardName, bundle: nil)
        let destinationVC: FullScreenViewController = storyboard.instantiateViewController(identifier: Constants.fullScreenIdentifier)
        destinationVC.router?.dataStore?.officeImages = dataStore?.officeData //Buraya imageların array'i gelecek.
        destinationVC.router?.dataStore?.selectedIndex = index //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e.
        
        destinationVC.delegate = viewController
        
        viewController?.present(destinationVC, animated: true) // Burada pop'up olarak açılacak ekran. kullanıcı açısından daha basit olur.
    }
    
    
    
    func routeToWebKitScreen() {
        
        let storyboard = UIStoryboard(name: "WebKit", bundle: nil)
        let destinationVC: WebKitViewController = storyboard.instantiateViewController(identifier: "WebKitViewController") as! WebKitViewController
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .popover
        viewController?.present(navigationController, animated: true)
        }
    
    }
    


