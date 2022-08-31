//
//  FullScreenViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 7.08.2022.
//

import UIKit

protocol FullScreenDisplayLogic: AnyObject {
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel)
}

//MARK: Full Screen scroll edildiğinde bulunduğumuz indexi almak için delege oluşturduk
protocol FullScreenDelegate: AnyObject {
    func fullScreenDidScroll(indexPath: IndexPath)
}

final class FullScreenViewController: UIViewController {
    
    var interactor: FullScreenBusinessLogic?
    var router: (FullScreenRoutingLogic & FullScreenDataPassing)?
    var viewModel: FullScreen.Fetch.ViewModel?
    let flowLayout = UICollectionViewFlowLayout()
    
    weak var delegate: FullScreenDelegate?
    
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
    
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    
        flowLayout.scrollDirection = .horizontal
        flowLayout.collectionView?.layoutIfNeeded()
        collectionView.collectionViewLayout = flowLayout
        
        
        interactor?.fetchData(request: FullScreen.Fetch.Request())
        
    }
    
    
    //MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() { // When the bounds change for a view controller's view, the view adjusts the positions of its subviews and then the system calls this method. However, this method being called does not indicate that the individual layouts of the view's subviews have been adjusted. Each subview is responsible for adjusting its own layout.
        super.viewDidLayoutSubviews()
        
        // Scrolls the collection view contents until the specified item is visible.
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(row: viewModel?.selectedIndex ?? 0, section: 0), at: .left, animated: true)
        collectionView.isPagingEnabled = true
        
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


//MARK: - Collection View Delegates and Data Source | numberOfItemsInSection, cellForItemAt, insetForSectionAt, scrollViewDidEndDecelerating
extension FullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: How many cell will occure
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    //MARK: This cells occurs from what
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as? FullScreenCell else {
            fatalError("An Error Occured While Reusable Cell")
        }
        
        guard let model = self.viewModel else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(image: model.images[indexPath.row])
        return cell
    }
    
    //MARK: How much space around the section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: Scroll yapma bittiği zaman ne olacağı.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) { //Gets the index path of the item at the specified point in the collection view.
            delegate?.fullScreenDidScroll(indexPath: visibleIndexPath)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      targetContentOffset.pointee = scrollView.contentOffset
        self.collectionView.isPagingEnabled = false
        let pageWidth:Float = Float(self.view.bounds.width)
        let minSpace:Float = 10.0
        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= Double((viewModel?.images.count)!) {
            cellToSwipe = Double((viewModel?.images.count)!)
        }
        
        let indexPath: IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.collectionView.setNeedsLayout()
        self.collectionView.isPagingEnabled = true
        delegate?.fullScreenDidScroll(indexPath: indexPath)

    }
    
}

extension FullScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - Display Logic
extension FullScreenViewController: FullScreenDisplayLogic {
    func displayFullScreenData(viewModel: FullScreen.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

