//
//  LocalisationMap.swift
//  TerraCards
//
//  Created by MacBookGP on 25/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation


// localisation par rapport au coordonne de l'utilisateur dans une MapView
struct LocalisationMap: UIViewRepresentable {
    
    @Binding var coordonneeLocalUser: UserLocation?
    @Binding var isActive: Bool
    
    var local:[UserLocation]
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        
        // Configuration de LocationManager
  
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
 
}
