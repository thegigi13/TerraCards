//
//  MiniCardView.swift
//  TerraCards
//
//  Created by foxy on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct MiniCardView: View {
    @State var scale: CGFloat = 0.3
    @Binding var isACardClicked: Bool
    @Binding var opacity: CGFloat
    @State var big: Bool = false
    @State var pos: CGPoint = CGPoint(x: 70, y: 780)
    var sourcePos: CGPoint = CGPoint(x: 0, y: 0)
    @ObservedObject var card: Card
    var bgColor: Color = Color.black

    var body: some View {
        
        return ZStack {
            
            
            
            GeometryReader { proxy in
                    ZStack {
                        VStack {
                            Spacer()
                        }

                        .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                        .background(self.bgColor)
                        .opacity(self.big ? 1 : 0)
                        
                        CardFlip(bgColor: Color(self.card.collection.rawValue),versoView: {
                            AnyView(CardVerso(card: self.card))
                        }, rectoView: {
                            CardRecto(card: self.card)
                        })
                        
                    }
                        

                        .disabled(!self.big)
                        
                        .position(self.pos)
                        
                        .opacity(!self.big ? Double(self.opacity) : 1)
                        
                    
                    
                    .scaleEffect(self.scale, anchor: .center)
                    
                    .onTapGesture {
                        withAnimation(.linear(duration: 0)) {
                            if self.opacity == 0 {
                                self.opacity = 1
                            } else {
                                self.opacity = 0
                            }
                        }
                        
                        
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 1)) {
                            
                            if !self.big {
                                self.scale = 0.9
                                self.big = true
                                self.isACardClicked = true
                                self.pos = CGPoint(x: (270 - proxy.frame(in: .global).center.x), y: 600 - proxy.frame(in: .global).center.y)
                            }
                            else {
                                self.scale = 0.3
                                self.big = false
                                self.isACardClicked = false
                                self.pos = CGPoint(x: 70, y: 780)
                            }
                        }
                        
                        
                    }
                
                .disabled(!self.big ? self.isACardClicked : false)
            }
        }
    }
}


extension CGRect {
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
}

struct MiniCardView_Previews: PreviewProvider {
    static var previews: some View {
        MiniCardView(isACardClicked: .constant(false), opacity: .constant(1), card: Card())
    }
}
