//
//  CardStore.swift
//  TerraCards
//
//  Created by MacBookGP on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI




// liste de toute les cartes
class CardStore : ObservableObject {
     
    @Published var allCards: [Card] = [
        Card(name: "Arachnides",
             imageRecto: "moustique",
             imageVerso: "Le moustique-tigre",
             habitats: [.mountain],
             season: "summer",
             averageSize: "2",
             anecdote: "Le moustique tigre est l’un des 100 espèces les plus invasives du monde! On le retrouve sur les 5 continents",
             obtained: true,
             collection: CollectionType.insect,
             alert: AlertType.greenAlert),
        Card(name: "Coleoptere",
             imageRecto: "coléoptère",
             imageVerso: "Coléoptères",
             habitats: [.countryside],
             season: "spring",
             averageSize: "4",
             anecdote: "il roule sa bosse",
             obtained: false,
             collection: CollectionType.insect,
             alert: AlertType.greenAlert),
        Card(name: "Peuplier",
             imageRecto: "PeuplierF",
             imageVerso: "Peuplier",
             habitats: [.mountain],
             season: "summer",
             averageSize: "Très grand",
             anecdote: "Les papillons de nuit ( hétérogènes ) Se nourrissent de Peuplier",
             obtained: true,
             collection: CollectionType.tree, alert: AlertType.greenAlert)
    ]
    
    
    
    // nombre de carte par type de collection
    func getCards(collection: CollectionType) -> [Card] {
        var cards = [Card]()
        
        allCards.forEach { card in
            
            if card.collection == collection {cards.append(card) }
            
        }
        return cards
    }
    
}




