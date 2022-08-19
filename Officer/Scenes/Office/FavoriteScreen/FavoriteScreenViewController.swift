//
//  FavoriteScreenViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import UIKit
import CoreData

protocol FavoriteScreenDisplayLogic: AnyObject {
    func displayCoreData(displayOfficeId: [FavoriteScreen.Fetch.ViewModel.CoreDataModels])
}



final class FavoriteScreenViewController: UIViewController, OfficeCellDelegate {
    func favoriteAdded(model: Office.Fetch.ViewModel.OfficeModel) {
        
    }
    
    func favoriteDeleted(model: Office.Fetch.ViewModel.OfficeModel) {
        
    }
    
    
    var interactor: FavoriteScreenBusinessLogic?
    var router: (FavoriteScreenRoutingLogic & FavoriteScreenDataPassing)?
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerFavoriteTableView()
        }
    }
    
    //CoreDatadan çekilen veriler buraya aktarılacak.
    var idArray: [FavoriteScreen.Fetch.ViewModel.CoreDataModels] = []
    var nameArray: [String] = []
    var addressArray: [String] = []
    var capacityArray: [String] = []
    var roomsArray: [String] = []
    var spaceArray: [String] = []
    var imageArray: [String] = []
    
    var bool: Bool?
    
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
        
        getDataFromCoreData()
        
        interactor?.fetchCoreData()
        
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromCoreData), name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
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
    
    //MARK: Getting Data From Core Data
    @objc func getDataFromCoreData() {
        
        idArray.removeAll(keepingCapacity: false)
        nameArray.removeAll(keepingCapacity: false)
        addressArray.removeAll(keepingCapacity: false)
        capacityArray.removeAll(keepingCapacity: false)
        roomsArray.removeAll(keepingCapacity: false)
        spaceArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
        fetchRequest.returnsObjectsAsFaults = false // büyük verilerde caching ayarlamak için
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] { //results Any olarak geliyor o yüzden tipini belirlememiz gerek.
                    
                    guard let id = result.value(forKey: "id") as? Int else { return }
                    idArray.append(id)
                    
                    guard let name = result.value(forKey: "name") as? String else {
                        return
                    }
                    nameArray.append(name)
                    
                    guard let address = result.value(forKey: "address") as? String else {
                        return
                    }
                    addressArray.append(address)
                    
                    guard let capacity = result.value(forKey: "capacity") as? String else {
                        return
                    }
                    capacityArray.append(capacity)
                    
                    guard let rooms = result.value(forKey: "rooms") as? String else { return }
                    roomsArray.append(rooms)
                                     
                    guard let space = result.value(forKey: "space") as? String else {
                        return
                    }
                    spaceArray.append(space)
                    
                    guard let image = result.value(forKey: "image") as? String else { return }
                    imageArray.append(image)
                    
                    tableView.reloadData()
                    
                    }
                }
        } catch {
            getAlert(alertTitle: "Error", actionTitle: "OK!", message: "An Error Occured When Fetching Data From Core Data")
        }
    }
}

//MARK: - TableView Delegate & Datasource | Number Of Rows In Section, CellForRowAt, DidSelectRowAt
extension FavoriteScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Sectionda kaç tane row oluşacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //MARK: rowlar neyden oluşacak.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoriteScreenCellIdentifier, for: indexPath) as? FavoriteScreenCell else {
            fatalError("An Error Occured while dequeuering reusable cell")
        }
        
        
        cell.configureCell(name: nameArray[indexPath.row], address: addressArray[indexPath.row], image: imageArray[indexPath.row], capacity: capacityArray[indexPath.row], rooms: roomsArray[indexPath.row], space: spaceArray[indexPath.row])
        
        return cell
    }
    
}

extension FavoriteScreenViewController: FavoriteScreenDisplayLogic {
    func displayCoreData(displayOfficeId: [FavoriteScreen.Fetch.ViewModel.CoreDataModels]) {
        idArray.removeAll()
        idArray = displayOfficeId
        print(idArray)
    }
}
