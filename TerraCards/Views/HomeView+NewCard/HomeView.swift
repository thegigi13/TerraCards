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
    let collectionTypes = CollectionType.allCases
    
    func isCollEmpty(collection: CollectionType) -> Bool {
        
        var numberOfCardsInCollection = 0
        var collectionEmpty : Bool = true
        
        cardsModelView.wonCards.forEach { card in
            if card.collection == collection {
                numberOfCardsInCollection += 1
            }
            else{
                print(cardsModelView.wonCards)
            }
        }

        if numberOfCardsInCollection == 0 {
            return collectionEmpty == true
        } else {
            return collectionEmpty == false
        }
    }
    
    @State var alreadyWonCards = false // à changer avec possibleToWinMoreForFree ?
    @State private var showPlayAlertOne: Bool = false
    @State private var activateLinkOne: Bool = false
    
    @State var alreadyPlayed = false // à changer avec possibleToWinMoreForFree ?
    @State private var showPlayAlertTwo: Bool = false
    @State private var activateLinkTwo: Bool = false
    
    var body: some View {
        
            ZStack {
                Color("generalBackgroundColor").opacity(0.25)
                ScrollView(.vertical, showsIndicators: false){
                VStack{
                    // Zone du haut
                    HStack{
                        // Titre de l'application
                        Text("Terra Cards").font(.largeTitle).padding()
                        //Text("")
                        
                    }.padding(.top, 40).padding(.horizontal, 10)
                    
                    // Zone Cadeau et Quizz
                    HStack{
                        VStack{
                        NavigationLink(destination: NewCardsWonView(), isActive: $activateLinkOne, label: {
                            Button(action: {
                                if self.alreadyWonCards == true{
                                    self.showPlayAlertOne = true
                                } else {
                                    self.showPlayAlertOne = false
                                    self.activateLinkOne = true
                                    self.alreadyWonCards.toggle()
                                }
                            }) {
                            VStack{
                                Image(systemName: "gift.fill").font(.largeTitle)
                                Text("Cadeau").padding(.top)
                                    .opacity(0.6)
                                
                            }.frame(width: 70, height: 70).padding()
                                .background(Color("spider")).cornerRadius(20)
                                .foregroundColor(Color(UIColor.systemBlue))
                                .shadow(color: Color.white.opacity(0.4), radius: 5, x: -5, y: -5)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                            .padding(.horizontal)
                            }
                                })
                            }.alert(isPresented: $showPlayAlertOne) {
                                Alert(title: Text("Vous avez déjà gagné des cartes aujourd'hui"), message: Text("Vous pouvez gagner de nouvelles cartes demain ou participer à un quizz"), dismissButton: .default(Text("OK")))
                            }
                        
                        
                        VStack{
                        NavigationLink(destination: NewCardsWonView(), isActive: $activateLinkTwo, label: {
                            Button(action: {
                                if self.alreadyPlayed == true{
                                    self.showPlayAlertTwo = true
                                } else {
                                    self.showPlayAlertTwo = false
                                    self.activateLinkTwo = true
                                    self.alreadyPlayed.toggle()
                                }
                            }) {
                            VStack{
                                Image(systemName: "questionmark").font(.title)
                                Text("Quizz").padding(.top)
                                
                            }.frame(width: 70, height: 70).padding()
                                .background(Color.gray).cornerRadius(20)
                                .opacity(0.3)
                            .foregroundColor(.black).padding(.horizontal)
                        }
                                })
                            }.alert(isPresented: $showPlayAlertTwo) {
                                Alert(title: Text("Vous avez déjà répondu à un quizz aujourd'hui"), message: Text("Vous pouvez à nouveau participer à un quizz demain"), dismissButton: .default(Text("OK")))
                            }
                        
                    }
                    
                    // Mise en place de la grille des collections
                    GridStack(rows: 4, columns: 3, hSpacing: 7, vSpacing: 0){row, col in
                        VStack{
                                LittleCardView(titreCollection: self.collectionTypes[row * 3 + col].name, imageCollection: self.collectionTypes[row * 3 + col].image, couleurCard: self.collectionTypes[row * 3 + col].rawValue, type: self.collectionTypes[row * 3 + col]
                                ).saturation(self.isCollEmpty(collection: self.collectionTypes[row * 3 + col]) ? 0.4 : 1)
                                .opacity(self.isCollEmpty(collection: self.collectionTypes[row * 3 + col]) ? 0.5 : 1)
                            
                        }.padding(.top, 20)
                       
                   }
                    Spacer().frame(height: 100)
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
