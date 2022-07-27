//
//  Extensions.swift
//  Officer
//
//  Created by Furkan Eruçar on 25.07.2022.
//

import Foundation
import UIKit


//MARK: - WelcomeViewController's Buttons Border Color
extension WelcomeViewController {
    func buttonsBorderColors() {
        registerButton.layer.borderColor = UIColor(named: C.borderColor)?.cgColor
        loginButton.layer.borderColor = UIColor(named: C.borderColor)?.cgColor
    }
}



//MARK: - For Hiding Keyboard When User Tapped Around
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



// MARK: - Place Holder Text Color Section in Storyboard
extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : newValue!])
        }
    }
}
