//
//  LoginModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Login {
    
    enum Fetch {
        
        struct Request {
            let email: String?
            var password: String?
        }
        
        struct Response {
            let password: String?
        }
        
        struct ViewModel {
            let password: String?
        }
        
    }
    
}
// swiftlint:enable nesting
