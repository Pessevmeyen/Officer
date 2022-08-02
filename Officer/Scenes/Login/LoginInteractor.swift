//
//  LoginInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
}
