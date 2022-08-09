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
    
    //MARK: Verileri İlgili ViewController'dan İstenilen View Controller'a aktardıktan sonra Ekranları bağladığımız delege fonksiyonu. Burada data tipleri Response Modelini tutan Structtır.
    func routeToFullScreen(index: Int) {
        let storyboard = UIStoryboard(name: "FullScreen", bundle: nil)
        let destinationVC: FullScreenViewController = storyboard.instantiateViewController(identifier: "FullScreenViewController")
        destinationVC.router?.dataStore?.officeImages = ["mercury", "venus", "earth", "mars", "jupiter", "saturn"]
        destinationVC.router?.dataStore?.selectedIndex = index //Burada hangi index seçildiyde, o index'in datası aktarılıyor. Detailsdaki offices'e.
        
        destinationVC.modalPresentationStyle = .popover
        destinationVC.modalTransitionStyle = .coverVertical
        viewController?.present(destinationVC, animated: true) // Burada pop'up olarak açılacak ekran. kullanıcı açısından daha basit olur.
        
        
        //destinationVC.selectedPictureNumber = FullScreen.Fetch.ViewModel.init(images: dataStore?.officeData?.images ?? [String])[index]
//        destinationVC.selectedPictureNumber = index // + 1
//        destinationVC.totalPictures = dataStore?.officeData?.images?.count
//        destinationVC.selectedImage = dataStore?.officeData?.images?[index]
        
        
        //MARK: Burada ise pop-up değil de tam ekran çıkmasını istersek.
        //destVC.modalPresentationStyle = .popover //Navigation bağlı olduğu için popover yapamıyor
        //self.viewController?.navigationController?.pushViewController(destVC, animated: true)
        //self.viewController?.show(destVC, sender: nil)
        
    }
    
}

