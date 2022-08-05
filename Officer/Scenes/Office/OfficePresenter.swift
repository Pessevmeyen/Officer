//
//  OfficePresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation
import UIKit

protocol OfficePresentationLogic: AnyObject {
    func presentOffices(response: Office.Fetch.Response)
}

final class OfficePresenter: OfficePresentationLogic {
    
    weak var viewController: OfficeDisplayLogic?
    
    //4
    func presentOffices(response: Office.Fetch.Response) {
        
        //worker'ın çektiği veriler, interactor ile buraya gelecek. Gelen veriler burada formatlanacak, şekil verilecek.
        var offices: [Office.Fetch.ViewModel.OfficeModel] = []
        response.officesList.forEach { //Burada gelen array şeklinde veri parametrelerini, Model içindeki parametrelere aktarıyoruz.
            offices.append(Office.Fetch.ViewModel.OfficeModel(id: $0.id,
                                                              image: $0.image,
                                                              images: $0.images,
                                                              name: $0.name,
                                                              address: $0.address,
                                                              capacity: $0.capacity,
                                                              rooms: String($0.rooms ?? 0),
                                                              space: $0.space))
            print(offices)
            
        }
        viewController?.displayOfficesList(viewModel: Office.Fetch.ViewModel(officesList: offices)) // Presenter da view controller'a diyor, veriler hazır, office listesini gösterebilirsin
    }
}
