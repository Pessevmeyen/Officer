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
        registerButton.layer.borderColor = UIColor(named: Constants.borderColor)?.cgColor
        loginButton.layer.borderColor = UIColor(named: Constants.borderColor)?.cgColor
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





//MARK: - Hides Back Button
extension UIViewController {
    func setHidesBackBarButton() {
        navigationItem.setHidesBackButton(true, animated: true) //Back button'ı iptal ediyoruz ki giriş yaptıktan sonra tekrar giriş ekranına dönülmesin.
    }
}





//MARK: - Changing View Controller
extension UIViewController {
    
    func goToDestinationVC(storyboardName: String, storyboardID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationVC = storyboard.instantiateViewController(identifier: storyboardID)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func goToDestinationVCPopUp(storyboardName: String, storyboardID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let destinationVC = storyboard.instantiateViewController(identifier: storyboardID)
        present(destinationVC, animated: true)
    }
    
    
}

extension UIViewController {
    
    func getAlert(alertTitle: String, actionTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
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



//MARK: - Register Nibs
//MARK: Table View
extension OfficeViewController {
    func registerTableView() {
        tableView.register(UINib(nibName: Constants.officeNibName, bundle: .main), forCellReuseIdentifier: Constants.officeCellIdentifier)
    }
}
//MARK: Detail Collection View
extension DetailsViewController {
    func registerCollectionView() {
        collectionView.register(UINib(nibName: Constants.detailsNibName, bundle: .main), forCellWithReuseIdentifier: Constants.detailsCellReuseIdentifier)
    }
}
//MARK: Favorite Screen Table View
extension FavoriteScreenViewController {
    func registerFavoriteTableView() {
        tableView.register(UINib(nibName: Constants.favoriteScreenNibName, bundle: .main), forCellReuseIdentifier: Constants.favoriteScreenCellIdentifier)
    }
}


//MARK: - Button Shadow and Border Attributes in StoryBoard
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
