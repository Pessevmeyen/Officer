//
//  LoginViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    
}

final class LoginViewController: UIViewController {
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var logInButton: UIButton!
    
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
        
        hideKeyboardWhenTappedAround()
        
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    @IBAction func logInClicked(_ sender: UIButton) {
        goToDestinationVC(storyboardName: C.officeStoryboardName, storyboardID: C.officeStoryboardIdentifier)
    }
}

extension LoginViewController: LoginDisplayLogic {
    
}
