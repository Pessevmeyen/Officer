//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeBusinessLogic: AnyObject {
    func fetchData(request: Office.Fetch.Request)
    func fetchFilter(request: String)
}

protocol OfficeDataStore: AnyObject {
    var offices: OfficeDataArray? { get set } //Daha sonra router ile veri aktarımı için verileri tutuyoruz burada. Request&Response modeli Array içinde tutuyoruz.
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {

    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    init(worker: OfficeWorkingLogic) {
        self.worker = worker
    }
    
    var offices: OfficeDataArray? //Workerdan gelen response verisi buraya aktarılıyor.
    
    //2
    func fetchData(request: Office.Fetch.Request) { //interactor da worker'a diyor, office listesini getir.
        worker.getRequestedData { [weak self] result in
            switch result {
            case .success(let response):
                self?.offices = response //işlem kolaylığı açısından, office datalarını çektiğimiz için office diye isimlendirebiliriz bu datayı.
                guard let offices = self?.offices else { return } //Optional gelen veriyi güvenli hale getiriyoruz.
                self?.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: offices)) //Buradan presenter'a aktarılıyor. //getirdikten sonra presenter'a diyor ki, officeleri sun.
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchFilter(request: String) {
        let filteredData = offices?.filter { filter in
            
            //guard let filterData = self.offices else { return true }
            
//            switch filter {
//            case filter == OfficeData
//                return filter.capacity == request
//            case 2 :
//                return filter.space == request
//            case 3 :
//                return filter.rooms == request
//            default:
//                break
//
//            }
            
            return filter.space == request || filter.capacity == request || String(filter.rooms ?? 0) == request
        }
        guard let filteredData = filteredData else { return }
        self.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: (filteredData))) //Buradan presenter'a aktarılıyor.
        print(filteredData)
    }
    
}

