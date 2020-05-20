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
        NavigationView{
        ScrollView(.vertical, showsIndicators: false){
            ZStack {
                Color.white
                
                VStack{
                    // Zone du haut
                    HStack{
                        // Titre de l'application
                        Text("Terra Cards").font(.largeTitle).padding()
                        
                    }.padding(.top, 40).padding(.horizontal, 10)
                    
                    // Zone Cadeau et Quizz
                    HStack{
                        NavigationLink(destination: NewCardsWonView()){
                            VStack{
                                Image(systemName: "gift").font(.title)
                                Text("Cadeau").padding(.top)
                                
                            }.frame(width: 70, height: 70).padding()
                            .background(Color.white).cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        }.padding(.horizontal)
                        
                        NavigationLink(destination: ContentView()){
                            VStack{
                                Image(systemName: "questionmark").font(.title)
                                Text("Quizz").padding(.top)
                                
                            }.frame(width: 70, height: 70).padding()
                            .background(Color.white).cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        }.padding(.horizontal)
                        
                    }
                    
                    // Mise en place de la grille des collections
                    GridStack(rows: 4, columns: 3, hSpacing: 0, vSpacing: 0){row, col in
                        VStack{
                            LittleCardView(titreCollection: self.collectionTypes[row * 3 + col].name, imageCollection: self.collectionTypes[row * 3 + col].image, couleurCard: self.collectionTypes[row * 3 + col].rawValue
                            )
                        }.padding(.top, 20)
                       
                   }
                    
                }
            }
        }.edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
