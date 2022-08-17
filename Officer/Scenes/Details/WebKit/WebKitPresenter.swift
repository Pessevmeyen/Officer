//
//  WebKitPresenter.swift
//  Officer
//
//  Created by Furkan Eruçar on 17.08.2022.
//

import Foundation

protocol WebKitPresentationLogic: AnyObject {
    
}

final class WebKitPresenter: WebKitPresentationLogic {
    
    weak var viewController: WebKitDisplayLogic?
    
}
