//
//  DetailsModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Details {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let officeDetail: OfficeData?
        }
        
        struct ViewModel {

            let id: Int?
            let image: String?
            let images: [String]?
            let name: String?
            let address: String?
            let capacity: String?
            let rooms: String?
            let space: String?
            
        }
    }
}
// swiftlint:enable nesting
