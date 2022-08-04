//
//  DetailsInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func fetchDetails()
}

protocol DetailsDataStore: AnyObject {
    var offices: OfficeData? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var offices: OfficeData? //Request&Response modeldeki Modelimizin kendisi.
    
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    
    func fetchDetails() {
        print(offices)
    }
    
    
    
    
}
