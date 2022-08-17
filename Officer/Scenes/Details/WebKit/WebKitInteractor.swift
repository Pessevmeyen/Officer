//
//  WebKitInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import Foundation

protocol WebKitBusinessLogic: AnyObject {
    
}

protocol WebKitDataStore: AnyObject {
    
}

final class WebKitInteractor: WebKitBusinessLogic, WebKitDataStore {
    
    var presenter: WebKitPresentationLogic?
    var worker: WebKitWorkingLogic = WebKitWorker()
    
}
