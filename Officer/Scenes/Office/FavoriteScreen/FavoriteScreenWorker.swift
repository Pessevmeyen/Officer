//
//  FavoriteScreenWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenWorkingLogic: AnyObject {
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void))
}

final class FavoriteScreenWorker: FavoriteScreenWorkingLogic {
    
    func getCoreData(complation: @escaping ((Result<[Int], Error>) -> Void)) {
        CoreDataManager().getFromCoreData { result in
            switch result {
            case .success(let response):
                complation(.success(response))
            case .failure(let error):
                complation(.failure(error))
            }
        }
    }
    
}
