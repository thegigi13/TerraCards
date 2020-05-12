//
//  Card.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import MapKit

struct Card {
   let name: String
    let imageRecto: String
    let imageVerso: String
    let habitats: [HabitatType]
    let season: String
    let averageSize: String
    let anecdote: String
    var obtained: Bool
    let collection : CollectionType
    let alert: AlertType
    // la var alert est la menace pesant sur l'espèce (esp commune, faiblement menacée, fortement menacée, éteinte)
    let coordinates: [MKCoordinateRegion] = []
    // le tableau vide pourrait être rempli avec une zone de la france entière
}

enum HabitatType {
    case sea, mountain, city, countryside
    var name : String {
        get {
            switch self {
                case .sea : return "Mer"
                case .mountain : return "Montagne"
                case .city : return "Ville"
                case .countryside : return "Campagne"
            }
        }
    }
}

enum CollectionType: CaseIterable{
    case tree, fish, mollusc, largeMammal, bird, insect, reptile, plant, amphibian, smallMammal, spider
    
    var name : String {
        get {
            switch self {
                case .tree : return "Arbres"
                case .fish : return "Poissons"
                case .mollusc : return "Mollusques"
                case .largeMammal : return "Grands Mammifères"
                case .bird : return "Oiseaux"
                case .insect : return "Insectes"
                case .reptile : return "Reptiles"
                case .plant : return "Plantes"
                case .amphibian : return "Amphibiens"
                case .smallMammal : return "Petits Mammifères"
                case .spider : return "Arachnides"
            }
        }
    }
    
    var image : String {
        get {
            switch self {
                case .tree : return "pictureFrog"
                case .fish : return "pictureFrog"
                case .mollusc : return "pictureFrog"
                case .largeMammal : return "pictureFrog"
                case .bird : return "pictureFrog"
                case .insect : return "pictureFrog"
                case .reptile : return "pictureFrog"
                case .plant : return "pictureFrog"
                case .amphibian : return "pictureFrog"
                case .smallMammal : return "pictureFrog"
                case .spider : return "pictureFrog"
            }
        }
    }
    
}

enum AlertType {
    case greenAlert, yellowAlert, redAlert, blackAlert
    var name : String {
        get {
            switch self {
                case .greenAlert : return "Vert"
                case .yellowAlert : return "Jaune"
                case .redAlert : return "Rouge"
                case .blackAlert : return "Noir"
            }
        }
    }
}
