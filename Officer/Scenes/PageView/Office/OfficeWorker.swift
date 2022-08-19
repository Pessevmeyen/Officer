//
//  OfficeWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeWorkingLogic: AnyObject {
    func getRequestedData(_ completion: @escaping ((Result<OfficeDataArray, Error>) -> Void)) //Workerda çağırmamız gereken func bu, parametresiyle birlikte.
}

final class OfficeWorker: OfficeWorkingLogic {
    
    
    //worker'ın işi api'a gitmek
    //3
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
