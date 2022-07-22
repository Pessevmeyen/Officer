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
        
        appNameLabel.text = C.appName
        
        // Do any additional setup after loading the view.
        registerButton.titleLabel?.textColor = .init(white: 1.0, alpha: 1.0)
        loginButton.titleLabel?.textColor = .init(white: 1.0, alpha: 1.0)
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apear")
        registerButton.titleLabel?.textColor = UIColor(white: 1.0, alpha: 1.0)
    }
    
    

}

