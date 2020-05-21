//
//  ParametresView.swift
//  TerraCards
//
//  Created by MacBookGP on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI


struct choice {
    
    let colorChoice:Color
    func changeColor( choice:Color ) {
        
    }
    
}




struct ParametresView: View {
    
    @State var choiceHabitat = ["sea", "mountain", "city", "countryside"]
 
    @State var activationLocal:Bool = false
    @State var choiceEnvironnement:String = ""
    @State var colorMountain = Color.gray
    @State var colorCity = Color.green
    @State var colorSea = Color.gray
    @State var colorCoutryside = Color.gray
    
    var body: some View {
  //      NavigationView {
            VStack{
 //               Spacer()
                Text("Dans quel environnement habites tu ?")
                HStack {
                    VStack {
                        ZStack {
                                Image("montagne").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(self.colorMountain,lineWidth: 4))

                        }.frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            self.choiceEnvironnement = self.choiceHabitat[1]
                            self.colorCity = Color.gray
                            self.colorMountain = Color.green
                            self.colorSea = Color.gray
                            self.colorCoutryside = Color.gray
                            print("choix environnement \(self.choiceEnvironnement)")
                        }
                         Text("En montagne")
                    }.padding()
                    VStack {
  
                     ZStack {
                                Image("ville").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(self.colorCity,lineWidth: 4))
                        }.frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            self.choiceEnvironnement = self.choiceHabitat[1]
                            self.colorCity = Color.green
                            self.colorMountain = Color.gray
                            self.colorSea = Color.gray
                            self.colorCoutryside = Color.gray
                            print("choix environnement \(self.choiceEnvironnement)")
                        }

                        Text("En Ville")
                    }.padding()
                }
                HStack {
                    VStack {
                        ZStack {
                                Image("foret")
                                    .renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(self.colorSea,lineWidth: 4))
                        }.frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            self.choiceEnvironnement = self.choiceHabitat[1]
                            self.colorCity = Color.gray
                            self.colorMountain = Color.gray
                            self.colorSea = Color.green
                            self.colorCoutryside = Color.gray
                            print("choix environnement \(self.choiceEnvironnement)")
                        }
                        Text("En forêt")
                    }.padding()
                    VStack {
                        ZStack {
                                Image("campagne").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(self.colorCoutryside,lineWidth: 4))
                        }.frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            self.choiceEnvironnement = self.choiceHabitat[1]
                            self.colorCity = Color.gray
                            self.colorMountain = Color.gray
                            self.colorSea = Color.gray
                            self.colorCoutryside = Color.green
                            print("choix environnement \(self.choiceEnvironnement)")
                        }
                        Text("En campagne")
                    }.padding()
                }
                Spacer()
                VStack {
                    Text("Pour plus de précision, active la géolocalisation dans les paramétres du smartphone")
                        .multilineTextAlignment(.center)
                    Toggle(isOn: $activationLocal) {
                        Text("Activer la géolocalisation")
                    }
                }.padding()
            }
            
            /*
                .navigationBarItems(leading: Button(action: {self.annul = true }) {
                Text("Retour")}.sheet(isPresented: self.$annul) { Accueil() }, trailing: Button(action: { self.accueil = true }) {
                    Text("Valider")}.sheet(isPresented: self.$accueil) { Accueil()})
             .navigationBarTitle("Environnement", displayMode: .inline)
             */
  //      }
    }
}

struct ParametresView_Previews: PreviewProvider {
    static var previews: some View {
        ParametresView()
    }
}



