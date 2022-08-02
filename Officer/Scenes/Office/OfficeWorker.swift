//
//  OfficeWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeWorkingLogic: AnyObject {
    func getOfficesList() //
}

final class OfficeWorker: OfficeWorkingLogic {
    
    
    //worker'ın işi api'a gitmek
    //3
    func getOfficesList() {
        //worker burada verileri getirecek. Getirirse return ile interactor içindeki closure'a dönecek.
        
    }
    
}
