//
//  OfficeWorker.swift
//  Officer
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import UIKit
import CoreData

protocol OfficeWorkingLogic: AnyObject {
    func getRequestedData(_ completion: @escaping ((Result<OfficeDataArray, Error>) -> Void)) //Workerda bunu çağırıcaz, parametresiyle birlikte.
    func getDataFromCoreData(_ completion: @escaping ((Result<[Int], Error>) -> Void))
    func saveToCoreData(model: Office.Fetch.ViewModel.OfficeModel)
    func deleteDatasFromCoreData(modelID: Int)
    func getFilterConstans(completion: @escaping (([FilterItems]) -> Void))
}

final class OfficeWorker: OfficeWorkingLogic {
    
    
    //worker'ın işi api'a gitmek
    //3
    func getRequestedData(_ completion: @escaping ((Result<OfficeDataArray, Error>) -> Void)) {
        //worker burada verileri getirecek. Getirirse return ile interactor içindeki closure'a dönecek.
        NetworkManager.shared.fetch(decode: OfficeDataArray.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getFilterConstans(completion: @escaping (([FilterItems]) -> Void)) {
        
        var itemList: [FilterItems] = []
        
        let dateInterval: FilterItems = .init(first: "Date", second: ["?"]) //dolacak
        let capacityInterval: FilterItems = .init(first: "Capacity", second: Constants.capacityArray)
        let roomsInterval: FilterItems = .init(first: "Rooms", second: Constants.roomsArray)
        let spaceInterval: FilterItems = .init(first: "Space", second: Constants.spaceArray)
        
        itemList.append(dateInterval)
        itemList.append(capacityInterval)
        itemList.append(roomsInterval)
        itemList.append(spaceInterval)
        
        completion(itemList)
    }
    
    func getDataFromCoreData(_ completion: @escaping ((Result<[Int], Error>) -> Void)) {
        CoreDataManager().getFromCoreData { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    func saveToCoreData(model: Office.Fetch.ViewModel.OfficeModel) {
        CoreDataManager().saveToCoreData(model: model)
    }
    
    
    func deleteDatasFromCoreData(modelID: Int) {
        CoreDataManager().deleteFromCoreData(officeID: modelID)
    }
    
}
