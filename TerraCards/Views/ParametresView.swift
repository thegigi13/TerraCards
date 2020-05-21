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
    
    @State var annul:Bool = false
    @State var accueil:Bool = false
    @State var activationLocal:Bool = false
    @State var choice:Bool = true
    @State var environment:String = ""
    @State var valideColor:Color = .gray
    var greenColor = Color.green
    
    var body: some View {
  //      NavigationView {
            VStack{
 //               Spacer()
                Text("Dans quel environnement habites tu ?")
                HStack {
                    VStack {
                        ZStack {
                            Button(action: {
                                self.choice.toggle()
                            }) {
                                Image("montagne").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(valideColor,lineWidth: 4))
                            }
                            if choice {
                                Circle().stroke(greenColor , lineWidth: 4)
                            }
                        }.frame(width: 150.0, height: 150.0)
                         Text("En montagne")
                    }.padding()
                    VStack {
  
                     ZStack {
                            Button(action: {
                                self.choice.toggle()
                            }) {
                                Image("ville").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(valideColor,lineWidth: 4))
                            }
                            if choice {
                                Circle().stroke(greenColor , lineWidth: 4)
                            }
                        }.frame(width: 150.0, height: 150.0)

                        Text("En Ville")
                    }.padding()
                }
                HStack {
                    VStack {
                        ZStack {
                            Button(action: {
                                self.choice.toggle()
                            }) {
                                Image("foret")
                                    .renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(valideColor,lineWidth: 4))
                            }
                            if choice {
                                Circle().stroke(greenColor , lineWidth: 4)
                            }
                        }.frame(width: 150.0, height: 150.0)
                        Text("En forêt")
                    }.padding()
                    VStack {
                        ZStack {
                            Button(action: {
                                self.choice.toggle()
                            }) {
                                Image("campagne").renderingMode(.original)
                                    .resizable()
                                    .overlay(Circle().stroke(valideColor,lineWidth: 4))
                            }
                            if choice {
                                Circle().stroke(greenColor , lineWidth: 4)
                            }
                        }.frame(width: 150.0, height: 150.0)
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



