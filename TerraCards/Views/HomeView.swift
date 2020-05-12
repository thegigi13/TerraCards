//
//  HomeView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let collectionTypes = CollectionType.allCases
    
    var body: some View {
        ScrollView{
            ZStack {
                Color.offWhite
                
                VStack{
                    // Zone du haut
                    HStack{
                        VStack{
                            Image(systemName: "rosette")
                            Text("Trophées")
                        }
                        Text("Terra Cards").font(.largeTitle).padding()
                        VStack{
                            Image(systemName: "gear")
                            Text("Profil")
                        }
                    }
                    
                    // faire apparaitre les noms de CollectionType
                    VStack{
                        ForEach(collectionTypes, id:\.self){type in
                            LittleCardView(titreCollection: "\(type.name)", imageCollection : "\(type.image)")
                        }
                    }
                    
                }.padding(.top, 40)
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
