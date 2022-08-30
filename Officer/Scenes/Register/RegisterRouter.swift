//
//  RegisterRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation
import UIKit

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
        let storyboard = UIStoryboard(name: Constants.loginStoryboardName, bundle: nil)
        let destVC: LoginViewController = storyboard.instantiateViewController(identifier: Constants.loginIdentifier)
        destVC.modalPresentationStyle = .overFullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
}
