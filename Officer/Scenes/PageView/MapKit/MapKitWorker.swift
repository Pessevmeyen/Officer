//
//  MapKitWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitWorkingLogic: AnyObject {
    func getRequestedData(_ completion: @escaping ((Result<OfficeDataArray, Error>) -> Void))
}

final class MapKitWorker: MapKitWorkingLogic {
    
    func getRequestedData(_ completion: @escaping ((Result<OfficeDataArray, Error>) -> Void)) {
        //worker burada verileri getirecek. Getirirse return ile interactor içindeki closure'a dönecek.
        NetworkManager.shared.fetch(decode: OfficeDataArray.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
