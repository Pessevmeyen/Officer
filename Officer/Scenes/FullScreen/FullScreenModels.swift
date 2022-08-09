//
//  FullScreenModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum FullScreen {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let images: [String]?
            let selectedIndex: Int?
        }
        
        struct ViewModel {
            
            let selectedIndex: Int
            let images: [String]
           
        }
    }
}
// swiftlint:enable nesting
