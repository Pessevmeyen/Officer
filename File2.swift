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
//
//    var shapeListVerilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
//    var filteredVerilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
//
//
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var textField: UITextField!
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
//        pickerView.delegate = self
//
//        textField.inputView = pickerView
//
//
//
//
//    }
//
//    func initList() {
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
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.enablesReturnKeyAutomatically = false
//        searchController.searchBar.returnKeyType = UIReturnKeyType.done
//        definesPresentationContext = true
//
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.searchBar.scopeButtonTitles = ["All", "Date", "Capacity", "Rooms", "Space"]
//        searchController.searchBar.delegate = self
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
//
//        if (searchController.isActive) {
//            return filteredVerilerinTutulduğuModelArray.count
//        } else {
//            return viewModel?.officesListViewModel.count ?? 0
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
//            fatalError("An Error Occured while dequeuering reusable cell")
//        }
//
//        let selectedShape: Office.Fetch.ViewModel.OfficeModel!
//
//        if (searchController.isActive) {
//            selectedShape = filteredVerilerinTutulduğuModelArray[indexPath.row]
//            print("Selected shape is \(selectedShape) ")
//            cell.configureCell(viewModel: selectedShape) //????
//        } else {
//            selectedShape = viewModel?.officesListViewModel[indexPath.row]
//            cell.configureCell(viewModel: selectedShape)
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
//        let searchBar = searchController.searchBar //Search Barı oluşturacak.
//        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex] // Burada scope buttonlarında nereye tıklandığı
//        let searchText = searchBar.text!
//
//        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
//    }
//    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
//        filteredVerilerinTutulduğuModelArray = (viewModel?.officesListViewModel.filter { shape in
//            let scopeMatch = (scopeButton == "All" || shape.address!.lowercased().contains(scopeButton.lowercased()))
//            if (searchController.searchBar.text != "") {
//                let searchTextMatch = shape.address?.lowercased().contains(searchText.lowercased())
//
//                return scopeMatch && (searchTextMatch != nil)
//            } else {
//                return scopeMatch
//            }
//        })!
//        tableView.reloadData()
//    }
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
