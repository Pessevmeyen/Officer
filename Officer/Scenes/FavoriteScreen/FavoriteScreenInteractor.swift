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
    var dataStore: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]? { get set }
}

final class FavoriteScreenInteractor: FavoriteScreenBusinessLogic, FavoriteScreenDataStore {
    
    var presenter: FavoriteScreenPresentationLogic?
    var worker: FavoriteScreenWorkingLogic = FavoriteScreenWorker()
    var dataStore: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]?
    
    func fetchCoreData() {
        worker.getCoreData { [weak self] response in
            switch response {
            case .success(let coreDataOffices):
                self?.presenter?.presentCoreData(response: coreDataOffices)
                self?.dataStore = coreDataOffices
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteFromCoreData(id: Int) {
        worker.deleteDataFromCoreData(id: id)
    }
    
}
