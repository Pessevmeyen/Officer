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
    
    var selectedImage: String?
    var selectedPictureNumber: FullScreen.Fetch.ViewModel?
    var totalPictures: Int?
    
    //var images = ["mercury", "venus", "earth", "mars", "jupiter", "saturn"]
    
    //let imageView = UIImageView()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        
        interactor?.fetchData(request: FullScreen.Fetch.Request())
        //configureFullScreen(viewModel: FullScreen.Fetch.ViewModel(images: viewModel?.images ?? []))
        
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
}


extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: Kaç tane cell oluşacak
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    //MARK: Bu celller neyden oluşacak.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as? FullScreenCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(image: model.images[indexPath.row])
        print(model.images[indexPath.row])
        
        return cell
    }
    
    // Her bir sectionda sağdan soldan yukarıdan aşağıdan ne kadar boşluk istediği.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
   
}


//MARK: - Display Logic
extension FullScreenViewController: FullScreenDisplayLogic {
    
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    
}
