//
//  RegisterModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Register {
    
    enum Fetch {
        
        struct Request {
            let email: String?
            var password: String?
        }
        
        struct Response {
            let alertTitle: String?
            let alertMessage: String?
            let actionTitle: String?
        }
        
        struct ViewModel {
            
        }
        
    }
    
}
// swiftlint:enable nesting
