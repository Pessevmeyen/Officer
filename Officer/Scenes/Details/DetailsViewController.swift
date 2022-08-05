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
    var viewModel: Details.Fetch.ViewModel?
    
    var detailsID: Int?
    
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
        interactor?.fetchDetails(request: Details.Fetch.Request())
        
        setupCollection()
        
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
    
    func setupCollection() {

        collectionView.register(UINib(nibName: C.detailsNibName, bundle: .main), forCellWithReuseIdentifier: C.detailsCellReuseIdentifier)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 5 //üst üste gelen cellerin arasındaki boşluk
//        layout.minimumLineSpacing = 5 //Yan yana gelen cell'lerin arasındaki boşluk
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    
    
}


//MARK: - Collection View Delegate and Data Source
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.detailsCellReuseIdentifier, for: indexPath) as? DetailsCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        cell.configureCell(viewModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


//MARK: - Collection View Flow Layout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let heightPerItem = collectionView.frame.width / 2 - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
        return CGSize(width: 300, height: heightPerItem)
    }
    
    
}


//MARK: - Collection View Customization
extension DetailsViewController {
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                return self.makeHorizontalLayout()
            } else {
                return self.makeVerticalLayout()
            }
            
        }
    }
}

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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300)) //Kullanıcı kaydıracağını anlasın diye.
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        return section
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
