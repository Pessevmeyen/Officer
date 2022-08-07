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
            let officeDetail: OfficeData?
        }
        
        struct ViewModel {

            let images: [String]
           
        }
    }
}
// swiftlint:enable nesting
