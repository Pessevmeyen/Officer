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
        viewController?.displayLocation(viewModel: MapKit.Fetch.ViewModel(image: response.officeMapKit?.image,
                                                                          name: response.officeMapKit?.name,
                                                                          address: response.officeMapKit?.address,
                                                                          latitude: response.officeMapKit?.location?.latitude,
                                                                          longitude: response.officeMapKit?.location?.longitude))
    }
    
}
