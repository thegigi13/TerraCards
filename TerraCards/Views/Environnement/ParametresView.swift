//
//  ParametresView.swift
//  TerraCards
//
//  Created by MacBookGP on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ParametresView: View {
    
    @State var selectUserLocation: UserLocation? // variable de localisation
    let user:[UserLocation]

    @State var isActive: Bool = false
    @State var choiceHabitat = ["sea", "mountain", "city","forest", "countryside"]
    @State var habitat = HabitatType.init(rawValue: "")
    @State var activationLocal:Bool = false
    @State var choiceEnvironnement:String = ""
    @State var colorMountain = Color.gray
    @State var colorCity = Color.green
    @State var colorSea = Color.gray
    @State var colorCoutryside = Color.gray
    
    var body: some View {
        ZStack {
            Color("colorEnvironnement")
            VStack{
                    Text("Dans quel environnement habites tu ?")
                    HStack {
                        VStack {
                            ZStack {
                                    Image("mountains").renderingMode(.original)
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
                                    Image("city").renderingMode(.original)
                                        .resizable()
                                        .overlay(Circle().stroke(self.colorCity,lineWidth: 4))
                            }.frame(width: 150.0, height: 150.0)
                            .onTapGesture {
                                self.choiceEnvironnement = self.choiceHabitat[2]
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
                                    Image("forest")
                                        .renderingMode(.original)
                                        .resizable()
                                        .overlay(Circle().stroke(self.colorSea,lineWidth: 4))
                            }.frame(width: 150.0, height: 150.0)
                            .onTapGesture {
                                self.choiceEnvironnement = self.choiceHabitat[3]
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
                                    Image("sea").renderingMode(.original)
                                        .resizable()
                                        .overlay(Circle().stroke(self.colorCoutryside,lineWidth: 4))
                            }.frame(width: 150.0, height: 150.0)
                            .onTapGesture {
                                self.choiceEnvironnement = self.choiceHabitat[0]
                                self.colorCity = Color.gray
                                self.colorMountain = Color.gray
                                self.colorSea = Color.gray
                                self.colorCoutryside = Color.green
                                print("choix environnement \(self.choiceEnvironnement)")
                            }
                            Text("En Mer")
                        }.padding()
                    }
                //    Spacer()
                    VStack {
                        Text("Pour plus de précision, activer la géolocalisation dans les paramétres du smartphone").padding()
                            .multilineTextAlignment(.center)
                        Toggle(isOn: $activationLocal) {
                            Text("Activer la géolocalisation")
                        }
                        VStack{
                              LocalisationMap(coordonneeLocalUser: $selectUserLocation, isActive: $activationLocal, local: [])
                        }.frame(width: 170 , height: 30)
                    }.padding()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ParametresView_Previews: PreviewProvider {
    static var previews: some View {
        ParametresView(user: [UserLocation.init(user: .init(latitude: 23, longitude: 34))])
    }
}



