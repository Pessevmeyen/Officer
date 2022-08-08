//
//  OfficeModels.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Office {
    
    enum Fetch {
        
        struct Request {//interacter'ın ihtiyacı olan request
            //let result: String
        }
        
        struct Response { //presenter'ın ihtiyacı olan response
            var officeResponse: [OfficeData]
        }
        
        struct ViewModel { //Neyi göstereceksek. ViewController'ın ihtiyacı olan viewModel
            
            let officesListViewModel: [Office.Fetch.ViewModel.OfficeModel]
            
            struct OfficeModel {
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
    
}
// swiftlint:enable nesting
