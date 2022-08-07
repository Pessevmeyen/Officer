//
//  DetailsViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import UIKit

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
    var detailImageView = DetailsCell().imageView
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        
        setRightBarButtonItem(buttonImage: "gridlayoutimage") //Navigation bar'daki buttonu oluşturacak.
        
        interactor?.fetchDetails(request: Details.Fetch.Request())
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.imageTapped(_:)))
        detailImageView?.addGestureRecognizer(pictureTap)
        detailImageView?.isUserInteractionEnabled = true //also can be set via storyboard
  
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
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        print("detail içinde image tapped")
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }


    
    //MARK: Right Bar Button
    func setRightBarButtonItem(buttonImage: String!) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Photos", style: .plain, target: self, action: #selector(changeLayout)) //????
        let add = UIBarButtonItem.init(image: UIImage(named: buttonImage), style: .done, target: self, action: #selector(changeLayout))
        add.customView?.borderWidth = 1
        navigationItem.rightBarButtonItems = [add]
    }
    
    //MARK: Setting Collection View
    func setCollectionView() {
        collectionView.register(UINib(nibName: Constants.detailsNibName, bundle: .main), forCellWithReuseIdentifier: Constants.detailsCellReuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: true) //Custom yaptığımız Collection View layout'u oluşturacak.
    }
    
    
    @objc func changeLayout() {
        
        if isGridLayout {
            collectionView.setCollectionViewLayout(createLayout(), animated: true)
            setRightBarButtonItem(buttonImage: "gridlayoutimage")
            title = viewModel?.name
            isGridLayout = false
        } else {
            collectionView.setCollectionViewLayout(makeGridLayout(), animated: true) //Custom yaptığımız Collection View layout'u oluşturacak.
            setRightBarButtonItem(buttonImage: "listinglayoutimage")
            title = "All Photos"
            isGridLayout = true
        }
        
    }
      
}


//MARK: - Collection View Delegate and Data Source | Section Number, Number of Items, Cell for Item, Did Select Item
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.detailsCellReuseIdentifier, for: indexPath) as? DetailsCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        cell.configureCell(viewModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToFullScreen(index: indexPath.item)
    }
}


//MARK: - Collection View Flow Layout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    // Her bir sectionda sağdan soldan yukarıdan aşağıdan ne kadar boşluk istediği.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    //
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
//        //let heightPerItem = collectionView.frame.width / 4 //- (gridLayout?.minimumInteritemSpacing ?? CGFloat())
//        //let widthPerItem = collectionView.frame.width / 3
//        return CGSize(width: (view.frame.size.width / 3) - 3, height: (view.frame.size.height / 3) - 3)
//        //841x445
//    }
    
    
}


//MARK: - Collection View Customization
extension DetailsViewController {
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.makeHorizontalLayout()
            } else {
                return self.makeHorizontalLayout()
            }
            
        }
    }
}


extension DetailsViewController {
    
}

//MARK: - Collection View Horizontal ve Vertical Swiping Setting
extension DetailsViewController {
    
    func makeVerticalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth (0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    func makeHorizontalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.9)) //itemin yatay ve dikey uzunluğu
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300)) //Kullanıcı kaydıracağını anlasın diye.
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        //section.orthogonalScrollingBehavior = .groupPagingCentered //Kaydırmanın olduğu yer
        return section
    }
    
    
    // burada grid layouta dönüşecek.
    func makeGridLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.size.width / 4) - 5, height: (view.frame.size.width / 4) - 10)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        
        return layout
    }
}


//MARK: - Display Logic
extension DetailsViewController: DetailsDisplayLogic {
    func displayDetailsList(viewModel: Details.Fetch.ViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.collectionView.reloadData()
            print(viewModel)
        }
    }
}
