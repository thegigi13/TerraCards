//
//  EvolutionBar.swift
//  TerraCards
//
//  Created by MacBookGP on 11/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct EvolutionBar: View {
    
    @State var valMax = CGFloat(170)
    @State var val = CGFloat(10)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .frame(width: 170, height: 2.0)
                .foregroundColor(Color.gray)
                .opacity(0.2)
            Rectangle()
                .frame(width: self.val, height: 2.0)
                .foregroundColor(Color.blue)
        }
   }
}

struct EvolutionBar_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionBar()
    }
}
