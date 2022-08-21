//
//  MapKitPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 19.08.2022.
//

import Foundation

protocol MapKitPresentationLogic: AnyObject {
    func presentMapKit(response: MapKit.Fetch.Response)
}

final class MapKitPresenter: MapKitPresentationLogic {
    
    weak var viewController: MapKitDisplayLogic?
    
    func presentMapKit(response: MapKit.Fetch.Response) {
        
        var offices: [MapKit.Fetch.ViewModel.OfficeModel] = []
        response.officeResponse.forEach { //Burada gelen array şeklinde veri parametrelerini, Model içindeki parametrelere aktarıyoruz.
            offices.append(MapKit.Fetch.ViewModel.OfficeModel(image: $0.image,
                                                              name: $0.name,
                                                              address: $0.address,
                                                              latitude: $0.location?.latitude,
                                                              longitude: $0.location?.longitude))
        }
        viewController?.displayLocation(viewModel: .init(officesListViewModel: offices))
//        let office = response.officeMapKit
//        viewController?.displayLocation(viewModel: MapKit.Fetch.ViewModel.init(id: office?.id, image: office?.image, name: office?.name, address: office?.address, latitude: office?.location?.latitude, longitude: office?.location?.longitude))
//        print(office)
    }
    
    
}
