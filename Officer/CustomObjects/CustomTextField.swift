//
//  CustomTextField.swift
//  Officer
//
//  Created by Furkan Eruçar on 22.07.2022.
//

import UIKit


//MARK: - Custom Text Field to changing placeholder color by stoyboard
class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
            customTextField()
    }

    fileprivate func customTextField() {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = UIColor(named: Constants.underlineColor)
        addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
}



