//
//  DetailsInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    
}

protocol DetailsDataStore: AnyObject {
    
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    
}
