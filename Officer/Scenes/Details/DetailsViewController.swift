//
//  DetailsViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit
import SDWebImage

protocol DetailsDisplayLogic: AnyObject {
    func displayDetailsList(viewModel: Details.Fetch.ViewModel)
}

final class DetailsViewController: UIViewController {
    
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    var viewModel: Details.Fetch.ViewModel? {
        didSet { //Details'a ilk girişte viewModel'ın içine data girene kadar title nil gelecek, o yüzden didSet'e aktardık ki, viewModel dolduğu anda tetiklensin.
            self.title = viewModel?.name ?? ""
        }
    }
    
    var detailsID: Int?
    
    var isGridLayout = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(detailsID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.detailsID = detailsID
        setup()
    }
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: Constants.detailsNibName, bundle: .main), forCellWithReuseIdentifier: Constants.detailsCellReuseIdentifier)
        collectionView.setCollectionViewLayout(setCollectionView(), animated: true)
        
        setRightBarButtonItem(buttonImage: "gridlayoutimage") //Navigation bar'daki buttonu oluşturacak.
        
        interactor?.fetchDetails(request: Details.Fetch.Request())
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        
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
    
    
    
    //MARK: Right Bar Button
    func setRightBarButtonItem(buttonImage: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Photos", style: .plain, target: self, action: #selector(changeLayout)) //????
        let changeLayoutButton = UIBarButtonItem.init(image: UIImage(named: buttonImage), style: .done, target: self, action: #selector(changeLayout))
        changeLayoutButton.customView?.borderWidth = 1
        navigationItem.rightBarButtonItems = [changeLayoutButton]
    }
    
    
    
    //MARK: The Action When Right Bar Button Tapped
    @objc func changeLayout() {
        print("tapped")
        if isGridLayout { // If user on Listing View
            collectionView.setCollectionViewLayout(setCollectionView(), animated: true)
            setRightBarButtonItem(buttonImage: "gridlayoutimage")
            title = viewModel?.name
            isGridLayout = false
        } else { // If user on Grid View
            //collectionView.setCollectionViewLayout(makeGridLayout(), animated: true) //Custom yaptığımız Collection View layout'u oluşturacak.
            collectionView.setCollectionViewLayout(setGridLayout(), animated: true)
            setRightBarButtonItem(buttonImage: "listinglayoutimage")
            title = "All Photos"
            isGridLayout = true
        }
    }
}




//MARK: - Setting Flow Layout and Grid Layout
extension DetailsViewController {
    
    //Setting Custom Collection View
    func setCollectionView() -> UICollectionViewFlowLayout {
        let listLayout = UICollectionViewFlowLayout()
        listLayout.scrollDirection = .horizontal
        listLayout.itemSize = CGSize(width: (view.frame.size.width - 30), height: (view.frame.size.width / 2) + 50)
        listLayout.minimumInteritemSpacing = 5
        listLayout.minimumLineSpacing = 5
        collectionView.setCollectionViewLayout(listLayout, animated: true)
        return listLayout
    }
    
    //Setting Grid Layout
    func setGridLayout() -> UICollectionViewFlowLayout { //İki farklı layout verdiğim için bunu böyle yaptım. Doğrusunu sor.
        let gridLayout = UICollectionViewFlowLayout()
        gridLayout.scrollDirection = .vertical
        gridLayout.itemSize = CGSize(width: (view.frame.size.width / 4) - 5, height: (view.frame.size.width / 4) - 10)
        gridLayout.minimumLineSpacing = 5
        gridLayout.minimumInteritemSpacing = 1
        collectionView.setCollectionViewLayout(gridLayout, animated: true)
        return gridLayout
    }
}



//MARK: - Collection View Delegate and Data Source | Section Number, Number of Items, Cell for Item, Did Select Item
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.detailsCellReuseIdentifier, for: indexPath) as? DetailsCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(images: model.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.row) //????? row? item?
    }
}


//MARK: - Collection View Flow Layout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    // Her bir sectionda sağdan soldan yukarıdan aşağıdan ne kadar boşluk istediği.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
    }
    

    
}





//MARK: - Display Logic
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetailsList(viewModel: Details.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
