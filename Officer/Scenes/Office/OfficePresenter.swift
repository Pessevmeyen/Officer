//
//  OfficePresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficePresentationLogic: AnyObject {
    func presentOffices(response: Office.Fetch.Response)
}

final class OfficePresenter: OfficePresentationLogic {
    
    weak var viewController: OfficeDisplayLogic?
    
    //4
    func presentOffices(response: Office.Fetch.Response) {
        
        //worker'ın çektiği veriler, interactor ile buraya gelecek. Gelen veriler burada formatlanacak, şekil verilecek.
        var offices: [Office.Fetch.ViewModel.OfficeModel] = []
        response.officesList.forEach {_ in
            offices.append(Office.Fetch.ViewModel.OfficeModel(name: "name", label: "label", image: "image")) //Nereye append edilecek? ViewModel içine edilecek ki view controller gösterecek.
        }
        viewController?.displayOfficesList() // Presenter da view controller'a diyor, veriler hazır, office listesini gösterebilirsin
    }
}
