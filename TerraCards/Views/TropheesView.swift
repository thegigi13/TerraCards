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
    let colorTrophee
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
    
    @State var tropheeListe:[CarteTrophee] = [

        CarteTrophee(id: .init(), name: "hat-school", colorTrophee: .black, numberMax: 170, numberMin: 50, textType: "Total de cartes :"),
        CarteTrophee(id: .init(), name: "Cadeaux-cards", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes recus ce jour :"),
        CarteTrophee(id: .init(), name: "Quizz", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Quizz réussis :"),
        CarteTrophee(id: .init(), name: "Rare", colorTrophee: .gray, numberMax: 50, numberMin: 0, textType: "Cartes rares :"),
        CarteTrophee(id: .init(), name: "Insectes", colorTrophee: .gold, numberMax: 170, numberMin: 170, textType: "Cartes insectes :"),
        CarteTrophee(id: .init(), name: "Arbres", colorTrophee: .black, numberMax: 10, numberMin: 1, textType: "Cartes arbres"),
        CarteTrophee(id: .init(), name: "Mollusques", colorTrophee: .black, numberMax: 20, numberMin: 2, textType: "Cartes Mollusques :"),
        CarteTrophee(id: .init(), name: "Poissons", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Cartes Poissons :"),
        CarteTrophee(id: .init(), name: "Plantes", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes plantes :"),
        
        
        CarteTrophee(id: .init(), name: "Grands-mammiferes", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Grands mammifères :"),
        CarteTrophee(id: .init(), name: "Oiseaux", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes Oiseaux :"),
        CarteTrophee(id: .init(), name: "Reptiles", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Cartes reptiles :"),
        CarteTrophee(id: .init(), name: "Amphibiens", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes Amphibiens :"),
        CarteTrophee(id: .init(), name: "Petits-mammiferes", colorTrophee: .gray, numberMax: 20, numberMin: 0, textType: "Petits mammiphères :"),
        CarteTrophee(id: .init(), name: "Arachnides", colorTrophee: .black, numberMax: 20, numberMin: 1, textType: "Cartes arachnides :")
        
      ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorTrophees
                 VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(tropheeListe , id: \.id) { trophee in
                                
                                HStack {
                                    CardTropheeView(image: trophee.name , contour: trophee.colorTrophee)
                                        .padding()
                                    VStack {
                                        
                                        HStack {
                                            Text("\(trophee.textType ?? "Cartes ")")
                                                .font(.callout)
                                                
                                            Text("\(trophee.numberMin)")
                                               
                                        }.foregroundColor(Color.gray)
                                        EvolutionBar(valMax: CGFloat(trophee.numberMax), val: CGFloat(trophee.numberMin))
                                            .padding()
                                    }.padding()
                                }.background(Color.colorTrophees)
                            }
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Trophee", displayMode: .inline)
            .navigationBarItems(leading: Text("Accueil"))
        }
    }
}

struct TropheesView_Previews: PreviewProvider {
    static var previews: some View {

            TropheesView()

        
    }
}
