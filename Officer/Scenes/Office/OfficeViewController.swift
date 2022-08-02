//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit

protocol OfficeDisplayLogic: AnyObject {
    func displayNews(viewModel: Office.Fetch.ViewModel)
}

final class OfficeViewController: UIViewController {
    
    var interactor: OfficeBusinessLogic?
    var router: (OfficeRoutingLogic & OfficeDataPassing)?
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: Office.Fetch.ViewModel?
    
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
        
        //1
        interactor?.fetchNews(request: Office.Fetch.Request(result: "5"))
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfficeCell", for: indexPath) as? OfficeCell
        cell?.textLabel?.text = "Sound Check"
        return cell!
    }
    
}

extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayNews(viewModel: Office.Fetch.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
