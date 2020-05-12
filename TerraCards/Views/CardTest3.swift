//
//  CardTest3.swift
//  TerraCards
//
//  Created by foxy on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct CardTest3<Content: View>: View {
    @State var currentPosition: CGSize = .zero
    @State var currentAngle: Double = .zero
    var currentAngleMod: Double {
        if (89.7...90.3).contains(abs(currentAngle)) {
            return 89.7*(currentAngle/abs(currentAngle))
        }
        else if (269.7...270.3).contains(abs(currentAngle)) {
            return 269.7*(currentAngle/abs(currentAngle))
        } else {
            return currentAngle
        }
    }
    @State var shadow: CGFloat = 4
    
    var left: Bool {
        if !flipped {
            if recto {
                return currentAngle<0
            }  else {
                return currentAngle>0
            }
        } else {
            if recto {
                return currentAngle>0
            }  else {
                return currentAngle<0
            }
        }
        
        
    }
    @State var flipped = false
    @State var newPosition: CGSize = .zero
    var recto: Bool {
        
        let q = Int(currentAngle).quotientAndRemainder(dividingBy: 90).0
        print("bon \(q)")
        if abs(q) == 0 || abs(q) == 3 || abs(q) == 4{
            return true
        } else {
            return false
        }
    }
    let gap = 0
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                
                self.currentPosition.height =  self.newPosition.height + value.translation.height
                
                let gap: CGFloat = CGFloat(self.gap)
                let negGap: CGFloat = -1*gap
                
                let totalTrans =  self.newPosition.width + value.translation.width
                
                if  Int(self.currentAngle+1) % 180 != 0 &&
                    Int(totalTrans).quotientAndRemainder(dividingBy: Int(180*1.7) + Int(gap)).1 < Int(gap) &&
                    Int(totalTrans).quotientAndRemainder(dividingBy: Int(180*1.7) - Int(gap)).1 > Int(negGap)
                {
                    self.currentPosition.width = totalTrans
                    return
                }
                if totalTrans > 0 {
                    self.currentAngle = Double((totalTrans - gap)/1.7)
                } else {
                    self.currentAngle = Double((totalTrans + gap)/1.7)
                }
                
                if self.currentAngle > 179 {
                    self.currentAngle = 179
                }
                if self.currentAngle < -179 {
                    self.currentAngle = -179
                    
                }
                if self.flipped {
                    if self.currentAngle >= 0 {
                        self.currentAngle += 180
                    } else {
                        self.currentAngle -= 180
                    }
                }
                if self.currentAngle > 0 {
                    self.currentPosition.width =  gap + (value.translation.width - gap)/2
                } else {
                    
                    self.currentPosition.width =  negGap + (value.translation.width + gap)/2
                    print("mygod \(self.currentPosition.width)")
                }
                
                withAnimation() {
                    if Int(self.currentAngle)%180 == 0 {
                        self.shadow = 4*(self.flipped ? -1 : 1)
                    } else {
                        self.shadow = 0
                    }
                    
                }
                
        }
        .onEnded { value in
            let q = Int(self.currentAngle).quotientAndRemainder(dividingBy: 90).0
            print("hehe \(q)")
            var resetAngle: Double = 0
            if abs(q) == 0 || abs(q) % 2 == 0 {
                if self.flipped && self.currentAngle > 0{
                    resetAngle = Double(180)
                }
                else if (self.flipped && self.currentAngle < 0) {
                    resetAngle = Double(-180)
                    
                } else {
                    resetAngle = 0
                }
            }
            else {
                if !self.flipped {
                    resetAngle = Double(180*(q/abs(q)))
                    self.flipped = true
                } else {
                    resetAngle = Double(360*q/abs(q))
                    self.flipped = false
                }
            }
            
            withAnimation() {
                self.currentAngle = resetAngle
                
                self.currentPosition.width = 0
                self.newPosition.width = 0
            }
            
            self.newPosition = self.currentPosition
            
            
            withAnimation() {
                if Int(self.currentAngle)%180 == 0 {
                    self.shadow = 4*(self.flipped ? -1 : 1)
                } else {
                    self.shadow = 0
                }
                
            }
            
        }
    }
    
    let bgColor: Color = Color("tree")
    
    let versoView: () -> AnyView
    let rectoView: () -> Content
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 130)
                Text("\(currentAngle)").padding()
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 100/100, height: UIScreen.main.bounds.height * 120/100)
            .background(bgColor)
            .edgesIgnoringSafeArea(.all)
            
            ZStack {
                versoView()
                    
                    .background(bgColor.opacity(0.3))
                    .background(Color("cardBackground"))
                    
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                    .zIndex(self.recto ? 0 : 1)
                
                VStack {
                    Spacer()
                }.frame(width: 700,height: 700)
                    .background(Color.gray)
                    
                    .zIndex((89.7...90.3).contains(abs(currentAngle)) || (269.7...270.3).contains(abs(currentAngle)) ? 2 : 0)
                
                rectoView()
                    .background(Color("cardBackground"))
            }
            .frame(width: UIScreen.main.bounds.width * 85/100, height: UIScreen.main.bounds.height * 75/100)
            .cornerRadius(70)
            .shadow(color: Color.black.opacity(0.4), radius: abs(shadow), x: shadow, y:  abs(shadow))
            .rotation3DEffect(Angle(degrees: currentAngleMod) , axis: (x: 0, y: 1, z: 0), anchor: .center)
            .offset(x: currentPosition.width, y: currentPosition.height)
            .gesture(drag)
            .zIndex(1)
            
            VStack {
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width * 85/100, height: UIScreen.main.bounds.height * 75/100)
            .background(Color.gray)
                
            .cornerRadius(70)
            .rotation3DEffect(Angle(degrees: currentAngleMod) , axis: (x: 0, y: 1, z: 0), anchor: .center)
            .offset(x: Int(currentAngle)%180 == 0 ? currentPosition.width : (left ? currentPosition.width+2 : currentPosition.width-2), y:  currentPosition.height)
            .zIndex(0)
            
            //            VStack {
            //                Spacer()
            //            }
            //            .frame(width: UIScreen.main.bounds.width * 85/100, height: UIScreen.main.bounds.height * 75/100)
            //            .background(Color.red)
            //
            //            .cornerRadius(70)
            //                .rotation3DEffect(Angle(degrees: currentAngleMod) , axis: (x: 0, y: 1, z: 0), anchor: .center)
            //            .offset(x: recto ? currentPosition.width+2 : currentPosition.width+2, y:  currentPosition.height)
            //            .zIndex(0)
            
        }
    }
}

struct CardRecto: View {
    var body: some View {
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
    }
}

struct CardVerso: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Image("photoChene")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height * 85/100 / 2)
                    Spacer()
                }
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
                    Spacer()
                }
                
            }
            
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
            HStack {
                Text("Le chêne est un bel ardre que l'on aime bien dans nos régions. Le chêne est un bel ardre que l'on aime bien dans nos régions. Le chêne est un bel ardre que l'on aime bien dans nos régions. Le chêne est un bel ardre que l'on aime bien dans nos régions. ")
            }
            .frame(width: 270)
            
            Spacer().frame(height: 50)
        }
    }
}

struct CardTest3_Previews: PreviewProvider {
    static var previews: some View {
        CardTest3(versoView: {
            AnyView(CardVerso())
        }, rectoView: {
            CardRecto()
            
        })
    }
    
}
