//
//  CardRectoView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct CardRectoView: View {
    var body: some View {
        
        ZStack {
            VStack {
                Text("")
            }
            .frame(width: UIScreen.main.bounds.width * 100/100, height: UIScreen.main.bounds.height * 120/100)
            .background(Color("tree"))
            .edgesIgnoringSafeArea(.all)

            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .frame(width: 20)
                        .padding()
                        .overlay(
                        Circle()
                        .stroke(lineWidth: 1)
                        .padding(6)
                    )
                    .padding(.trailing, 20)
                    .padding(.top, 30)
                    .opacity(0.3)

                    
                }
                Image("chene")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
                    .padding(.top, 30)
                Spacer()
                
                HStack {
                    Text("Chêne")
                        .font(.title)
                    Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: 25, height: 25)
                    .overlay(
                        Text("?")
                    )
                        .opacity(0.3)
                }
                Spacer()
                HStack(spacing: 20) {
                    VStack {
                        Image("foret")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                        Text("forêt")
                            .font(.footnote)
                    }
                    VStack {
                        Image("campagne")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                        Text("campagne")
                            .font(.footnote)
                    }

                }
                .opacity(0.8)
                
                Spacer().frame(height: 30)
            }
            .background(Color("cardBackground"))
            

            .frame(width: UIScreen.main.bounds.width * 85/100, height: UIScreen.main.bounds.height * 75/100)
            .cornerRadius(70)
            .shadow(color: Color.black.opacity(0.4), radius: 8, x: 4, y: 4)
            
            .rotation3DEffect(Angle(degrees: Double(-18)) , axis: (x: 0, y: 1, z: 0))

        }
        


    }
    
}

struct CardRectoView_Previews: PreviewProvider {
    static var previews: some View {
        CardRectoView()
    }
}
