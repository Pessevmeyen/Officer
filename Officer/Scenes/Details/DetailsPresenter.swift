//
//  DetailsPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 2.08.2022.
//

import Foundation

protocol DetailsPresentationLogic: AnyObject {
    func presentDetails(response: Details.Fetch.Response)
}

final class DetailsPresenter: DetailsPresentationLogic {
    
    weak var viewController: DetailsDisplayLogic?
    
    func presentDetails(response: Details.Fetch.Response) {
        let office = response.officeDetail
        viewController?.displayDetailsList(viewModel: Details.Fetch.ViewModel(id: office?.id,
                                                                              image: office?.image,
                                                                              images: office?.images,
                                                                              name: office?.name,
                                                                              address: office?.address,
                                                                              capacity: office?.capacity,
                                                                              rooms: String(office?.rooms ?? 1),
                                                                              space: office?.space,
                                                                              latitude: office?.location?.latitude,
                                                                              longitude: office?.location?.longitude))
    }
    
}
