//
//  CardStore.swift
//  TerraCards
//
//  Created by MacBookGP on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI


extension Color {
    
    static let offwhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    static let lightStart = Color(red: 60/255, green: 160/255, blue: 240/255)
    static let lightEnd = Color(red: 30/255, green: 80/255, blue: 120/255)
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
    static let silver = Color(red: 206/255, green: 206/255, blue: 206/255)
    static let bronze = Color(red: 97/255, green: 78/255, blue: 26/255)
    static let colorTrophees = Color(red: 187/255, green: 222/255, blue: 221/255)
}






// liste de toute les cartes
class CardStore : ObservableObject {
     
    @Published var allCards: [Card] = [
//        Card(name: "Arachnides",
//             imageRecto: "moustique",
//             imageVerso: "Le moustique-tigre",
//             habitats: [.mountains],
//             season: "En étè",
//             averageSize: "2",
//             anecdote: "Le moustique tigre est l’un des 100 espèces les plus invasives du monde! On le retrouve sur les 5 continents",
//             obtained: true,
//             collection: CollectionType.insect,
//             alert: AlertType.greenAlert),
//        Card(name: "Coleoptere",
//             imageRecto: "coléoptère",
//             imageVerso: "Coléoptères",
//             habitats: [.countryside],
//             season: "spring",
//             averageSize: "4",
//             anecdote: "il roule sa bosse",
//             obtained: true,
//             collection: CollectionType.insect,
//             alert: AlertType.greenAlert),
//        Card(name: "Peuplier",
//             imageRecto: "PeuplierF",
//             imageVerso: "Peuplier",
//             habitats: [.mountain],
//             season: "summer",
//             averageSize: "Très grand",
//             anecdote: "Les papillons de nuit ( hétérogènes ) Se nourrissent de Peuplier",
//             obtained: true,
//             collection: CollectionType.tree,
//             alert: AlertType.greenAlert),
//        Card(name: "Peuplier",
//            imageRecto: "PeuplierF",
//            imageVerso: "Peuplier",
//            habitats: [.mountain],
//            season: "summer",
//            averageSize: "Très grand",
//            anecdote: "Les papillons de nuit ( hétérogènes ) Se nourrissent de Peuplier",
//            obtained: true,
//            collection: CollectionType.tree,
//            alert: AlertType.greenAlert)
        Card()
    ]
}

extension CardsLists {
    
    /*
      fonction qui calcule le nombre total de carte + ceux obtenue et le nb de prorata pour l'evolutionBar
     */
    func numbersMaxObtainedCards() -> (nbCardMax :Int, nbCardObtained : Int , nbCardEvoltionBar: CGFloat) {
        var numberMax = 0
        var numberObtained = 0
        var numberCardEvolutionBar:CGFloat = 0.0
        
        allCards.forEach { card in
            numberMax += 1
        }
        wonCards.forEach { card in
             numberObtained += 1
        }
        numberCardEvolutionBar = CGFloat( 170 / numberMax * numberObtained )
 
        print("-- cartes total  : \(numberMax)")
        print("-- cartes obtenus  : \(numberObtained)")
        print("-- nombre de l'evolutionBar  : \(numberCardEvolutionBar)")
        
        return (numberMax,numberObtained,numberCardEvolutionBar)
     }
    
    
    /*
     fonction qui calcule le nombre de carte total obtenue
     */
    func cardsObtained() -> Int {
       var number = 0
       wonCards.forEach { card in
            number += 1
       }
        print("------------ cartes obtenue  : \(number)")
       return number
    }
    
    
    /*
     retourne la couleur pour le contour de la carte trophee de toute les cartes
     */
    func numbersColorCards() -> Color {
        var numberMax = 0
        var numberObtained = 0
        var colorCardTrophee = Color.gray
        allCards.forEach { card in
            numberMax += 1
         if card.obtained {
             numberObtained += 1
         }
        }
        if (numberObtained > 0 && numberObtained < Int(4/5 * numberMax)) {   // condition entre carte min et max
            colorCardTrophee = Color.black  // couleur black si carte obtenue > 1
        } else if numberObtained > Int(4/5 * numberMax) && numberObtained < numberMax {
            colorCardTrophee = Color.green // couleur green si carte < 4/5 des carte max
        } else if numberMax == numberObtained {
            if numberObtained == 0 {
                colorCardTrophee = Color.gray
            } else { colorCardTrophee = Color.gold }    // couleur gold si carte max
        } else { colorCardTrophee = Color.gray } // couleur gray si pas de carte obtenue
        
        print("--- number total max:  \(numberMax) number obtained : \(numberObtained)  color of card : \(colorCardTrophee)")
        
        return colorCardTrophee
    }
    
    /*
     calcule du nombre de carte max et obtenue ainsi que la couleur pour le contour de la carte trophee
     */
    func numberCardsMaxCollection(collection: CollectionType) -> (obtained:Int, collectionMax: Int, cardColor: Color, numberEvolutionBar: CGFloat) {
        
        let valeurMax = 170
        var numbersObtainedCollection = 0
        var numbersMaxCollection = 0
        var colorCardTrophee = Color.gray
        var numberProrataEvolutionBar:CGFloat = 0.0  // nombre du prorata pour affichage de l'evolution de la bar par rapport au max de carte et ceux obtenue
        
        allCards.forEach { card in
            if card.collection == collection {
                numbersMaxCollection += 1
            }
        }
        
        wonCards.forEach { card in
            if card.collection == collection {
                numbersObtainedCollection += 1
            }
        }
        if (numbersObtainedCollection > 0 && numbersObtainedCollection < Int(4/5 * numbersMaxCollection)) {   // condition entre carte min et max
            colorCardTrophee = Color.black  // couleur black si carte obtenue > 1
        } else if numbersObtainedCollection > Int(4/5 * numbersMaxCollection) && numbersObtainedCollection < numbersMaxCollection {
            colorCardTrophee = Color.green // couleur green si carte < 4/5 des carte max
        } else if numbersMaxCollection == numbersObtainedCollection {
            if numbersObtainedCollection == 0 {
                colorCardTrophee = Color.gray
            } else {
                colorCardTrophee = Color.gold    // couleur gold si carte max
            }
        } else { colorCardTrophee = Color.gray } // couleur gray si pas de carte obtenue
         
        if numbersObtainedCollection == 0 && numbersMaxCollection == 0 {
            numberProrataEvolutionBar = 0.0
        } else {
            numberProrataEvolutionBar = CGFloat( valeurMax / numbersMaxCollection * numbersObtainedCollection)
        }

        print("-- cartes total  : \(numbersMaxCollection)")
        print("-- cartes obtenus  : \(numbersObtainedCollection)")
        print("-- nombre de l'evolutionBar  : \(numberProrataEvolutionBar)")
              
        return (numbersObtainedCollection, numbersMaxCollection, colorCardTrophee, numberProrataEvolutionBar)
    }
    
    
    func numberMaxCollection(collection: CollectionType) -> CGFloat {

        var numbersMaxCollection = 0
        
        allCards.forEach { card in
            if card.collection == collection {
                numbersMaxCollection += 1
            }
        }
         
        return CGFloat(numbersMaxCollection)
    }
    
    func numberObtainedCollection(collection: CollectionType) -> CGFloat {

        var numbersObtainedCollection = 0
        
        wonCards.forEach { card in
            if card.collection == collection {
                numbersObtainedCollection += 1
            }
        }
         
        return CGFloat(numbersObtainedCollection)
    }
    
    
    
    
 /*
    func numberCardsCollectionObtained(collection: CollectionType) -> Int{
        var numberCardsObtained = 0
        allCards.forEach { card in
            if card.collection == collection {
                numberCardsObtained += 1
            }
        }
        return numberCardsObtained
    }
    
    func isObtained(collection: CollectionType) -> (max: Int , min: Int, cardColor: Color) {
        var numberMax = 0
        var numberMin = 0
        var colorCardTrophee:Color = Color.gray
        for nb in allCards {
            if nb.name == collection.name { // calculer le nombre de carte min max par rapport au nom
                 numberMax += 1      // carte de meme nom
                 if nb.obtained {
                     numberMin += 1   //  carte obtenue
                 }
             }
             if (numberMin > 0 && numberMin < Int(4/5 * numberMax)) {   // condition entre carte min et max
                 colorCardTrophee = Color.black  // couleur black si carte obtenue > 1
             } else if numberMin > Int(4/5 * numberMax) && numberMin < numberMax {
                 colorCardTrophee = Color.green // couleur green si carte < 4/5 des carte max
             } else if numberMax == numberMin {
                 colorCardTrophee = Color.gold    // couleur gold si carte max
             } else { colorCardTrophee = Color.gray } // couleur gray si pas de carte obtenue
        }
        return (numberMax, numberMin , colorCardTrophee )
    }
 
 */
}
 
