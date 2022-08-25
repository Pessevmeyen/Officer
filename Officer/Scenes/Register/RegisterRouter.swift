//
//  RegisterRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol RegisterRoutingLogic: AnyObject {
    func routeToOfficePage()
}

protocol RegisterDataPassing: AnyObject {
    var dataStore: RegisterDataStore? { get }
}

final class RegisterRouter: RegisterRoutingLogic, RegisterDataPassing {
    
    weak var viewController: RegisterViewController?
    var dataStore: RegisterDataStore?
    
    func routeToOfficePage() {
        self.viewController?.navigationController?.pushViewController(PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
    }
    
}
