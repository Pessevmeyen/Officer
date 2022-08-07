//
//  FullScreenInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import Foundation

protocol FullScreenBusinessLogic: AnyObject {
    func fetchData(request: FullScreen.Fetch.Request)
}

protocol FullScreenDataStore: AnyObject {
    var fullScreenData: OfficeData? { get set }
}

final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
    var fullScreenData: OfficeData?
    
    func fetchData(request: FullScreen.Fetch.Request) {
        self.presenter?.presentFullScreen(response: .init(officeDetail: fullScreenData))
    }
    
}
