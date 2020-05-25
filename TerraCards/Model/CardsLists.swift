//
//  CardsModelView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI

class CardsLists: ObservableObject {
    @Published var wonCards: [Card] = []
    var missingCards: [Card] {
        var result: [Card] = []
        for card in allCards {
            if wonCards.firstIndex(where: {card.name == $0.name}) == nil {
                result.append(card)
            }
        }
        return result
    }
    @Published var allCards: [Card] = []

    @Published var connection: Bool = true
    
    var possibleToWinMoreForFree: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())
        return UserSettings.lastFreeWins != todayString
    }
}




