//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit

protocol OfficeDisplayLogic: AnyObject {
    func displayOfficesList(viewModel: Office.Fetch.ViewModel)
}

final class OfficeViewController: UIViewController {
    
    var interactor: OfficeBusinessLogic?
    var router: (OfficeRoutingLogic & OfficeDataPassing)?
    var viewModel: Office.Fetch.ViewModel?
    
    var networkManager: NetworkManager?
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
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
        
        navigationItem.backBarButtonItem?.style = .done
        
        //1
        interactor?.fetchOfficesList() //View controller interactor'a diyor ki, office listesini çek.
        tableView.register(UINib(nibName: C.officeNibName, bundle: .main), forCellReuseIdentifier: C.officeCellID)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeInteractor()
        let presenter = OfficePresenter()
        let router = OfficeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}


extension OfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.officesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: C.officeCellID, for: indexPath) as? OfficeCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        guard let model = viewModel?.officesList[indexPath.row] else {fatalError("Not able to display model")}
        cell.configureCell(viewModel: model)
        return cell
    }
    
}


extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayOfficesList(viewModel: Office.Fetch.ViewModel) {
        //Burada gelen office listesini gösteriyor.
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
}
