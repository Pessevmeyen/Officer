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
        
        struct Response { //presenter'ın ihtiyacı olan response
            var officeResponse: [OfficeData]
        }
        
        struct ViewModel { //Neyi göstereceksek. ViewController'ın ihtiyacı olan viewModel
            
            let officesListViewModel: [MapKit.Fetch.ViewModel.OfficeModel]
            
            struct OfficeModel {
                var image: String?
                var name: String?
                var address: String?
                var latitude: Double?
                var longitude: Double?
                
            }
        }
        
    }
    
}
// swiftlint:enable nesting
