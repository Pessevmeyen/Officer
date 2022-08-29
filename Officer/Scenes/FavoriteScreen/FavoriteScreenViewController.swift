//
//  FavoriteScreenViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import UIKit
import CoreData
import HandyViewController

protocol FavoriteScreenDisplayLogic: AnyObject {
    func displayCoreData(viewModel: [FavoriteScreen.Fetch.ViewModel.CoreDataModels])
    func displayAlert(alertTitle: String, actionTitle: String, message: String)
}

protocol FavoriteScreenDelegate {
    func detectDeletingFromCell()
}



final class FavoriteScreenViewController: UIViewController {
    func favoriteAdded(model: Office.Fetch.ViewModel.OfficeModel) {
        
    }
    
    var interactor: FavoriteScreenBusinessLogic?
    var router: (FavoriteScreenRoutingLogic & FavoriteScreenDataPassing)?
    var viewModel: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]?
    
    var delegate: FavoriteScreenDelegate?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerFavoriteTableView()
            registerHandyScrollView(tableView)
        }
    }
    
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
        interactor?.fetchCoreData()
        title = "Favorites"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("dismiss"), object: nil)
        print("favori ekranı gidiyorrrrr")
    }

    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FavoriteScreenInteractor()
        let presenter = FavoriteScreenPresenter()
        let router = FavoriteScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    

}

//MARK: - TableView Delegate & Datasource | Number Of Rows In Section, CellForRowAt, DidSelectRowAt
extension FavoriteScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Sectionda kaç tane row oluşacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    //MARK: rowlar neyden oluşacak.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteScreenCellIdentifier, for: indexPath) as? FavoriteScreenCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        guard let model = viewModel?[indexPath.row] else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        cell.configureCell(viewModel: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            interactor?.deleteFromCoreData(id: Int(viewModel?[indexPath.row].id ?? 0))
            viewModel?.remove(at: indexPath.row)
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        router?.routeToDetails(index: indexPath.row)
    }
}

extension FavoriteScreenViewController: FavoriteScreenDisplayLogic {
    func displayCoreData(viewModel: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
    
    func displayAlert(alertTitle: String, actionTitle: String, message: String) {
        getAlert(alertTitle: alertTitle, actionTitle: actionTitle, message: message)
    }
    
    
}
