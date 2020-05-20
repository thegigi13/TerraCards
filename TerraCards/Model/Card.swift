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
    let id = UUID()
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

enum CollectionType: String, CaseIterable, Identifiable{
    case tree, fish, mollusc, largeMammal, bird, insect, reptile, plant, amphibian, smallMammal, spider, dinosaur
    
    var id : UUID {
        return UUID()
    }
    
    var index : Int {
        get {
            switch self {
                case .tree : return 0
                case .fish : return 1
                case .mollusc : return 2
                case .largeMammal : return 3
                case .bird : return 4
                case .insect : return 5
                case .reptile : return 6
                case .plant : return 7
                case .amphibian : return 8
                case .smallMammal : return 9
                case .spider : return 10
                case .dinosaur : return 11
            }
        }
    }
    
    var name : String {
        get {
            switch self {
                case .tree : return "Arbres"
                case .fish : return "Poissons"
                case .mollusc : return "Mollusques"
                case .largeMammal : return "Mammifères"
                case .bird : return "Oiseaux"
                case .insect : return "Insectes"
                case .reptile : return "Reptiles"
                case .plant : return "Plantes"
                case .amphibian : return "Amphibiens"
                case .smallMammal : return "Petits Mammifères"
                case .spider : return "Arachnides"
                case .dinosaur : return "Dinosaures"
            }
        }
    }
    
    var image : String {
        get {
            switch self {
                case .tree : return "grenouille"
                case .fish : return "lotte"
                case .mollusc : return "grenouille"
                case .largeMammal : return "chat"
                case .bird : return "mesange"
                case .insect : return "grenouille"
                case .reptile : return "grenouille"
                case .plant : return "grenouille"
                case .amphibian : return "grenouille"
                case .smallMammal : return "grenouille"
                case .spider : return "grenouille"
                case .dinosaur : return "grenouille"
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
