//
//  Extensions.swift
//  Officer
//
//  Created by Furkan Eruçar on 25.07.2022.
//

import Foundation
import UIKit


//MARK: - WelcomeViewController Border Color
extension WelcomeViewController {
    func buttonsBorderColors() {
        registerButton.layer.borderColor = UIColor(named: C.borderColor)?.cgColor
        loginButton.layer.borderColor = UIColor(named: C.borderColor)?.cgColor
        
        
    }
}
