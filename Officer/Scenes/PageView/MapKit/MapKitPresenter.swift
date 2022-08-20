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
        let office = response.officeMapKit
        viewController?.displayLocation(viewModel: MapKit.Fetch.ViewModel.init(id: office?.id, image: office?.image, name: office?.name, address: office?.address, latitude: office?.location?.latitude, longitude: office?.location?.longitude))
        print(office)
    }
    
    
}
