//
//  MapKitModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum MapKit {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let officeMapKit: OfficeData?
        }
        
        struct ViewModel {
            var id: Int?
            var image: String?
            var name: String?
            var address: String?
            var latitude: Double?
            var longitude: Double?
        }
        
    }
    
}
// swiftlint:enable nesting
