//
//  DetailsInteractor.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func fetchDetails(request: Details.Fetch.Request)
    func getAlert(request: Alert.Fetch.Request)
}

protocol DetailsDataStore: AnyObject {
    var officeData: OfficeData? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    var officeData: OfficeData? //Request&Response modeldeki Modelimizin kendisi.
    
    func fetchDetails(request: Details.Fetch.Request) {
        self.presenter?.presentDetails(response: .init(officeDetail: officeData))
    }
    
    func getAlert(request: Alert.Fetch.Request) {
        presenter?.presentAlert(response: .init(alertTitle: request.alertTitle, alertMessage: request.alertMessage, actionTitle: request.alertMessage))
    }
    
    
}
