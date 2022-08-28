//
//  CoreDataManager.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import UIKit
import CoreData

protocol CoreDataManagerDelegate {
    func saveToCoreData(model: Office.Fetch.ViewModel.OfficeModel)
    func getDataFromCoreData(complation: @escaping ((Result<[FavoriteScreen.Fetch.ViewModel.CoreDataModels], Error>) -> Void))
    func getFromCoreData(completion: @escaping ((Result<[Int], Error>) -> Void))
    func deleteFromCoreData(officeId: Int)
}

final class CoreDataManager {
//    private init() {}
//    static let shared = CoreDataManager()
    
    //MARK: Saving To Core Data
    func saveToCoreData(model: Office.Fetch.ViewModel.OfficeModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedOffice = NSEntityDescription.insertNewObject(forEntityName: "Offices", into: context)
        
        savedOffice.setValue(model.id, forKey: "id")
        savedOffice.setValue(model.name, forKey: "name")
        savedOffice.setValue(model.address, forKey: "address")
        savedOffice.setValue(model.capacity, forKey: "capacity")
        savedOffice.setValue(model.rooms, forKey: "rooms")
        savedOffice.setValue(model.space, forKey: "space")
        savedOffice.setValue(model.image, forKey: "image")
        savedOffice.setValue(model.latitude, forKey: "latitude")
        savedOffice.setValue(model.longitude, forKey: "longitude")
        savedOffice.setValue(model.images, forKey: "images")
        
        do {
            try context.save()
        } catch {
            print("An Error Occured When Saving Data to Core Data!")
        }
        //Favoriler sayfasona notify ediyoruz değişiklik geldi uygula diye.
        NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
    }
    
    
    
    //MARK: Getting Data From Core Data
    func getDataFromCoreData(complation: @escaping ((Result<[FavoriteScreen.Fetch.ViewModel.CoreDataModels], Error>) -> Void)) {
        
        var officesFromCoreData : [FavoriteScreen.Fetch.ViewModel.CoreDataModels] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<Offices>(entityName: "Offices")
        request.returnsObjectsAsFaults = false // büyük verilerde caching ayarlamak için
        
        do {
            let results = try context.fetch(request)
            for result in results { //results Any olarak geliyor o yüzden tipini belirlememiz gerek.
                officesFromCoreData.append(.init(office: result))
            }
            complation(.success(officesFromCoreData))
        } catch {
            complation(.failure(error))
        }
    }
    
    
    
    //MARK: Getting Data From Core Data
    func getFromCoreData(completion: @escaping ((Result<[Int], Error>) -> Void)) {
        
        var idCoreData: [Int] = []
        
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
            completion(.success(idCoreData))
        }
        catch {
            completion(.failure(error))
        }
    }
    
    
    
    //MARK: Deleting data from Core Data
    func deleteFromCoreData(officeID: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Offices")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(officeID)")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? Int {
                        if id == officeID {
                            context.delete(result)
                            
                            do {
                                try context.save()
                            } catch {
                                fatalError()
                            }
                            break
                        }
                    }
                }
            } else {
                fatalError()
            }
            
        } catch {
            fatalError()
        }
    }
    
    
}
