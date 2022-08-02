//
//  RegisterInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol RegisterBusinessLogic: AnyObject {
    
}

protocol RegisterDataStore: AnyObject {
    
}

final class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorkingLogic = RegisterWorker()
    
}
