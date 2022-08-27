//
//  LoginInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func fetchPassword(request: Login.Fetch.Request)
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
    func fetchPassword(request: Login.Fetch.Request) {
        
        guard let email = request.email else {
            return
        }
        
        worker.getPassword(email: email) { [weak self] password in
                self?.presenter?.presentPassword(response: .init(password: password))
            }
        }
}

