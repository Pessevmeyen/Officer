//
//  LoginWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func getPassword(email: String, completion: @escaping ((Result<String, Error>) -> Void))
}

final class LoginWorker: LoginWorkingLogic {
    
    func getPassword(email: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        
        //Get Data from keychain
        guard let data = KeychainManager.get(service: "mobven.com" ,account: email) else {
            completion(.failure(Error.self as! Error))
            print("Failed to read password")
            return
        }
        
        //Get password from keychain
        let returnedPassword = String(decoding: data, as: UTF8.self)
        completion(.success(returnedPassword))
        
        
    }
    
}
