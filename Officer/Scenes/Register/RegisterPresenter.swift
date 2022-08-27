//
//  RegisterPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol RegisterPresentationLogic: AnyObject {
    func presentOfficePage()
    func presentAlert(response: Register.Fetch.Response)
    
}

final class RegisterPresenter: RegisterPresentationLogic {
    
    weak var viewController: RegisterDisplayLogic?
    
    func presentAlert(response: Register.Fetch.Response) {
        viewController?.displayAlert(alertTitle: response.alertTitle ?? "",
                                     actionTitle: response.actionTitle ?? "",
                                     message: response.alertMessage ?? "")
    }
    
    func presentOfficePage() {
        viewController?.displayOfficePage()
    }
    
}
