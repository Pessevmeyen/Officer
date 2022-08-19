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
}

protocol AnimationDelegate: AnyObject {
    func addingFavoriteAnimation()
    func removingFavoriteAnimation()
}

final class OfficeViewController: UIViewController, UITextFieldDelegate, AnimationDelegate {
    
    var interactor: OfficeBusinessLogic?
    var router: (OfficeRoutingLogic & OfficeDataPassing)?
    var viewModel: Office.Fetch.ViewModel?
    
    var firstPickerView = UIPickerView()
    
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
        
        officesLabel.text = "Offices"
        
        setHidesBackBarButton()
        
        createToolbarDoneButtonForPickerView()
        
        createFilterItems()
        
        setRightBarButtonItem()
        
        //1
        interactor?.fetchData(request: Office.Fetch.Request()) //View controller interactor'a diyor ki, office listesini çek.
        
    }
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = Constants.appName
    }
    
    //MARK: View Will Disappear
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
    // Creates Filter Items
    private func createFilterItems() {
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
        
        //Buradan sonra artık text Field'a dokunduğumuzda picker view gibi davranacak
        textField.inputView = firstPickerView
        
        let dateInterval: FilterItems = .init(first: "Date", second: ["?"]) //dolacak
        let capacityInterval: FilterItems = .init(first: "Capacity", second: Constants.capacityArray)
        let roomsInterval: FilterItems = .init(first: "Rooms", second: Constants.roomsArray)
        let spaceInterval: FilterItems = .init(first: "Space", second: Constants.spaceArray)
        
        itemList.append(dateInterval)
        itemList.append(capacityInterval)
        itemList.append(roomsInterval)
        itemList.append(spaceInterval)
    }
    
    func addingFavoriteAnimation() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addingOffice), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setRightBarButtonItem), userInfo: nil, repeats: false)
    }
    
    func removingFavoriteAnimation() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(removingOffice), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setRightBarButtonItem), userInfo: nil, repeats: false)
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
    
    //MARK: @objc Functions
    
    //Create Right Bar Button
    @objc private func setRightBarButtonItem() {
        let biggerConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let biggerSymbolImage = UIImage(named: "custom.heart.text.square", in: .main, with: biggerConfiguration)
        let favoritesScreenButton = UIBarButtonItem.init(image: biggerSymbolImage, style: .done, target: self, action: #selector(goToFavoritesScreen))
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    @objc private func addingOffice() {
        let favoritesScreenButton = UIBarButtonItem.init(title: "Adding Office...", style: .done, target: self, action: nil)
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    @objc private func removingOffice() {
        let favoritesScreenButton = UIBarButtonItem.init(title: "Removing Office...", style: .done, target: self, action: nil)
        favoritesScreenButton.tintColor = #colorLiteral(red: 0.5294117647, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
        navigationItem.rightBarButtonItems = [favoritesScreenButton]
    }
    
    @objc private func dismissButton() {
        view.endEditing(true)
        interactor?.fetchDataAfterFetched() // Done tuşuna basıldığında bütün ofisleri tekrar gösterecek.
        textField.text = ""
    }
    
    //MARK: Go To Router
    @objc func goToFavoritesScreen() {
        router?.routeToFavorites()
    }
    
}



//MARK: EXTENSIONS ------------------------------------------



//MARK: - TableView Delegate & Datasource
extension OfficeViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Sectionda kaç tane row oluşacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.officesListViewModel.count ?? 0
    }
    
    //MARK: This rows occurs from what
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.officeCellIdentifier, for: indexPath) as? OfficeCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        guard let model = viewModel?.officesListViewModel[indexPath.row] else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        getDataFromCoreData()
        
        cell.configureCell(viewModel: model)
        cell.delegate = self
        cell.like = true
        cell.favoriteButton.setImage(UIImage(named: "disfav"), for: .normal)
        for item in idCoreData {
            if item == model.id {
                cell.favoriteButton.setImage(UIImage(named: "fav"), for: .normal)
                cell.like = false
            }
        }
        
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
        
        delegate = self
        
        delegate?.addingFavoriteAnimation()
        
        //MARK: Saving data to the Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Context'in içine ne koyacağımızı söylememiz lazım.
        let savedOffice = NSEntityDescription.insertNewObject(forEntityName: "Offices", into: context)
        
        //Burada Entity'nin Attribute'larını vericez.
        
        savedOffice.setValue(model.id, forKey: "id")
        savedOffice.setValue(model.name, forKey: "name")
        savedOffice.setValue(model.address, forKey: "address")
        savedOffice.setValue(model.capacity, forKey: "capacity")
        savedOffice.setValue(model.image, forKey: "image")
        savedOffice.setValue(model.rooms, forKey: "rooms")
        savedOffice.setValue(model.space, forKey: "space")
        
        
        do {
            try context.save()
            print("saved")
        } catch {
            getAlert(alertTitle: "Error", actionTitle: "OK!", message: "An Error Occured When saving to Core Data")
        }
        
        //Favoriler sayfasona notify ediyoruz değişiklik geldi uygula diye.
        NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
    }
    
    
    //MARK: Deleted from Favorite
    func favoriteDeleted(model: Office.Fetch.ViewModel.OfficeModel) {
        
        delegate = self
        
        delegate?.removingFavoriteAnimation()
        //MARK: Deleting data from Core Data
        // First we have to fetch data from core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(model.id ?? 0)")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? Int {
                        idCoreData.append(id)
                        if id == model.id {
                            context.delete(result)
                            
                            //After deleting, we have to save deleting data
                            do {
                                try context.save()
                            } catch {
                                getAlert(alertTitle: "Error", actionTitle: "OK!", message: "An Error Occured When Saving Deleted Data")
                            }
                            break
                        }
                    }
                }
            }
        } catch {
            getAlert(alertTitle: "Error", actionTitle: "OK!", message: "An Error Occured When Deleting Data From Core Data")
        }
    }
}

extension OfficeViewController {
    
    func getDataFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? Int{
                    idCoreData.append(id)
                }
            }
        }
        catch {
            
        }
    }
}



//MARK: - Display Logic
extension OfficeViewController: OfficeDisplayLogic {
    //5
    func displayViewModelData(viewModel: Office.Fetch.ViewModel) {
        //Burada gelen office listesini gösteriyor.
        self.viewModel = viewModel
        print(viewModel)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData() //displaynews'a gelmeden reload
        }
    }
}
