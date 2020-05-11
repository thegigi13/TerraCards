//
//  CardRectoView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI


extension Color {
    static let offwhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    static let lightStart = Color(red: 60/255, green: 160/255, blue: 240/255)
    static let lightEnd = Color(red: 30/255, green: 80/255, blue: 120/255)
    static let gold = Color(red: 255/255, green: 215/255, blue: 0/255)
    static let silver = Color(red: 206/255, green: 206/255, blue: 206/255)
    static let bronze = Color(red: 97/255, green: 78/255, blue: 26/255)
    static let colorTrophees = Color(red: 187/255, green: 222/255, blue: 221/255)
}


struct CardRectoView: View {
    
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

struct CardRectoView_Previews: PreviewProvider {
    static var previews: some View {
        CardRectoView(image: "", contour: Color.gray)
    }
}
