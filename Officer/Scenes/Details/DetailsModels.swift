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
            let videoURL: URL?
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
            var latitude: Double?
            var longitude: Double?
            let videoURL: URL?
            
        }
    }
}
// swiftlint:enable nesting
