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
    var offices: [Offices]? { get set }
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {
    
    var offices: [Offices]?
    
    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    
    
    //2
    func fetchOfficesList() { //interactor da worker'a diyor, office listesini getir.
        worker.getOfficesList()
        presenter?.presentOffices(response: Office.Fetch.Response(officesList: [])) //getirdikten sonra presenter'a diyor ki, officeleri sun.
        }
    
}

