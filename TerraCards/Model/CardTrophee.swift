//
//  CardTrophee.swift
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

struct CardOffice {
    
//    @ObservedObject var store: CardStore
    
    private var store: CardStore
    private var collectiontype:CollectionType
    
    private var cardMax:Int = 170
    private var cardObtained:Int = 0
    private var collection:CollectionType
    //  private var obtained:Bool
    
    // savoir le nombre total de carte CollectionType, est le nombre obtenue
    func nbTotalCollectiontype(typeCard:CollectionType) -> Int {
        
        var totaCollectionType:Int = 0
        // calculer le nombre total de carte pat collectionType
       for nb in store.allCards {
            
            if nb.obtained == true {
                totaCollectionType += 1
            }
        }
        return totaCollectionType
      
        
        // calculer le nombre obtenue de ses cartes
    }
     
    // nombre total de carte obtenue
    func nbTotalObtained() -> Int {
        var total:Int = 0
        for nb in store.allCards {
            if nb.obtained == true {
                total += 1
            }
        }
        return total
    }
    
}


struct CarteTrophee: Identifiable {
    let id:UUID
    let name:String
    let colorTrophee:Color
    let numberMax:Int
    let numberMin:Int
    let textType:String?
    
    
    
    func ColorTropheeCard(cardTrophe: CarteTrophee) -> Color  {
        
        let colorCardTrophee:Color = .gray
        
        if cardTrophe.numberMax == cardTrophe.numberMin {
         /*  changer couleur
             .gray pour pas de carte
             .black pour  1 ou plus
             .green pour plus des 4/5
             .gold pour toutes les cartes
        */
            return colorCardTrophee
        }
        return colorCardTrophee
    }
    
    
    
}
