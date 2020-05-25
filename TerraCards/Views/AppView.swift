//
//  AppView.swift
//  TerraCards
//
//  Created by MacBookGP on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    @EnvironmentObject var cardsModelView: CardsLists
 
    var body: some View {
       TabView {
        NavigationView { // bouton de la tabBar de Accueil
            HomeView().environmentObject(cardsModelView)
        }
        .tabItem({
                    Image(systemName: "book")
                    Text("Accueil")
            })
        NavigationView {
            TropheesView().environmentObject(cardsModelView) // bouton de la tabBar sur trophées
        }
        .tabItem({
                   // Image("icons8-book-stack-50")
                    Image(systemName: "rosette")
                    Text("Trophées")
                })
        NavigationView {  // bouton de la tabBar sur les parametres
            ParametresView(user: [UserLocation.init(user: .init(latitude: 23, longitude: 34))])
        }
        .tabItem({
                    Image(systemName: "gear")   // "helm"
                    Text("Paramètres")
                })
        NavigationView {  // bouton de la tabBar sur l'aide a l'utilisation
             Help()
         }
         .tabItem({
                    Image(systemName: "questionmark.square")
                    Text("Aide")
                 })
        
        }.accentColor(.blue)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
