//
//  FavoriteScreenPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import Foundation

protocol FavoriteScreenPresentationLogic: AnyObject {
    func presentCoreData(response: [FavoriteScreen.Fetch.ViewModel.CoreDataModels])
}

final class FavoriteScreenPresenter: FavoriteScreenPresentationLogic {
    
    weak var viewController: FavoriteScreenDisplayLogic?
    
    func presentCoreData(response: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]) {
        viewController?.displayCoreData(viewModel: response)
    }

}
