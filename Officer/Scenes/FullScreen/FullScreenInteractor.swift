//
//  FullScreenInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import Foundation

protocol FullScreenBusinessLogic: AnyObject {
    func fetchData()
}

protocol FullScreenDataStore: AnyObject {
    var fullScreenDataStore: Offices? { get set }
}

final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
    var fullScreenDataStore: Offices?
    
    func fetchData() {
        
    }
    
}
