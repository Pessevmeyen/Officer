//
//  FavoriteScreenInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenBusinessLogic: AnyObject {
    func fetchCoreData()
    func deleteFromCoreData(id: Int)
}

protocol FavoriteScreenDataStore: AnyObject {
}

final class FavoriteScreenInteractor: FavoriteScreenBusinessLogic, FavoriteScreenDataStore {
    
    var presenter: FavoriteScreenPresentationLogic?
    var worker: FavoriteScreenWorkingLogic = FavoriteScreenWorker()
    
    func fetchCoreData() {
        worker.getCoreData { [weak self] response in
            switch response {
            case .success(let coreDataOffices):
                self?.presenter?.presentCoreData(response: coreDataOffices)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteFromCoreData(id: Int) {
        worker.deleteDataFromCoreData(id: id)
    }
    
}
