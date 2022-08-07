//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeBusinessLogic: AnyObject {
    func fetchOfficesList(request: Office.Fetch.Request)
}

protocol OfficeDataStore: AnyObject {
    var offices: Offices? { get set } //Daha sonra router ile veri aktarımı için verileri tutuyoruz burada. Request&Response modeli Array içinde tutuyoruz.
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {

    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    init(worker: OfficeWorkingLogic) {
        self.worker = worker
    }
    
    var offices: Offices? //Workerdan gelen response verisi buraya aktarılıyor.
    
    //2
    func fetchOfficesList(request: Office.Fetch.Request) { //interactor da worker'a diyor, office listesini getir.
        worker.getOfficesList { [weak self] result in
            switch result {
            case .success(let response):
                self?.offices = response //işlem kolaylığı açısından, office datalarını çektiğimiz için office diye isimlendirebiliriz bu datayı.
                guard let offices = self?.offices else { return } //Optional gelen veriyi güvenli hale getiriyoruz.
                print(offices)
                self?.presenter?.presentOffices(response: Office.Fetch.Response(officesList: offices)) //Buradan presenter'a aktarılıyor.
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //presenter?.presentOffices(response: Office.Fetch.Response(officesList: offices)) //getirdikten sonra presenter'a diyor ki, officeleri sun.
        }
    
}

