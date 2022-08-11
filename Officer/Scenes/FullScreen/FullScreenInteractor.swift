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
    var officeImages: OfficeData? { get set }
    var selectedIndex: Int? { get set }
}

final class FullScreenInteractor: FullScreenBusinessLogic, FullScreenDataStore {
    
    var presenter: FullScreenPresentationLogic?
    var worker: FullScreenWorkingLogic = FullScreenWorker()
    
    var officeImages: OfficeData?
    var selectedIndex: Int?
    
    func fetchData(request: FullScreen.Fetch.Request) {
        presenter?.presentFullScreen(response: FullScreen.Fetch.Response(images: officeImages?.images, selectedIndex: selectedIndex))
    }
    
}
