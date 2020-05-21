//
//  CardTrophee.swift
//  TerraCards
//
//  Created by MacBookGP on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI

struct CarteTrophee: Identifiable {
    let id:UUID
    let name:String
    let colorTrophee:Color
    let numberMax:Int
    let numberMin:Int
    let textType:String?
 }
 
struct listeCardTrophee {
    
    @State var tropheeListe:[CarteTrophee] = [
           
           CarteTrophee(id: .init(), name: "hat-school", colorTrophee: .black, numberMax: 170, numberMin: 50, textType: "Total de cartes :"),
           
           CarteTrophee(id: .init(), name: "Cadeaux-cards", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes recus ce jour :"),
           CarteTrophee(id: .init(), name: "Quizz", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Quizz réussis :"),
           CarteTrophee(id: .init(), name: "Rare", colorTrophee: .gray, numberMax: 10, numberMin: 0, textType: "  Cartes rares :"),
           CarteTrophee(id: .init(), name: "Insectes", colorTrophee: Color.gold, numberMax: 170, numberMin: 170, textType: "Cartes insectes :"),
           CarteTrophee(id: .init(), name: "Arbres", colorTrophee: .black, numberMax: 10, numberMin: 1, textType: "Cartes arbres :"),
           CarteTrophee(id: .init(), name: "Mollusques", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes Mollusques :"),
           CarteTrophee(id: .init(), name: "Poissons", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Cartes Poissons :"),
           CarteTrophee(id: .init(), name: "Plantes", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: " Cartes plantes :"),
           
           
           CarteTrophee(id: .init(), name: "Grands-mammiferes", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Grands mammifères :"),
           CarteTrophee(id: .init(), name: "Oiseaux", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes Oiseaux :"),
           CarteTrophee(id: .init(), name: "Reptiles", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Cartes reptiles :"),
           CarteTrophee(id: .init(), name: "Amphibiens", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes Amphibiens :"),
           CarteTrophee(id: .init(), name: "Petits-mammiferes", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Petits mammiphères :"),
           CarteTrophee(id: .init(), name: "Arachnides", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes arachnides :")
           
         ]
       
}


/*

func parameTropheeCard(nameType: String) -> CarteTrophee {
     
    let card: CardStore
    let nameCollection:CollectionType = .insect
    var colorCardTrophee:Color = .gray
    var numberMin:Int = 0
    var numberMax:Int = 0
    var tropheeCard:CarteTrophee
    
    
    // trier par carte
    for nb in card.allCards {
        if nb.collection.name == nameCollection.name { // calculer le nombre de carte min max par rapport au nom
            numberMax += 1      // carte de meme nom
            if nb.obtained {
                numberMin += 1   //  carte obtenue
            }
        }
        if (numberMin > 0 && numberMin < Int(4/5 * numberMax)) {   // condition entre carte min et max
            colorCardTrophee = .black  // couleur black si carte obtenue > 1
        } else if numberMin > Int(4/5 * numberMax) && numberMin < numberMax {
            colorCardTrophee = .green // couleur green si carte < 4/5 des carte max
        } else if numberMax == numberMin {
            colorCardTrophee = .gold    // couleur gold si carte max
        } else { colorCardTrophee = .gray } // couleur gray si pas de carte obtenue
    }
    tropheeCard = CarteTrophee(id: .init(), name: nameCollection, colorTrophee: colorCardTrophee, numberMax: numberMax, numberMin: numberMin, textType: "Total de cartes :")
    return tropheeCard // retour d'une carte trophee
  
}
    
*/

