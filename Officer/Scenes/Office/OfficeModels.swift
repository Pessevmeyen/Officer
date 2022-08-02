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
        
        struct Request {
            let result: String
        }
        
        struct Response {
            var offices: [Offices]
            
        }
        
        struct ViewModel {
            let news: [Office.Fetch.ViewModel.New]
            
            struct New {
                let name: String?
                let title: String?
                let image: String?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
