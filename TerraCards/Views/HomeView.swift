//
//  HomeView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

    // Création de la grille
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let hSpacing: CGFloat
    let vSpacing: CGFloat
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: self.vSpacing){
            ScrollView{
                ForEach(0 ..< rows, id:\.self){ row in
                    HStack(spacing: self.hSpacing){
                        ForEach(0 ..< self.columns, id:\.self){ column in
                            self.content(row, column)
                    }
                }
            }
        }
    }
}
    
    init(rows: Int, columns: Int, hSpacing: CGFloat, vSpacing: CGFloat, @ViewBuilder content: @escaping (Int, Int) -> Content) {
            self.rows = rows
            self.columns = columns
            self.content = content
            self.hSpacing = hSpacing
            self.vSpacing = vSpacing
        }
    }

    // Page HomeView
struct HomeView: View {
    
    let collectionTypes = CollectionType.allCases
    
    var body: some View {
        ScrollView{
            ZStack {
                Color.offWhite
                
                VStack{
                    // Zone du haut
                    HStack{
                        VStack{
                            Image(systemName: "rosette")
                            Text("Trophées")
                        }
                        Text("Terra Cards").font(.largeTitle).padding()
                        VStack{
                            Image(systemName: "gear")
                            Text("Profil")
                        }
                    }.padding(.top, 40)
                    
                    // Mise en place de la grille des collections
                   GridStack(rows: 4, columns: 3, hSpacing: 0, vSpacing: 0){row, col in
                       VStack{
                          LittleCardView(titreCollection: self.collectionTypes[row * 3 + col].name, imageCollection: self.collectionTypes[row * 3 + col].image)
                       }.padding(.top, 10)
                       
                   }
                    
                }
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
