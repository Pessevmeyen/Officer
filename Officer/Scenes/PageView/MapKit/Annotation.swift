//
//  Annotation.swift
//  Officer
//
//  Created by Furkan Eruçar on 23.08.2022.
//

import Foundation
import MapKit
import CoreLocation

class Annotation: NSObject, MKAnnotation {
    var id: Int
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.id = id
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

