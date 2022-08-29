//
//  OfficeInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//


import UIKit
import CoreData

protocol OfficeBusinessLogic: AnyObject {
    func fetchData(request: Office.Fetch.Request)
    func fetchDataAfterFetched()
    func fetchFilter(request: String)
    func fetchDataFromCoreData(reqeust: [Int])
    func saveDataToCoreData(model: Office.Fetch.ViewModel.OfficeModel)
    func deleteFromCoreData(modelID: Int)
    func fetchFilterConstants(filterConstants: [FilterItems])
    func getAlert()
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
    
    //MARK: Fetching Data Process
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
//                CoreDataManager.shared.getFromCoreData { result in
//                    switch result {
//                    case .success(let officeIds):
//                        break
//                    case .failure(let error):
//                        //bi öncepresenter.presentError(message: error.localizedDescription)
//                    }
//                }
                
                self?.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: offices)) //Buradan presenter'a
            case .failure(let error):
                self?.presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: "OK"))
                
            }
        }
        
        
    }
    
    
    
    //Filtreleme bittikten sonra api'a tekrar gitmeden bütün dataları çağırıyoruz.
    func fetchDataAfterFetched() {
        guard let offices = self.offices else { return }
        self.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: offices)) //Buradan presenter'a
        print(offices)
    }
    
    
    
    //filter ettikten sonra göstereceğimiz dataları çağırıyoruz.
    func fetchFilter(request: String) {
        let filteredData = filteredOffices?.filter { filter in
            return filter.space == request || filter.capacity == request || String(filter.rooms ?? 0) == request
        }
        //itemlist gönderilecek
        guard let filteredData = filteredData else {
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "An error occured when filtering. Please try again later", actionTitle: "OK"))
            fatalError()
        }
        self.presenter?.presentRespondedData(response: Office.Fetch.Response(officeResponse: (filteredData))) //Buradan presenter'a aktarılıyor.
        //print(filteredData)
    }
    
    func fetchFilterConstants(filterConstants: [FilterItems]) {
        worker.getFilterConstans { [weak self] result in
            self?.presenter?.presentFilterConstants(filterConstants: result)
        }
    }
    
    
    
    //MARK: Core Data Process
    func saveDataToCoreData(model: Office.Fetch.ViewModel.OfficeModel) {
        worker.saveToCoreData(model: model)
    }
    
    //Cellde göstereceğimiz dataları çağırıyoruz.
    func fetchDataFromCoreData(reqeust: [Int]) {
        worker.getDataFromCoreData { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentCoreData(response: response)
            case .failure(let error):
                self?.presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: "OK"))
            }
        }
    }
    
    func deleteFromCoreData(modelID: Int) {
        worker.deleteDatasFromCoreData(modelID: modelID)
    }
    
    func getAlert() {
        presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "An error occured when occuring cells. Please Pull to Refresh or Try Again Later", actionTitle: "OK"))
    }
    
}
