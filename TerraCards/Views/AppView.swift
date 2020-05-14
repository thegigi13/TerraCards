//
//  AppView.swift
//  TerraCards
//
//  Created by MacBookGP on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
       TabView {
        NavigationView {
             TropheesView() // bouton de la tabBar sur trophées
        }
        .tabItem({
                   // Image("icons8-book-stack-50")
                    Image(systemName: "rosette")
                    Text("Trophées")
                })
            
        NavigationView { // bouton de la tabBar de Accueil
            Accueil()
        }
        .tabItem({
                    Image(systemName: "book")
                    Text("Accueil")
            })
        NavigationView {  // bouton de la tabBar sur les parametres
            ParametresView()
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
