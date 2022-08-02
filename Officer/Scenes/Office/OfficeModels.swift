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
            let result: String
        }
        
        struct Response { //presenter'ın ihtiyacı olan response
            var officesList: [Offices]
        }
        
        struct ViewModel { //Neyi göstereceksek. ViewController'ın ihtiyacı olan viewModel
            
            let officesList: [Office.Fetch.ViewModel.OfficeModel]
            
            struct OfficeModel {
                let name: String?
                let label: String?
                let image: String?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
