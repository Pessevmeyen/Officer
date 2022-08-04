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
        response.officesList.forEach { 
            offices.append(Office.Fetch.ViewModel.OfficeModel(id: 1,
                                                              image: $0.image,
                                                              name: $0.name,
                                                              address: $0.address,
                                                              capacity: $0.capacity,
                                                              rooms: String($0.rooms ?? 1),
                                                              space: $0.space)) //Nereye append edilecek? ViewModel içine edilecek ki view controller gösterecek.
            print(offices)
            
        }
        viewController?.displayOfficesList(viewModel: Office.Fetch.ViewModel(officesList: offices)) // Presenter da view controller'a diyor, veriler hazır, office listesini gösterebilirsin
    }
}
