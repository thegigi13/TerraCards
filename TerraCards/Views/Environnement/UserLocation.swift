//
//  UserLocation.swift
//  TerraCards
//
//  Created by MacBookGP on 25/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import MapKit

// localisation par rapport a l'user
class UserLocation: NSObject, MKAnnotation, Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    
    init(user: User) {
        self.coordinate = CLLocationCoordinate2D(latitude: user.latitude , longitude: user.longitude)
    }
}
