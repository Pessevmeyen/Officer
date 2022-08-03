//
//  DetailsViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    
}

final class DetailsViewController: UIViewController {
    
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    
}
