//
//  FavoriteScreenWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenWorkingLogic: AnyObject {
    func getCoreData(complation: @escaping ((Result<[FavoriteScreen.Fetch.ViewModel.CoreDataModels], Error>) -> Void))
    func deleteDataFromCoreData(id: Int)
}

final class FavoriteScreenWorker: FavoriteScreenWorkingLogic {
    
    func getCoreData(complation: @escaping ((Result<[FavoriteScreen.Fetch.ViewModel.CoreDataModels], Error>) -> Void)) {
        CoreDataManager().getDataFromCoreData { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        }
    }
    
    func deleteDataFromCoreData(id: Int) {
        CoreDataManager().deleteFromCoreData(officeID: id)
    }
    
}
