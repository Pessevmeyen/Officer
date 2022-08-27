//
//  LoginRouter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit

protocol LoginRoutingLogic: AnyObject {
    func routeToOfficePage()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToOfficePage() {
        //self.viewController?.navigationController?.pushViewController(PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal), animated: true)
        let storyboard = UIStoryboard(name: Constants.detailsStoryboardName, bundle: nil)
        let destVC: DetailsViewController = storyboard.instantiateViewController(identifier: Constants.detailsIdentifier)
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
