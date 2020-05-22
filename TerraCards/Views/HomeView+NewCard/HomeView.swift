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
    
    @EnvironmentObject var cardsModelView: CardsLists
    //cardsModelView.wonCards
    
    let collectionTypes = CollectionType.allCases
    
    var body: some View {
        
            ZStack {
                Color("generalBackgroundColor").opacity(0.25)
                ScrollView(.vertical, showsIndicators: false){
                VStack{
                    // Zone du haut
                    HStack{
                        // Titre de l'application
//                        Text("Terra Cards").font(.largeTitle).padding()
                        Text("")
                        
                    }.padding(.top, 40).padding(.horizontal, 10)
                    
                    // Zone Cadeau et Quizz
                    HStack{
                        NavigationLink(destination: NewCardsWonView()){
                            
                            VStack{
                                Image(systemName: "gift.fill").font(.largeTitle)
                                Text("Cadeau").padding(.top)
                                    .opacity(0.6)
                                
                            }.frame(width: 70, height: 70).padding()
                            .background(Color("spider")).cornerRadius(20)
                                .foregroundColor(Color(UIColor.systemBlue))
                            .shadow(color: Color.white.opacity(0.4), radius: 5, x: -5, y: -5)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                        }.padding(.horizontal)
                        
                        NavigationLink(destination: ContentView()){
                            VStack{
                                Image(systemName: "questionmark").font(.title)
                                Text("Quizz").padding(.top)
                                
                            }.frame(width: 70, height: 70).padding()
                                .background(Color.gray).cornerRadius(20)
                                .opacity(0.3)
                            .foregroundColor(.black)
                            
//                            .shadow(color: Color.white.opacity(0.4), radius: 5, x: -5, y: -5)
//                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 10, y: 10)
                        }.padding(.horizontal)
                        
                    }
                    
                    // Mise en place de la grille des collections
                    GridStack(rows: 4, columns: 3, hSpacing: 7, vSpacing: 0){row, col in
                        VStack{
                            NavigationLink(destination: CollectionView(collection: self.collectionTypes[row * 3 + col]).environmentObject(self.cardsModelView)) {
                                LittleCardView(titreCollection: self.collectionTypes[row * 3 + col].name, imageCollection: self.collectionTypes[row * 3 + col].image, couleurCard: self.collectionTypes[row * 3 + col].rawValue
                                )
                            }.padding(.top, 20)
                        }
                       
                   }
                    
                }
            }
        }.edgesIgnoringSafeArea(.all)
            
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let env = CardsLists()
        return HomeView()
            .environmentObject(env)
            .onAppear(){
                env.fillLists(){response in
                    switch response {
                    case .success:
                        // ici ce sont les cartes qui étaient déjà dans les UserSettings
                        for card in env.wonCards {
                            print("carte de départ en preview : \(card.name ?? "")")
                        }
                        
                        
                        //                carte de départ en preview : Optional("Chêne")
                        //                carte de départ en preview : Optional("Dauphin")
                        //                carte de départ en preview : Optional("Ortie")
                        //                carte de départ en preview : Optional("Pavot cornu")
                        //                carte de départ en preview : Optional("Jacinthe des bois")
                        
                        // on en gagne quelques autres pour le fun, attention si le nom est pas le même exactement que dans la base : crash
                        var cardsToAdd: [Card] = []
                        cardsToAdd.append(env.allCards.first(where: {$0.name == "Mésange bleue"})!)
                        cardsToAdd.append(env.allCards.first(where: {$0.name == "Vipère aspic"})!)
                        env.winCards(cards: cardsToAdd)
                        
                    case .failure :
                        print("mince")
                    }
                }
                
        }
        
    }
}
