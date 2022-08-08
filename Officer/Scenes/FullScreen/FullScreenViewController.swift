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
    var viewModel: FullScreen.Fetch.ViewModel?
    
    //let imageView = UIImageView()
    
    //@IBOutlet weak var FullScreenImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.delegate = self
        
        scrollView.frame = view.frame
        
        interactor?.fetchData(request: FullScreen.Fetch.Request())
        configureFullScreen(viewModel: FullScreen.Fetch.ViewModel(images: viewModel?.images ?? []))
        
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
    
    //MARK: - Configure the Image View
    func configureFullScreen(viewModel: FullScreen.Fetch.ViewModel) {
        for i in 0..<viewModel.images.count {
            let imageView = UIImageView()
            let x = self.view.frame.size.width * CGFloat(i)
            let y = self.view.frame.size.width / 2
            imageView.frame = CGRect(x: x, y: y, width: self.view.frame.width, height: self.view.frame.height / 2)
            imageView.contentMode = .scaleAspectFit
            imageView.sd_setImage(with: URL(string: viewModel.images[i]))
            //imageView.borderWidth = 1
                    
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.isPagingEnabled = true
            scrollView.addSubview(imageView)
        }
    }
}


//MARK: - Scroll View Delegate
extension FullScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        pageControl.numberOfPages = viewModel?.images.count ?? 0
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
    }
}

extension FullScreenViewController: FullScreenDisplayLogic {
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
