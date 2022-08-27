//
//  RegisterInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//


import UIKit

protocol RegisterBusinessLogic: AnyObject {
    func registerKeychain(request: Register.Fetch.Request)
}

protocol RegisterDataStore: AnyObject {
    
}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()
    
    func registerKeychain(request: Register.Fetch.Request) {
        guard let email = request.email,
              let password = request.password,
              !email.isEmpty, !password.isEmpty else {
            
            presenter?.presentAlert(response: .init(alertTitle: "Error", alertMessage: "E-mail and Password Must be Filled!", actionTitle: "Try Again"))
            return
        }
        
        //Save data to keychain
        do {
            try KeychainManager.save(service: "mobven.com", account: email, password: (password.data(using: .utf8))!)
            print("saved")
        } catch {
            print(error)
        }
        
        presenter?.presentOfficePage(response: .init(alertTitle: "Successfully Registered", alertMessage: "You have Redirected to Login Page, Log in with Your Brand New Account", actionTitle: "OK"))
        
    }
    
}
