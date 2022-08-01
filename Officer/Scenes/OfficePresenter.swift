//
//  OfficePresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol OfficePresentationLogic: AnyObject {
    func presentNews()
}

final class OfficePresenter: OfficePresentationLogic {
    
    weak var viewController: OfficeDisplayLogic?
    
    //4
    func presentNews() {
        //Gelen veriler burada formatlanacak, şekil verilecek.
        var news: [Office.Fetch.ViewModel.New] = []
        viewController?.displayNews(viewModel: Office.Fetch.ViewModel(news: news))
    }
}
