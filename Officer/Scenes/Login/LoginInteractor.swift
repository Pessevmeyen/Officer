//
//  LoginInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func fetchPassword(request: Login.Fetch.Request)
    func fetchRegisteredUser(request: Login.Fetch.Request)
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    var password: String?
    
    func fetchPassword(request: Login.Fetch.Request) {
        
        guard let email = request.email else {
            return
        }
        
        worker.getPassword(account: email) { [weak self] result in
            switch result {
            case .success(let password):
                self?.password = password
                self?.presenter?.presentPassword(response: .init(password: password))
            case .failure(let error):
                self?.presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: error.localizedDescription, actionTitle: "OK"))
            }
        }
    }
    
    func fetchRegisteredUser(request: Login.Fetch.Request) {
        guard let email = request.email,
              let password = request.password else {
            return
        }
        
        if email.isEmpty && password.isEmpty {
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "E-mail and Password Must be Filled!", actionTitle: "OK"))
        } else if !email.isEmpty && password.isEmpty {
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "Password Must be Filled!", actionTitle: "OK"))
        } else if self.password == password {
            presenter?.presentOfficePage()
        } else {
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "E-mail or Password is Wrong!", actionTitle: "OK"))
        }
    }
}

