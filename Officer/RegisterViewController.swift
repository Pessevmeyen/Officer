//
//  RegisterViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 22.07.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // passwordTextField.textContentType = .oneTimeCode // This provides password autofill label alert when user writing password.
        
        hideKeyboardWhenTappedAround()
        
        
        
    }

    @IBAction func signInClicked(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" { // bu kontrolleri sonra auth ile yapıcaz.
            signInButton.isUserInteractionEnabled = false // Kullanıcı birden fazla tıklayamasın diye.
            //UIInputViewController().dismissKeyboard() //Kullanıcı buttona tıkladığında klavye otomatik kaybolacak.
        }
        
        print("sign in clicked")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
