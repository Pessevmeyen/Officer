//
//  MapKitInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitBusinessLogic: AnyObject {
    func fetchData(request: MapKit.Fetch.Request)
}

protocol MapKitDataStore: AnyObject {
    var locationData: OfficeData? { get set }
    var officeArray: OfficeDataArray? { get set }
}

final class MapKitInteractor: MapKitBusinessLogic, MapKitDataStore {
    
    var presenter: MapKitPresentationLogic?
    var worker: MapKitWorkingLogic = MapKitWorker()
    var locationData: OfficeData?
    var officeArray: OfficeDataArray?
    
    
    func fetchData(request: MapKit.Fetch.Request) {
        //self.presenter?.presentMapKit(response: .init(officeMapKit: locationData))
        worker.getRequestedData { [weak self] result in
            
            switch result {
            case .success(let response):
                self?.officeArray = response
                guard let officeArray = self?.officeArray else {
                    return
                }
                self?.presenter?.presentMapKit(response: .init(officeResponse: officeArray))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
