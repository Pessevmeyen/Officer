//
//  OfficeWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficeWorkingLogic: AnyObject {
    func getNews(request: OfficeRequestModel, completion: @escaping ((Result<OfficeResponseModel, Error>) -> Void))
}

final class OfficeWorker: OfficeWorkingLogic {
    
    //3
    func getNews(request: OfficeRequestModel, completion: @escaping ((Result<OfficeResponseModel, Error>) -> Void)) {
        //worker burada verileri getirecek. Getirirse return ile interactor içindeki closure'a dönecek.
    }
    
}
