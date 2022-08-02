//
//  RegisterRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol RegisterRoutingLogic: AnyObject {
    
}

protocol RegisterDataPassing: class {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
}
