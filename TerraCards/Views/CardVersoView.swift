//
//  CardVersoView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct CardVerso: View {
    @ObservedObject var card: Card
    
    struct imageDefault: View {
        var body: some View {
            Image("photoChene")
                .saturation(0.0)
                .opacity(0.3)
        }
    }

    var body: some View {
        VStack {
//            ZStack {
//
//                VStack {
//                    HStack {
//                        Spacer()
//                        Image(systemName: "xmark")
//                            .frame(width: 20)
//                            .padding()
//                            .overlay(
//                                Circle()
//                                    .stroke(lineWidth: 1)
//                                    .padding(6)
//                        )
//                            .padding(.trailing, 20)
//                            .padding(.top, 30)
//                            .opacity(0.3)
//
//                    }
//                    Spacer()
//                }
//
//            }
//            .clipped()
            VStack {
//                Capsule().overlay(Image("photoChene")
//                //.resizable()
//                )
                if card.imageVerso != nil {
                    card.imageVerso!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: UIScreen.main.bounds.height * 85/100 / 2, alignment: .center)
                        .cornerRadius(12)
                        .contentShape(Rectangle())
                        .clipped()
                        .onAppear() {
                            self.card.loadingImages()
                        }
                } 
                Spacer()
            }
            .allowsHitTesting(false)
            

            
            HStack {
                Text(card.name)
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
            HStack {
                Text(card.anecdote ?? "")
                .padding()
            }
            //.frame(width: 270)
            
            Spacer().frame(height: 50)
        }
    }
}

struct CardVerso_Previews: PreviewProvider {
    static var previews: some View {
        CardVerso(card: Card())
    }
}
