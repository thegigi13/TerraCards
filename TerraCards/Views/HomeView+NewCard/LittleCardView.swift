//
//  LittleCardView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct LittleCardView: View {
    var titreCollection : String
    var imageCollection : String
    var couleurCard: String
    @State private var showingAlert = false
    
        // création de l'extractingView pour la HomeView
    var body: some View {
            
//        Button(action: {
//            //Si l'utilisateur n'a des cartes dans cette collection
//            //self.showingAlert = true
//
//            //Si l'utilisateur a des cartes dans cette collection
//            // changer la destination du NavigationLink selon la collection choisie
//            //NavigationLink(destination: ContentView())
//        }) {
//            VStack{
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(Color(couleurCard).opacity(0.7))
//                    .frame(width: 100, height: 120)
//                    .shadow(color: Color.white.opacity(0.4), radius: 5, x: -5, y: -5)
//                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
//                    .padding(.horizontal, 10)
//                    .overlay(Image("\(imageCollection)").renderingMode(.original).resizable().scaledToFit().frame(width: 90, height: 90))
//                Text (titreCollection).foregroundColor(.black).opacity(0.6)
//            }
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Pas encore de cartes dans cette catégorie"), message: Text("Vous pouvez gagner de nouvelles cartes tous les jours en cliquant sur le cadeau ou en répondant à un quizz"), dismissButton: .default(Text("OK")))
//        }
        
        //Meme code mais avec NavigationLink seul (pas d'alert)
        // changer la destination du NavigationLink selon la collection choisie
//        NavigationLink(destination: ContentView()){
//
            VStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(couleurCard).opacity(0.7))
                    .frame(width: 100, height: 140)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .padding(.horizontal, 10)
                        .overlay(Image("\(imageCollection)").renderingMode(.original).resizable().scaledToFit().frame(width: 90, height: 90))
                Text (titreCollection).foregroundColor(.black)
            }
            .saturation(0)
            .opacity(0.6)
//
//        }
        
    }
}

struct LittleCardView_Previews: PreviewProvider {
    static var previews: some View {
        LittleCardView(titreCollection: "Amphibiens", imageCollection : "grenouille2", couleurCard: "amphibian")
    }
}
