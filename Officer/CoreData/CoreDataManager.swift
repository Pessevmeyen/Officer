//
//  CoreDataManager.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerDelegate {
    func saveToCoreData(id: Int, name: String, address: String, capacity: String, rooms: String, space: String, image: String)
    func getFromCoreData(completion: @escaping ((Result<[Int], Error>) -> Void))
    func deleteFromCoreData(officeId: Int)
}


class CoreDataManager {
    
    func getFromCoreData(complation: @escaping ((Result<[FavoriteScreen.Fetch.ViewModel.CoreDataModels], Error>) -> Void)) {
        
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
    
    func saveToCoreData(id: Int, name: String, address: String, capacity: String, rooms: String, space: String, image: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedOffice = NSEntityDescription.insertNewObject(forEntityName: "Offices", into: context)
        
        savedOffice.setValue(id, forKey: "id")
        savedOffice.setValue(name, forKey: "name")
        savedOffice.setValue(address, forKey: "address")
        savedOffice.setValue(capacity, forKey: "capacity")
        savedOffice.setValue(rooms, forKey: "rooms")
        savedOffice.setValue(space, forKey: "space")
        savedOffice.setValue(image, forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("An Error Occured When Saving Data to Core Data!")
        }
        //Favoriler sayfasona notify ediyoruz değişiklik geldi uygula diye.
        NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
    }
    
    
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
                                print("An Error Occured When Saving Deleted Data")
                            }
                            break
                        }
                    }
                }
            } else {
                print("There nothing")
            }
            
        } catch {
            print("An Error Occured When Deleting Data From Core Data")
        }
    }
    
    
}
