////
////  OfficeViewController.swift
////  Officer
////
////  Created by Furkan Eruçar on 1.08.2022.
////
//
//import UIKit
//
//protocol OfficeDisplayLogic: AnyObject {
//    func displayViewModelData(viewModel: Office.Fetch.ViewModel)
//}
//
//final class OfficeViewController: UIViewController {
//
//    var interactor: OfficeBusinessLogic?
//    var router: (OfficeRoutingLogic & OfficeDataPassing)?
//    var viewModel: Office.Fetch.ViewModel?
//
//    var pickerView = UIPickerView()
//    var pickerButton = UIBarButtonItem()
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var searching = false
//    var scopeButtonPressed = false
//
//    var verilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
//    var searchedVerilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
//
//
//    @IBOutlet weak var tableView: UITableView!
//    //@IBOutlet weak var searchTextField: UISearchBar!
//
//
//    // MARK: Object lifecycle
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//
//
//    //MARK: View Did Load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        registerTableView()
//
//        navigationItem.setHidesBackButton(true, animated: true) //Back button'ı iptal ediyoruz ki giriş yaptıktan sonra tekrar giriş ekranına dönülmesin.
//
//
//
//        //1
//        interactor?.fetchData(request: Office.Fetch.Request()) //View controller interactor'a diyor ki, office listesini çek.
//
//        configureSearchController()
//
//
//
//
//    }
//
//    //MARK: Life Cycles
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        title = Constants.appName
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        title = ""
//    }
//
//    // MARK: Setup
//
//    private func setup() {
//        let viewController = self
//        let interactor = OfficeInteractor(worker: OfficeWorker())
//        let presenter = OfficePresenter()
//        let router = OfficeRouter()
//        viewController.interactor = interactor
//        viewController.router = router
//        interactor.presenter = presenter
//        presenter.viewController = viewController
//        router.viewController = viewController
//        router.dataStore = interactor
//    }
//
//
//    //MARK: Custom Functions
//    func configureSearchController() {
//        searchController.loadViewIfNeeded()
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.enablesReturnKeyAutomatically = false
//        searchController.searchBar.returnKeyType = .done
//        searchController.searchBar.scopeButtonTitles = ["All", "Date", "Capacity", "Rooms", "Space"]
//        definesPresentationContext = true
//        searchController.searchBar.placeholder = "Search Offices by Filter"
//        self.navigationItem.searchController = searchController
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//
//    }
//
//
//}
//
//
//
////MARK: - TableView Delegate & Datasource | Number Of Rows In Section, CellForRowAt, DidSelectRowAt
//extension OfficeViewController: UITableViewDelegate, UITableViewDataSource {
//
////    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        return "OFFICES"
////    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searching || scopeButtonPressed {
//            return viewModel?.officesListViewModel.count ?? 0
//        } else {
//            return verilerinTutulduğuModelArray.count
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
//            fatalError("An Error Occured while dequeuering reusable cell")
//        }
//        guard let model = viewModel?.officesListViewModel[indexPath.row] else {
//            fatalError("Not able to display model")
//        }
//
//        if searching || scopeButtonPressed {
//            cell.configureCell(viewModel: model)
//        } else {
//            cell.configureCell(viewModel: model)
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router?.routeToDetails(index: indexPath.row) //Seçilen cell'e ne olacağını yazıyoruz. Burada önce seçilen cell'in datasını route'a gönderiyoruz. row? item?
//    }
//
//}
//
//
////MARK: - Picker View Delegate
//extension OfficeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    //MARK: Kaç tane component olacak
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    //MARK: Componentlerde kaç tane row olacak.
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "Title"
//    }
//
//    //MARK: Row'u seçince ne olacak
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//    }
//
//}
//
//extension OfficeViewController: UISearchBarDelegate, UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//
//        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
//        let searchText = searchController.searchBar.text!
//        if !searchText.isEmpty {
//            searching = true
//            searchedVerilerinTutulduğuModelArray = viewModel?.officesListViewModel ?? []
//            //removeAll()
//            print(searchedVerilerinTutulduğuModelArray)
//            searchedVerilerinTutulduğuModelArray.removeAll()
//            print(searchedVerilerinTutulduğuModelArray)
//
//            verilerinTutulduğuModelArray = viewModel?.officesListViewModel ?? []
//            for item in verilerinTutulduğuModelArray {
//                if item.capacity?.lowercased().contains(searchText.lowercased()) ?? true && (item.space == scopeButton || scopeButton == "All") {
//                    searchedVerilerinTutulduğuModelArray.append(item)
//                    print(searchedVerilerinTutulduğuModelArray)
//                }
//            }
//        } else {
//            if scopeButtonPressed {
//                searchedVerilerinTutulduğuModelArray.removeAll()
//                let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
//                for item in verilerinTutulduğuModelArray {
//                    if (item.space == scopeButton || scopeButton == "All") {
//                        searchedVerilerinTutulduğuModelArray.append(item)
//                    }
//                }
//                searching = false
//                tableView.reloadData()
//
//            } else {
//                searching = false
//                searchedVerilerinTutulduğuModelArray.removeAll()
//                searchedVerilerinTutulduğuModelArray = verilerinTutulduğuModelArray
//            }
//        }
//
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        tableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        searchController.searchBar.text = ""
//        scopeButtonPressed = true
//        let scopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
//        searchedVerilerinTutulduğuModelArray.removeAll()
//        for item in verilerinTutulduğuModelArray {
//            if (item.address == scopeButton || scopeButton == "All") {
//                searchedVerilerinTutulduğuModelArray.append(item)
//            }
//        }
//        tableView.reloadData()
//    }
//
//
//}
//
//
////MARK: - Display Logic
//extension OfficeViewController: OfficeDisplayLogic {
//    //5
//    func displayViewModelData(viewModel: Office.Fetch.ViewModel) {
//        //Burada gelen office listesini gösteriyor.
//        self.viewModel = viewModel
//        print(viewModel)
//        DispatchQueue.main.async {
//            self.tableView.reloadData() //displaynews'a gelmeden reload
//        }
//    }
//}
