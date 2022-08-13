//
//  OfficeViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit

//MARK: Display Logic Protocol
protocol OfficeDisplayLogic: AnyObject {
    func displayViewModelData(viewModel: Office.Fetch.ViewModel)
}

final class OfficeViewController: UIViewController, UITextFieldDelegate {
    
    var interactor: OfficeBusinessLogic?
    var router: (OfficeRoutingLogic & OfficeDataPassing)?
    var viewModel: Office.Fetch.ViewModel?
    
    var firstPickerView = UIPickerView()
    
    //var shapeListVerilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
    //var filteredVerilerinTutulduğuModelArray = [Office.Fetch.ViewModel.OfficeModel]()
    
    var itemList = [FilterItems]()
    
    var bosOfficeArray = [Office.Fetch.ViewModel.OfficeModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
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

        registerTableView()
        
        setHidesBackButton() // ?? çalışmazsa eski haline al.
        
        createToolbarForPickerView()
        
        createFilterItems() // çalışmazsa eski haline al
        
        //1
        interactor?.fetchData(request: Office.Fetch.Request()) //View controller interactor'a diyor ki, office listesini çek.
        
    }
    

    
    //MARK: Life Cycles
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
    
    
    //MARK: Custom Functions
    
    private func createFilterItems() {
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
        
        //Buradan sonra artık text Field'a dokunduğumuzda picker view gibi davranacak
        textField.inputView = firstPickerView
        
        let capacityInterval: FilterItems = .init(first: "Capacity", second: ["0-5", "5-10", "10-15", "15-20", "20-25"])
        let roomsInterval: FilterItems = .init(first: "Rooms", second: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
        let spaceInterval: FilterItems = .init(first: "Space", second: ["25m2", "50m2", "75m2", "100m2", "125m2", "150m2"])
        
        itemList.append(capacityInterval)
        itemList.append(roomsInterval)
        itemList.append(spaceInterval)
    }
    
    private func createToolbarForPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissButton))
        toolBar.setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK: @objc Functions
    
    @objc func dismissButton() {
        view.endEditing(true)
    }
    
}



//MARK: - TableView Delegate & Datasource | Number Of Rows In Section, CellForRowAt, DidSelectRowAt
extension OfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Sectionda kaç tane row oluşacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.officesListViewModel.count ?? 0
    }
    
    //MARK: rowlar neyden oluşacak.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        guard let model = viewModel?.officesListViewModel[indexPath.row] else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        cell.configureCell(viewModel: model)
        
        return cell
    }
    
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
    
    //MARK: Row'u seçince ne olacak
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        
        //let selectedFirst = pickerView.selectedRow(inComponent: 0)
        let selectedSecond = pickerView.selectedRow(inComponent: 0)
        let selectedData = itemList[selectedSecond].second?[row]
        
        interactor?.fetchFilter(request: selectedData ?? "")
    
        textField.text = selectedData
    }
  
}



//MARK: - Display Logic
extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayViewModelData(viewModel: Office.Fetch.ViewModel) {
        //Burada gelen office listesini gösteriyor.
        self.viewModel = viewModel
        print(viewModel)
        DispatchQueue.main.async {
            self.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
}
