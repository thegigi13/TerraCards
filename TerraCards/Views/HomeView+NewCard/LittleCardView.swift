//
//  LittleCardView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct LittleCardView: View {
    var titreCollection : String
    var imageCollection : String
    var couleurCard: String
    @State private var showingAlert = false
    
    var layers: Int = 5
    var doubleLayers: CGFloat { CGFloat(layers * 2)    }
    var doubleIntLayers: Int { Int(doubleLayers)}
    // création de l'extractingView pour la HomeView
    var body: some View {
        
        VStack {
            ZStack{
                ForEach((0..<doubleIntLayers), id: \.self) {i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(i % 2 == 0 ? Color(UIColor.systemGray2) : Color(UIColor.systemGray3))
                        .frame(width: 100, height: 140)
                        
                        
                        
                        .offset(x: (self.doubleLayers - CGFloat(i)) * 0.5, y: (self.doubleLayers - CGFloat(i)) * 0.5)
                }

                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white).frame(width: 100, height: 140)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(couleurCard).opacity(0.7))
                    .frame(width: 100, height: 140)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .padding(.horizontal, 10)
                    .overlay(Image("\(imageCollection)").renderingMode(.original).resizable().scaledToFit().frame(width: 90, height: 90))
            }
            Text (titreCollection).foregroundColor(.black)
        }
    }
}

struct LittleCardView_Previews: PreviewProvider {
    static var previews: some View {
        LittleCardView(titreCollection: "Amphibiens", imageCollection : "grenouille2", couleurCard: "amphibian")
    }
}
