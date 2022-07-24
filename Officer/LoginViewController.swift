//
//  LoginViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 22.07.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func logInClicked(_ sender: UIButton) {
    
        if emailTextField.text != "" && passwordTextField.text != "" { // bu kontrolleri sonra auth ile yapıcaz.
            logInButton.isUserInteractionEnabled = false // Kullanıcı birden fazla tıklayamasın diye.
            //UIInputViewController().dismissKeyboard() //Kullanıcı buttona tıkladığında klavye otomatik kaybolacak.
        }
        
        
        print("login clicked")
        
    }
    
}

