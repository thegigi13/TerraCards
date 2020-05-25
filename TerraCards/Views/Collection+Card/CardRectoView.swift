//
//  CardView.swift
//  TerraCards
//
//  Created by foxy on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct CardRecto: View {
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
            
            if card.imageRecto != nil {
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
              card.imageRecto!
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 270)
                .padding(.top, 30)
                
                
            } else {
                imageDefault()
                    //.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: UIScreen.main.bounds.height * 100/100, alignment: .center)
                    .cornerRadius(12)
                    .contentShape(Rectangle())
                    .clipped()
                    .onAppear() {
                        self.card.loadingImages()
                    }
                .allowsHitTesting(false)

            }
            
                
            Spacer()
            
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
            HStack(spacing: 20) {
                ForEach(card.habitats, id: \.self) { habitat in
                    VStack {
                        Image(habitat.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:50)
                        Text(habitat.name)
                            .font(.footnote)
                    }
                }
                
                
            }
            .opacity(0.8)
            Spacer().frame(height: 30)
        }
    }
}

struct CardRecto_Previews: PreviewProvider {
    static var previews: some View {
        CardRecto(card: Card())
    }
}
