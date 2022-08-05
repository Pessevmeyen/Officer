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
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }
        
        setupUI()
        
        buttonsBorderColors()
        
        
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection) // super ekledik sorun çıkarıcak mı bak?
        buttonsBorderColors() //Buna gerek var mı? kodu kaldırıp IBInspectable ile eklediğini dene
        
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        goToDestinationVC(storyboardName: C.registerStoryboardName, storyboardID: C.registerStoryboardIdentifier)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        goToDestinationVC(storyboardName: C.loginStoryboardName, storyboardID: C.loginStoryboardIdentifier)
    }
    
    
    //MARK: - All properties that UI is loaded first time.
    func setupUI() {
        
        appNameLabel.text = C.appName
        
        //MARK: Register Button Attributes
        registerButton.layer.cornerRadius = 35
        registerButton.layer.borderWidth = CGFloat(2)
        
        
        //MARK: Login Button Attributes
        loginButton.layer.cornerRadius = 35
        loginButton.layer.borderWidth = CGFloat(2)
        
        
        //MARK: App Name Attributes.
        //Added with @IBInspectable but didn't like neon effect, so was wroten here.
        appNameLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        appNameLabel.layer.shadowColor = UIColor.systemBackground.cgColor
        appNameLabel.layer.shadowRadius = 4
        appNameLabel.layer.shadowOpacity = 1
        appNameLabel.layer.masksToBounds = false
    }
    
    

}





