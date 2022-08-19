//
//  MapKitInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitBusinessLogic: AnyObject {
    
}

protocol MapKitDataStore: AnyObject {
    
}

final class MapKitInteractor: MapKitBusinessLogic, MapKitDataStore {
    
    var presenter: MapKitPresentationLogic?
    var worker: MapKitWorkingLogic = MapKitWorker()
    
}
