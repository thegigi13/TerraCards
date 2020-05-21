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

    
    @State var accueil:Bool = false
    
    var body: some View {
    //    NavigationView {
            ZStack {
                Color.colorTrophees
                 VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            HStack {   // carte total
                                CardTropheeView(image: "hat-school" , contour: listeCards.numbersColorCards())
                                    .padding()
                                VStack {
                                    
                                    HStack {
                                        Text("Total de Cartes")
                                            .font(.callout)
                                        Text("\(listeCards.cardsObtained())")
                                    }.foregroundColor(Color.gray)
                                    EvolutionBar(valMax: CGFloat(CGFloat(listeCards.numbersMaxCards())), val: CGFloat(CGFloat(listeCards.cardsObtained())))
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
                                    EvolutionBar(valMax: CGFloat(4), val: CGFloat(20))
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
                                    EvolutionBar(valMax: CGFloat(4), val: CGFloat(20))
                                        .padding()
                                }.padding()
                            }.background(Color.colorTrophees)
                            ForEach(collection , id: \.id) { trophee in
                                  // toute les autres carte
                                HStack {
                                    CardTropheeView(image: trophee.name, contour: self.listeCards.numberCardsMaxCollection(collection: trophee).cardColor)
                                        .padding()
                                    VStack {
                                        HStack {
                                            Text(" Cartes ")
                                            Text("\(trophee.name)")
                                                .font(.callout)
                                            Text("\(self.listeCards.numberCardsMaxCollection(collection: trophee).obtained)")
                                        }.foregroundColor(Color.gray)
                                        EvolutionBar(valMax: CGFloat(self.listeCards.numberCardsMaxCollection(collection: trophee).collectionMax),
                                                     val: CGFloat(self.listeCards.numberCardsMaxCollection(collection: trophee).obtained))
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
                env.fetchAllCards(){response in
                    print("chargé")
                }
        }
        
    }
}
