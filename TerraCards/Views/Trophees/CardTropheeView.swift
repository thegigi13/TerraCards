//
//  CardTropheeView.swift
//  TerraCards
//
//  Created by MacBookGP on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct CardTropheeView: View {
    
    @State var image:String
    @State var contour:Color
    var radius: CGFloat {
        switch self.contour {
        case .gold: return 5
        case .black: return 1.5
        case .green: return 3
        case .gray: return 0
        default: return -10
        }
    }
    
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                //    .frame(width: 200, height: 200)
                    .shadow(color: self.contour.opacity(0.2), radius: 10, x: 1, y: 1)
                
                .shadow(color: self.contour.opacity(0.2), radius: 10, x: -1, y: -1)
                
                
            )
            //RoundedRectangle(cornerRadius: 15)
            
            Image(self.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            //.background(Color.white)
            .frame(width: 60.0, height: 70.0)
        }.frame(width: 70, height: 90)
            
            
        
    }
}

struct CardTropheeView_Previews: PreviewProvider {
    static var previews: some View {
        CardTropheeView(image: "test", contour: Color.black)
    }
}
