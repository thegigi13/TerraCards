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
   
    let collection = [CollectionType.dinosaur, CollectionType.insect, CollectionType.plant, CollectionType.bird, CollectionType.amphibian, CollectionType.fish, CollectionType.largeMammal, CollectionType.mollusc, CollectionType.reptile, CollectionType.smallMammal, CollectionType.tree, CollectionType.spider]
    
    
    @State var accueil:Bool = false
    @State var tropheeListe:[CarteTrophee] = [


        CarteTrophee(id: .init(), name: "Cadeaux-cards", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes recus ce jour :"),
        CarteTrophee(id: .init(), name: "Quizz", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Quizz réussis :"),
        CarteTrophee(id: .init(), name: "Rare", colorTrophee: .gray, numberMax: 10, numberMin: 0, textType: "  Cartes rares :"),
        CarteTrophee(id: .init(), name: "insectes", colorTrophee: .gold, numberMax: 170, numberMin: 170, textType: "Cartes insectes :"),
        CarteTrophee(id: .init(), name: "Arbres", colorTrophee: .black, numberMax: 10, numberMin: 1, textType: "Cartes arbres :"),
        CarteTrophee(id: .init(), name: "Mollusques", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes Mollusques :"),

      ]
    
    
    
    var body: some View {
    //    NavigationView {
            ZStack {
                Color.colorTrophees
                 VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            HStack {
                                CardTropheeView(image: "hat-school" , contour: Color.gray)
                                    .padding()
                                VStack {
                                    
                                    HStack {
                                        Text("Total de Cartes")
                                            .font(.callout)
                                            
                                        Text("4")
                                           
                                    }.foregroundColor(Color.gray)
                                    EvolutionBar(valMax: CGFloat(4), val: CGFloat(20))
                                        .padding()
                                }.padding()
                            }.background(Color.colorTrophees)
                            
                            
                            
                            
                            
                            ForEach(collection , id: \.id) { trophee in
                                
                                HStack {
                                    CardTropheeView(image: trophee.name, contour: Color.gray)
                                        .padding()
                                    VStack {
                                        
                                        HStack {
                                            Text("Cartes")
                                            Text("\(trophee.name)")
                                                .font(.callout)
                                                
                                            Text("5")
                                           
                                               
                                        }.foregroundColor(Color.gray)
                                        EvolutionBar(valMax: CGFloat(30), val: CGFloat(50))
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

            TropheesView()

        
    }
}
