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
        
        worker.getPassword(account: email) { [weak self] result in
            switch result {
            case .success(let password):
                self?.presenter?.presentPassword(response: .init(password: password))
            case .failure(let error):
                self?.presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: "OK"))
            }
        }
    }
}

