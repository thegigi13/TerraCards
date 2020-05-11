//
//  TropheesView.swift
//  TerraCards
//
//  Created by MacBookGP on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI


/*
struct Trophee {
    var name : String
}

final class ListeTrophee: ObservableObject {
    @Published var trophee: [Trophee] = [
    .init(name: "hat-school"),
    .init(name: "Cadeaux-cards"),
    .init(name: "Quizz"),
    .init(name: "Rare"),
    .init(name: "Insectes"),
    .init(name: "Arbres"),
    .init(name: "Mollusques"),
    .init(name: "Poissons"),
    .init(name: "Plantes")
    ]
}

*/


struct TropheesView: View {
  
    @State private var numberTotalCard:Int = 9
  
    var tropheeListe = ["hat-school", "Cadeaux-cards", "Quizz", "Rare", "Insectes", "Arbres", "Mollusques", "Poissons", "Plantes" ]
    
    var body: some View {
        
        ZStack {
                         Color.colorTrophees
        NavigationView {
 
        VStack {

            List {
                ForEach(self.tropheeListe, id: \.self) {nameTrophee in
                    
                    HStack {
                        CardRectoView(image: nameTrophee , contour: Color.gold)
                            .padding()
                        VStack {
                            Text("Total de \(self.numberTotalCard) cartes")
                                .foregroundColor(Color.gray)
                            EvolutionBar()
                                .padding()
                        }.padding()
                    }.background(Color.colorTrophees)
                }
                
            }
            
            
 /*           HStack {
                CardRectoView(image: "hat-school", contour: Color.gold)
                    .padding()
                VStack {
                    Text("Total de \(self.numberTotalCard) cartes")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
          HStack {
                CardRectoView(image: "Cadeaux-cards", contour: Color.gold)
                    .padding()
                VStack {
                    Text("Cartes reçus aujourd'hui : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
           HStack {
                CardRectoView(image: "Quizz", contour: Color.gray)
                    .padding()
                VStack {
                    Text("Quizz Réussis : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
            HStack {
                CardRectoView(image: "Rare", contour: Color.gray)
                    .padding()
                VStack {
                    Text("Cartes Rares : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
            HStack {
                CardRectoView(image: "Insectes", contour: Color.silver)
                    .padding()
                VStack {
                    Text("Cartes Insectes : 3")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
            HStack {
                CardRectoView(image: "Arbres", contour: Color.gray)
                    .padding()
                VStack {
                    Text("Cartes Arbres : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
            HStack {
                CardRectoView(image: "Mollusques", contour: Color.gray)
                    .padding()
                VStack {
                    Text("Cartes Poissons : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
            HStack {
                CardRectoView(image: "Plantes", contour: Color.silver)
                    .padding()
                VStack {
                    Text("Cartes Mollusques : 0")
                        .foregroundColor(Color.gray)
                    EvolutionBar().padding()
                }.padding()
            }
 */
        }.background(Color.colorTrophees)
        .navigationBarTitle("Trophee")
        .navigationBarItems(leading: Text("Accueil"))
            }
        }
    }
}

struct TropheesView_Previews: PreviewProvider {
    static var previews: some View {
        TropheesView()
    }
}
