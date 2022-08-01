//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeBusinessLogic: AnyObject {
    func fetchNews(request: Office.Fetch.Request)
}

protocol OfficeDataStore: AnyObject {
    
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {
    
    
    
    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    var offices: [Offices]?
    
    //2
    func fetchNews(request: Office.Fetch.Request) {
        worker.getNews(request: OfficeRequestModel()) { [weak self] _ in
            // worker burada, interactor tarafından istenilen verileri getirecek.
            self?.presenter?.presentNews()
        }
    }
    
}
