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
    
    
    var body: some View {
        ZStack {
                   RoundedRectangle(cornerRadius: 10)
                       .fill(Color.white)
                   //    .frame(width: 200, height: 200)
                       .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                       .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
                    .shadow(color: self.contour, radius: 1, x: 2, y: 2)
                   Image(self.image)
                   .resizable()
                   .background(Color.white)
                   .frame(width: 40.0, height: 40.0)
        
               }.frame(width: 70, height: 90)
        
    }
}

struct CardTropheeView_Previews: PreviewProvider {
    static var previews: some View {
        CardTropheeView(image: "", contour: Color.black)
    }
}
