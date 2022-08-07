//
//  FullScreenPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import Foundation

protocol FullScreenPresentationLogic: AnyObject {
    func presentFullScreen(response: FullScreen.Fetch.Response)
}

final class FullScreenPresenter: FullScreenPresentationLogic {
    
    weak var viewController: FullScreenDisplayLogic?
    
    func presentFullScreen(response: FullScreen.Fetch.Response) {
        let office = response.officeDetail
        viewController?.displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel(images: office?.images ?? []))
        
    }
    
}
