//
//  FavoriteScreenInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenBusinessLogic: AnyObject {
    func fetchData(request: FullScreen.Fetch.Request)
}

protocol FavoriteScreenDataStore: AnyObject {
    
}

final class FavoriteScreenInteractor: FavoriteScreenBusinessLogic, FavoriteScreenDataStore {
    
    var presenter: FavoriteScreenPresentationLogic?
    var worker: FavoriteScreenWorkingLogic = FavoriteScreenWorker()
    
    func fetchData(request: FullScreen.Fetch.Request) {
        
    }
    
    
    
}
