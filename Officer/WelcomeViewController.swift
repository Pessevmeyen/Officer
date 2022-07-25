//
//  ViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 4.07.2022.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: CLTypingLabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUi()
        
        buttonsBorderColors()
        
        
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        buttonsBorderColors()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apear")
        registerButton.titleLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
    }
    
    //MARK: - All properties that UI  is loaded first time.
    func setupUi() {
        
        appNameLabel.text = C.appName
        
        registerButton.layer.borderWidth = CGFloat(1)
        loginButton.layer.borderWidth = CGFloat(1)
        
        registerButton.titleLabel?.textColor = .init(white: 1.0, alpha: 1.0)
        loginButton.titleLabel?.textColor = .init(white: 1.0, alpha: 1.0)
    }
    
    

}





