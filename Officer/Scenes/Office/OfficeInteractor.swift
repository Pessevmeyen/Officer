//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeBusinessLogic: AnyObject {
    func fetchData(request: Office.Fetch.Request)
    func fetchDataAfterFetched()
    func fetchFilter(request: String)
}

protocol OfficeDataStore: AnyObject {
    var offices: OfficeDataArray? { get set } //Daha sonra router ile veri aktarımı için verileri tutuyoruz burada.
    var filteredOffices: OfficeDataArray? { get set } //Workerdan gelen response verisi buraya aktarılıyor.
}

final class OfficeInteractor: OfficeBusinessLogic, OfficeDataStore {

    var presenter: OfficePresentationLogic?
    var worker: OfficeWorkingLogic = OfficeWorker()
    
    init(worker: OfficeWorkingLogic) {
        self.worker = worker
    }
    
    var offices: OfficeDataArray? //Workerdan gelen response verisi buraya aktarılıyor.
    var filteredOffices: OfficeDataArray? //Filtreden gelen verilerin officeleri
    
    //2
    func fetchData(request: Office.Fetch.Request) { //interactor da worker'a diyor, office listesini getir.
        worker.getRequestedData { [weak self] result in
            switch result {
            case .success(let response):
                self?.offices = response //işlem kolaylığı açısından, office datalarını çektiğimiz için office diye isimlendirebiliriz bu datayı.
                //guard let offices = self?.offices else { return } //Optional gelen veriyi güvenli hale getiriyoruz.
                self?.filteredOffices = response
                guard let offices = self?.offices else { return }
                
                //Coredatayı kontrol et logic yaz isLike durumuna bak. aldıktan sonra presenter'a
                
                self?.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: offices)) //Buradan presenter'a
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchDataAfterFetched() {
        guard let offices = self.offices else { return }
        self.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: offices)) //Buradan presenter'a
        print(offices)
    }
    
    
    func fetchFilter(request: String) {
        let filteredData = filteredOffices?.filter { filter in
            
            return filter.space == request || filter.capacity == request || String(filter.rooms ?? 0) == request
            //Seçilmediyse nasıl hepsini göstericez?
        }
        
        //itemlist gönderilecek
        guard let filteredData = filteredData else { return }
        
        self.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: (filteredData))) //Buradan presenter'a aktarılıyor.
        //print(filteredData)
    }
    
}

