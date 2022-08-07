//
//  FullScreenViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import UIKit
import SDWebImage

protocol FullScreenDisplayLogic: AnyObject {
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel)
}

final class FullScreenViewController: UIViewController {
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    var FullScreenViewModel: FullScreen.Fetch.ViewModel?
    
    @IBOutlet weak var FullScreenImageView: UIImageView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchData(request: FullScreen.Fetch.Request())
        configureFullScreen(viewModel: FullScreen.Fetch.ViewModel(images: FullScreenViewModel?.images ?? []))
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FullScreenInteractor()
        let presenter = FullScreenPresenter()
        let router = FullScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func configureFullScreen(viewModel: FullScreen.Fetch.ViewModel) {
        for singleImage in viewModel.images { //Array halinde gelen image datalarını tek tek ekrana bastırmak için for kullandık. forEach veya map'da olurdu.
            //imageViewButton.sd_setImage(with: URL(string: singleImage), for: .normal)
            FullScreenImageView.sd_setImage(with: URL(string: singleImage)) //Array'i direk gösteremeyiz çünkü.
            print(singleImage)
        }
    }
}

extension FullScreenViewController: FullScreenDisplayLogic {
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel) {
        self.FullScreenViewModel = viewModel
        
        
    }
    
}
