//
//  FavoriteScreenViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 14.08.2022.
//

import UIKit
import CoreData

protocol FavoriteScreenDisplayLogic: AnyObject {
    
}



final class FavoriteScreenViewController: UIViewController, OfficeCellDelegate {
    func favoriteAdded(model: Office.Fetch.ViewModel.OfficeModel) {
        
    }
    
    func favoriteDeleted(model: Office.Fetch.ViewModel.OfficeModel) {
        
    }
    
    
    var interactor: FavoriteScreenBusinessLogic?
    var router: (FavoriteScreenRoutingLogic & FavoriteScreenDataPassing)?
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //CoreDatadan çekilen veriler buraya aktarılacak.
    var uuidArray: [UUID] = []
    var idArray: [Int] = []
    var nameArray: [String] = []
    var addressArray: [String] = []
    var capacityArray: [String] = []
    var roomsArray: [String] = []
    var spaceArray: [String] = []
    var imageArray: [String] = []
    
    var bool: Bool?
    
    var choosedName = ""
    var choosedUUID: UUID?
    
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
        
        registerCollectionView()
        
        getDataFromCoreData()
        
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
        
        nameArray.removeAll(keepingCapacity: false)
        uuidArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
        fetchRequest.returnsObjectsAsFaults = false // büyük verilerde caching ayarlamak için
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] { //results Any olarak geliyor o yüzden tipini belirlememiz gerek.
                    
                    if let uuid = result.value(forKey: "uuid") as? UUID {
                        uuidArray.append(uuid)
                        
                        if let id = result.value(forKey: "id") as? Int {
                            idArray.append(id)
                            
                            if let name = result.value(forKey: "name") as? String {
                                nameArray.append(name)
                                
                                if let address = result.value(forKey: "address") as? String {
                                    addressArray.append(address)
                                    
                                    if let capacity = result.value(forKey: "capacity") as? String {
                                        capacityArray.append(capacity)
                                        
                                        if let rooms = result.value(forKey: "rooms") as? String {
                                            roomsArray.append(rooms)
                                            
                                            if let space = result.value(forKey: "space") as? String {
                                                spaceArray.append(space)
                                                
                                                if let image = result.value(forKey: "image") as? String {
                                                    imageArray.append(image)

                                                    self.tableView.reloadData()
                                                }
                                            //self.tableView.reloadData()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            
        } catch {
            print("fetch error")
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
        //let model = nameArray[indexPath.row]
        
        //cell.configureCell(viewModel: model)
        
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.addressLabel.text = addressArray[indexPath.row]
        cell.capacityLabel.text = "Capacity: \(capacityArray[indexPath.row])"
        cell.roomsLabel.text = "Rooms: \(roomsArray[indexPath.row])"
        cell.spaceLabel.text = "Space: \(spaceArray[indexPath.row])"
        cell.cellImageView.sd_setImage(with: URL(string: imageArray[indexPath.row]))
        
        
        
        return cell
    }
    
}

extension FavoriteScreenViewController: FavoriteScreenDisplayLogic {
    
}
