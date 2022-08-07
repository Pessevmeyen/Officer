//
//  OfficeWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeWorkingLogic: AnyObject {
    func getOfficesList(_ completion: @escaping ((Result<Offices, Error>) -> Void)) //Workerda çağırmamız gereken func bu, parametresiyle birlikte.
}

final class OfficeWorker: OfficeWorkingLogic {
    
    
    //worker'ın işi api'a gitmek
    //3
    func getOfficesList(_ completion: @escaping ((Result<Offices, Error>) -> Void)) {
        //worker burada verileri getirecek. Getirirse return ile interactor içindeki closure'a dönecek.
        NetworkManager.shared.fetch(decode: Offices.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
                print(response)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
