//
//  Alert.swift
//  Officer
//
//  Created by Furkan Eruçar on 28.08.2022.
//

import Foundation

enum Alert {
    
    enum Fetch {
        
        struct Request {
            let alertTitle: String?
            let alertMessage: String?
            let actionTitle: String?
        }
        
        struct Response {
            let alertTitle: String?
            let alertMessage: String?
            let actionTitle: String?
        }
    }
}
