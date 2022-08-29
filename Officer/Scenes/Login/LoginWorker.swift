//
//  LoginWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func getPassword(account: String, completion: @escaping ((Result<String, Error>) -> Void))
}

final class LoginWorker: LoginWorkingLogic {
    
    func getPassword(account: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        
        //Get Data from keychain
        guard let data = KeychainManager.get(account: account) else {
            print("There is No Registered Account")
            return
        }
        
        //Get password from keychain
        let returnedPassword = String(decoding: data, as: UTF8.self)
        completion(.success(returnedPassword))
    }
    
}
