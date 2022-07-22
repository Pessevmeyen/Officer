//
//  ViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 4.07.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let showVersion = (Bundle.main.infoDictionary?["SHOW_VERSION"] as? String) == "YES"
        if showVersion {
            // TODO: show version label
        } else {
            // hide
        }
        
    }
    

}

