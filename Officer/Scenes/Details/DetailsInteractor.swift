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
    var videoURL: URL? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkingLogic = DetailsWorker()
    var officeData: OfficeData? //Request&Response modeldeki Modelimizin kendisi.
    var videoURL: URL?
    
    func fetchDetails(request: Details.Fetch.Request) {
        
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            //interactor?.getAlert(request: .init(alertTitle: "Error", alertMessage: "Video Not Found! Please try again later", actionTitle: "OK"))
            debugPrint("video not found")
            return
        }
        
        videoURL = URL(fileURLWithPath: path)
        
        self.presenter?.presentDetails(response: .init(officeDetail: officeData, videoURL: videoURL))
    }
    
    func getAlert(request: Alert.Fetch.Request) {
        presenter?.presentAlert(response: .init(alertTitle: request.alertTitle, alertMessage: request.alertMessage, actionTitle: request.alertMessage))
    }
    
    
}
