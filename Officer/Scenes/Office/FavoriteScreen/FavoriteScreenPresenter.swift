//
//  FavoriteScreenPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenPresentationLogic: AnyObject {
    func presentCoreData(officesId : [FavoriteScreen.Fetch.ViewModel.CoreDataModels])
}

final class FavoriteScreenPresenter: FavoriteScreenPresentationLogic {
    
    weak var viewController: FavoriteScreenDisplayLogic?
    
    func presentCoreData(officesId: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]) {
        
        //worker'ın çektiği veriler, interactor ile buraya gelecek. Gelen veriler burada formatlanacak, şekil verilecek.
//        var offices: [Office.Fetch.ViewModel.OfficeModel] = []
//        response.officeResponse.forEach { //Burada gelen array şeklinde veri parametrelerini, Model içindeki parametrelere aktarıyoruz.
//            offices.append(Office.Fetch.ViewModel.OfficeModel(id: $0.id,
//                                                              bool: $0.bool,
//                                                              image: $0.image,
//                                                              images: $0.images,
//                                                              name: $0.name,
//                                                              address: $0.address,
//                                                              capacity: $0.capacity,
//                                                              rooms: String($0.rooms ?? 0),
//                                                              space: $0.space))
//        }
        viewController?.displayCoreData(displayOfficeId: officesId)
    }
    
    
}
