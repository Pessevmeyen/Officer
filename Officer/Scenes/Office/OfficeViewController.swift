//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit

protocol OfficeDisplayLogic: AnyObject {
    func displayViewModelData(viewModel: Office.Fetch.ViewModel)
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
        
        self.navigationItem.setHidesBackButton(true, animated: true) //Back button'ı iptal ediyoruz ki giriş yaptıktan sonra tekrar giriş ekranına dönülmesin.
        
        //1
        interactor?.fetchData(request: Office.Fetch.Request()) //View controller interactor'a diyor ki, office listesini çek.
        tableView.register(UINib(nibName: Constants.officeNibName, bundle: .main), forCellReuseIdentifier: Constants.officeCellIdentifier)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = Constants.appName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        title = ""
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = OfficeInteractor(worker: OfficeWorker())
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



//MARK: - TableView Delegate & Datasource | Number Of Rows In Section, CellForRowAt, DidSelectRowAt
extension OfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "OFFICES"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.officesListViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        guard let model = viewModel?.officesListViewModel[indexPath.row] else {
            fatalError("Not able to display model")
        }
        cell.configureCell(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetails(index: indexPath.row) //Seçilen cell'e ne olacağını yazıyoruz. Burada önce seçilen cell'in datasını route'a gönderiyoruz. row? item?
        print(indexPath.row)
        print(indexPath.item)
    }
    
}


//MARK: - Display Logic
extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayViewModelData(viewModel: Office.Fetch.ViewModel) {
        //Burada gelen office listesini gösteriyor.
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
}
