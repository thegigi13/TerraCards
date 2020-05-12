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
    var body: some View {
            // création de l'extractingView pour la HomeView
            VStack{
                    RoundedRectangle(cornerRadius: 25)
                    .fill(Color.offWhite)
                    .frame(width: 100, height: 140)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .padding(.horizontal, 10)
                        .overlay(Image("\(imageCollection)").resizable().frame(width: 90, height: 90))
                
                Text("\(titreCollection)")
            }
    }
}

struct LittleCardView_Previews: PreviewProvider {
    static var previews: some View {
        LittleCardView(titreCollection: "Amphibiens", imageCollection : "pictureFrog")
    }
}
