//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeBusinessLogic: AnyObject {
    func fetchOfficesList()
}

protocol OfficeDataStore: AnyObject {
    var offices: Offices? { get set } //Daha sonra router ile veri aktarımı için verileri tutuyoruz burada.
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {
    
    var offices: Offices?
    
    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    //2
    func fetchOfficesList() { //interactor da worker'a diyor, office listesini getir.
        worker.getOfficesList { result in
            switch result {
            case .success(let response):
                self.offices = response
                guard let offices = self.offices else { return }
                print(offices)
                
                self.presenter?.presentOffices(response: Office.Fetch.Response(officesList: offices))
                print(offices)
                
                

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //presenter?.presentOffices(response: Office.Fetch.Response(officesList: offices)) //getirdikten sonra presenter'a diyor ki, officeleri sun.
        }
    
}

