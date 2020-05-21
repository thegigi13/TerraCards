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
    @Published var missingCards: [Card] = []
    @Published var allCards: [Card] = []

    @Published var connection: Bool = true
}




