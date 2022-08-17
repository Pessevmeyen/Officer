//
//  WebKitViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import UIKit
import WebKit

protocol WebKitDisplayLogic: AnyObject {
    
}

final class WebKitViewController: UIViewController {
    
    var interactor: WebKitBusinessLogic?
    var router: (WebKitRoutingLogic & WebKitDataPassing)?
    
    @IBOutlet weak var webView: WKWebView!
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
        let interactor = WebKitInteractor()
        let presenter = WebKitPresenter()
        let router = WebKitRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension WebKitViewController: WebKitDisplayLogic {
    
}
