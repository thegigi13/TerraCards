//
//  ContentView.swift
//  TerraCards
//
//  Created by MacBookGP on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var cardsModelView: CardsModelView
    
    var body: some View {
        TropheesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
