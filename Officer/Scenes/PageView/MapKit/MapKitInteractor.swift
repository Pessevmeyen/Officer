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
}

final class MapKitInteractor: MapKitBusinessLogic, MapKitDataStore {
    
    var presenter: MapKitPresentationLogic?
    var worker: MapKitWorkingLogic = MapKitWorker()
    var locationData: OfficeData?
    
    
    func fetchData(request: MapKit.Fetch.Request) {
        self.presenter?.presentMapKit(response: .init(officeMapKit: locationData))
        print(request)
    }
    
}
