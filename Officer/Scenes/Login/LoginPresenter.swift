//
//  LoginPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentPassword(response: Login.Fetch.Response)
    func presentAlert(response: Alert.Fetch.Response)
}

final class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentPassword(response: Login.Fetch.Response) {
        viewController?.displayPassword(password: response.password ?? "")
    }
    
    func presentAlert(response: Alert.Fetch.Response) {
        viewController?.displayAlert(alertTitle: response.alertTitle ?? "Error",
                                     actionTitle: response.actionTitle ?? "OK",
                                     message: response.alertMessage ?? "Error")
    }
    
}
