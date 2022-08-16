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
                var id: Int?
                var image: String?
                var images: [String]?
                var name: String?
                var address: String?
                var capacity: String?
                var rooms: String?
                var space: String?

            }
        }
        
    }
    
}

struct FilterItems {
    let first: String?
    let second: [String]?
}
// swiftlint:enable nesting
