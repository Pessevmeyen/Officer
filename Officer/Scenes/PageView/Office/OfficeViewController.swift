//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit
import CoreData

//MARK: Display Logic Protocol
protocol OfficeDisplayLogic: AnyObject {
    func displayViewModelData(viewModel: Office.Fetch.ViewModel)
    func displayID(idModel: [Int])
    func displayFilterConstants(filterConstants: [FilterItems])
    func displayAlert(alertTitle: String, actionTitle: String, message: String)
}

protocol AnimationDelegate: AnyObject {
    func addingFavoriteAnimation()
    func removingFavoriteAnimation()
}

final class OfficeViewController: UIViewController, UITextFieldDelegate {

    var interactor: OfficeBusinessLogic?
    var router: (OfficeRoutingLogic & OfficeDataPassing)?
    var viewModel: Office.Fetch.ViewModel?
    
    var pickerView = UIPickerView()
    let refreshControl = UIRefreshControl()
    
    var itemList = [FilterItems]()
    var idCoreData: [Int] = []
    
    weak var delegate: AnimationDelegate?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet { //Burada tableview oluştuğunda kayıt edecek. WillSet ile yapsaydık çalışmazdı çünkü henüz tableView tanımlanmamış oluyor.
            registerTableView()
        }
    }
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var officesLabel: CLTypingLabel!
    
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
        
        navigationController?.navigationBar.isHidden = false
        
        officesLabel.text = "Offices"
        
        createToolbarDoneButtonForPickerView()
        
        createFilterItems()
        
        //1
        interactor?.fetchData(request: Office.Fetch.Request()) //View controller interactor'a diyor ki, office listesini çek.
        
        refreshTableView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    
    
    
    
    //MARK: Custom Functions
    // Creates Filter Items
    private func createFilterItems() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //Buradan sonra artık text Field'a dokunduğumuzda picker view gibi davranacak
        textField.inputView = pickerView
        
        interactor?.fetchFilterConstants(filterConstants: itemList)
    }
    
    // Creates Toolbar Button
    private func createToolbarDoneButtonForPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissButton))
        toolBar.setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
        
    }
    
    private func refreshTableView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down to Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //MARK: @objc Functions
    @objc func goToFavoritesScreen() {
            router?.routeToFavorites()
        }
    
    //dismiss olacak sadece
    @objc private func dismissButton() {
        view.endEditing(true)
        interactor?.fetchDataAfterFetched() // Done tuşuna basıldığında bütün ofisleri tekrar gösterecek.
        textField.text = ""
    }
    
    @objc private func refresh() {
        interactor?.fetchData(request: Office.Fetch.Request())
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
}
//MARK: EXTENSIONS ------------------------------------------



//MARK: TableView Delegate & Datasource
extension OfficeViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Sectionda kaç tane row oluşacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.officesListViewModel.count ?? 0
    }
    
    //MARK: This rows occurs from what
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
            interactor?.getAlert()
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        guard let model = viewModel?.officesListViewModel[indexPath.row] else {
            interactor?.getAlert()
            //fatalError("An Error Occured while dequeuering reusable cell")
            return UITableViewCell()
        }
        
        //
        interactor?.fetchDataFromCoreData(reqeust: idCoreData)

        cell.configureCell(viewModel: model)
        cell.delegate = self
        cell.favorites(ids: idCoreData)
        return cell
        
    }
    
    //MARK: What happen when select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetails(index: indexPath.row) //Seçilen cell'e ne olacağını yazıyoruz. Burada önce seçilen cell'in datasını route'a gönderiyoruz. row? item?
    }
    
    
}


//MARK: - Picker View Delegate
extension OfficeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Kaç tane component olacak
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //MARK: Componentlerde kaç tane row olacak.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return itemList.count
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return itemList[selectedItem].second?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return itemList[row].first
        } else {
            let selectedItem = pickerView.selectedRow(inComponent: 0)
            return itemList[selectedItem].second?[row]
        }
    }
    
    //MARK: Row'u seçince ne olacak + Go To Interactor
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(0)
        pickerView.reloadComponent(1)
        
        let selectedSecond = pickerView.selectedRow(inComponent: 0)
        let selectedData = itemList[selectedSecond].second?[row]
        textField.text = selectedData
        interactor?.fetchFilter(request: selectedData ?? "")
    }
    
}



//MARK: - Office Cell Delegate and Core Data ------------------------------------------
extension OfficeViewController: OfficeCellDelegate {
    
    //MARK: Added to Favorite
    func favoriteAdded(model: Office.Fetch.ViewModel.OfficeModel) {
        
        delegate?.addingFavoriteAnimation()
        
        // Saving data to the Core Data
        interactor?.saveDataToCoreData(model: model)
        
    }
    
    //MARK: Deleted from Favorite
    func favoriteDeleted(model: Office.Fetch.ViewModel.OfficeModel) {
        
        delegate?.removingFavoriteAnimation()
        
        //Deleting Data From Core Data
        interactor?.deleteFromCoreData(modelID: model.id ?? 0)
    }
}



//MARK: - Display Logic
extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayViewModelData(viewModel: Office.Fetch.ViewModel) {
        //Burada gelen office listesini gösteriyor.
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
    
    func displayID(idModel: [Int]) {
        idCoreData = idModel
    }
    
    func displayFilterConstants(filterConstants: [FilterItems]) {
        itemList = filterConstants
    }
    
    func displayAlert(alertTitle: String, actionTitle: String, message: String) {
        getAlert(alertTitle: alertTitle, actionTitle: actionTitle, message: message)
    }
    
    
}
