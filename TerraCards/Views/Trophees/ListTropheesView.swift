//
//  TropheesView.swift
//  TerraCards
//
//  Created by MacBookGP on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI
import MapKit


struct TropheesView: View {
    
    private let collection = CollectionType.allCases
    @EnvironmentObject var listeCards: CardsLists
    private let valeurMax:CGFloat = 170.0
    
    @State var accueil:Bool = false
    
    var body: some View {
    //    NavigationView {
            ZStack {
                Color("colorTrophee")
                 VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            HStack {   // carte total
                                CardTropheeView(image: "hat-school" , contour: listeCards.numbersColorCards())
                                    .padding()
                                VStack {
                                    
                                    HStack {
                                        Text("Total de Cartes")
                                            .font(.callout)
                                        Text("\(listeCards.numbersMaxObtainedCards().nbCardObtained)")
                                    }.foregroundColor(Color.gray)
                                    EvolutionBar(valEvolutionBar: listeCards.numbersMaxObtainedCards().nbCardEvoltionBar)
                                        .padding()
                                }.padding()
                            }.background(Color.colorTrophees)
                            HStack {   // carte cadeeaux
                                CardTropheeView(image: "Cadeaux-cards" , contour: Color.gray)
                                    .padding()
                                VStack {
                                    HStack {
                                        Text("Cartes Cadeaux")
                                            .font(.callout)
                                        Text("4")
                                    }.foregroundColor(Color.gray)
                                    EvolutionBar(valEvolutionBar: 20)
                                        .padding()
                                }.padding()
                            }.background(Color.colorTrophees)
                            HStack {  // carte quizz
                                CardTropheeView(image: "Quizz" , contour: Color.gray)
                                    .padding()
                                VStack {
                                    HStack {
                                        Text("Cartes Quizz")
                                            .font(.callout)
                                        Text("4")
                                    }.foregroundColor(Color.gray)
                                    EvolutionBar(valEvolutionBar: 30)
                                        .padding()
                                }.padding()
                            }.background(Color.colorTrophees)
                            ForEach(collection , id: \.id) { trophee in
                                  // toute les autres carte
                                HStack {
                                    CardTropheeView(image: trophee.image, contour: self.listeCards.numberCardsMaxCollection(collection: trophee).cardColor)
                                        .padding()
                                    VStack {
                                        HStack {
                                            Text("\(trophee.image)")
                                                .font(.callout)
                                            Text("\(self.listeCards.numberCardsMaxCollection(collection: trophee).obtained)")
                                        }.foregroundColor(Color.gray)
                                        EvolutionBar(valEvolutionBar: self.listeCards.numberCardsMaxCollection(collection: trophee).numberEvolutionBar)
                                            .padding()
                                    }.padding()
                                }.background(Color.colorTrophees)
                            }
                        }.padding(.top, 70.0)
                }
            }
           .edgesIgnoringSafeArea(.all)
    /*
                .navigationBarTitle("Trophées", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {self.accueil = true }) { Text("Accueil")}.sheet(isPresented: self.$accueil) { Accueil() }
            )
 */
  //      }
    }
}



struct TropheesView_Previews: PreviewProvider {
    static var previews: some View {
        let env = CardsLists()
        return TropheesView()
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
