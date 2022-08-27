//
//  RegisterViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func displayAlert(alertTitle: String, actionTitle: String, message: String)
    func displayOfficePage()
}

final class RegisterViewController: UIViewController {
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.appName
        
        hideKeyboardWhenTappedAround()
        
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        interactor?.registerKeychain(request: .init(email: emailTextField.text, password: emailTextField.text))
    }
}


//MARK: Display Logic
extension RegisterViewController: RegisterDisplayLogic {
    
    func displayAlert(alertTitle: String, actionTitle: String, message: String) {
        getAlert(alertTitle: alertTitle, actionTitle: actionTitle, message: message)
    }
    func displayOfficePage() {
        router?.routeToOfficePage()
    }
}
