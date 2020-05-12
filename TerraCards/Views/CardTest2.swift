//
//  CardRectoView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

class PositionController2: ObservableObject {
    @Published var currentPosition: CGSize = .zero
    @Published var currentAngle: Double = .zero

    @Published var newPosition: CGSize = .zero
    
    @Published var totalWidthDrag: CGFloat = .zero {
        didSet {
            print("blabla2 \(totalWidthDrag)")

            switch totalWidthDrag {
            case 30 ..< 210:
                currentPosition.width = 30 - 30*totalWidthDrag/210
                currentAngle = Double(totalWidthDrag - 30)
                
            case 210 ..< 240:
                currentPosition.width = 0 - (totalWidthDrag - 210)

                currentAngle = 180
            case 240 ..< 420:
                currentPosition.width = -30 + 30*totalWidthDrag/420
                currentAngle = Double(totalWidthDrag - 60)
            case 420 ..< 450:
                currentPosition.width = 0 + (totalWidthDrag - 420)

                currentAngle = 0
            case 450 ..< .infinity:
                currentPosition.width = 0
                currentAngle = Double(totalWidthDrag - 450)
                
            
                
            case -210 ..< -30:
                currentPosition.width = -30
                currentAngle = Double(totalWidthDrag + 30)
            case -270 ..< -210:
                currentPosition.width = -30 - (totalWidthDrag + 210)
                currentAngle = -180
            case -450 ..< -270:
                currentPosition.width = 30
                currentAngle = Double(totalWidthDrag + 90)
            case -510 ..< -450:
                currentPosition.width = 30 - (450 + totalWidthDrag)

                currentAngle = 0
            case (-1 * .infinity) ..< -510:
                currentPosition.width = 30
                currentAngle = Double(totalWidthDrag + 510)
            default :
                print("blabla \(totalWidthDrag)")
                currentPosition.width = totalWidthDrag

            }
            
        }
    }
    
    @Published var newTotalWidthDrag: CGFloat = .zero
}

struct CardTest2: View {
    @ObservedObject var positionController = PositionController2()
    @State var currentPosition: CGSize = .zero {
        didSet {
           
        }
    }

    @State var currentAngle: Double = .zero {
        didSet {
            
        }
    }
    @State var flipped = false
    @State var newPosition: CGSize = .zero
    
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentPosition.height =  self.newPosition.height + value.translation.height
                self.currentPosition.width =  self.newPosition.width + value.translation.width
                self.currentAngle = Double(self.currentPosition.width/1.5)
                if self.flipped {
                    if self.currentAngle >= 0 {
                        self.currentAngle += 180
                    } else {
                        self.currentAngle -= 180
                    }
                }

            }
            .onEnded { value in
                let q = Int(self.currentPosition.width/1.5).quotientAndRemainder(dividingBy: 90).0
                print("hehe \(q)")
                var resetAngle: Double = 0
                if abs(q) == 0 || abs(q) > 1 {
                    if self.flipped && self.currentPosition.width/1.5 > 0{
                            resetAngle = Double(180)
                    }
                    else if (self.flipped && self.currentPosition.width/1.5 < 0) {
                            resetAngle = Double(-180)
                        
                    } else {
                        resetAngle = 0
                    }
                }
                if abs(q) == 1 {
                    if !self.flipped {
                        resetAngle = Double(180*q)
                        self.flipped = true
                    } else {
                        resetAngle = Double(360*q)
                        self.flipped = false
                    }
                }
                
                withAnimation() {
                    self.currentAngle = resetAngle
                    
                    self.currentPosition.width = 0
                    self.newPosition.width = 0
                }
                
                
//                switch self.currentPosition.width/1.5 {
//                case -90 ..< 90:
//
//
//
//                case -180 ..< -90 : withAnimation() {
//                    self.currentAngle = -180
//                    self.currentPosition.width = 0
//                    self.newPosition.width = 0
//                    self.flipped = true
//                }
//
//                case 90 ..< 180 : withAnimation() {
//                    self.currentAngle = 180
//                    self.currentPosition.width = 0
//                    self.newPosition.width = 0
//                    self.flipped = true
//                }
//
//                case 45 ..< .infinity : withAnimation() {
//                        //self.positionController.totalWidthDrag = 240
//                    }
//
//                default :
//                    print("pataplouf")
//                    self.currentAngle = 0
//
//                }
                self.newPosition = self.currentPosition

                
                
            }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("")
            }
            .frame(width: UIScreen.main.bounds.width * 100/100, height: UIScreen.main.bounds.height * 120/100)
            .background(Color("tree"))
            .edgesIgnoringSafeArea(.all)

            
            ZStack {
                VStack {
                    Text("haha")
                }
                .frame(width:200, height: 200)
                .background(Color.red)
                .zIndex(self.positionController.currentAngle < 90 || (self.positionController.currentAngle < 360 && self.positionController.currentAngle > 270) ? 0 : 1)
                
                VStack {
                    VStack {
                        Text("Angle : \(self.currentAngle)")
                        Text("TotalWidthDrag : \(self.positionController.totalWidthDrag)")
                    }
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
                
                
                
            }
            

            .frame(width: UIScreen.main.bounds.width * 85/100, height: UIScreen.main.bounds.height * 75/100)
            .cornerRadius(70)
            .shadow(color: Color.black.opacity(0.4), radius: 8, x: 4, y: 4)
            .rotation3DEffect(Angle(degrees: currentAngle) , axis: (x: 0, y: 1, z: 0), anchor: .center)
            .offset(x: currentPosition.width, y: currentPosition.height)
            
            .gesture(drag)
            
            

        }
    }
}

struct CardTest2_Previews: PreviewProvider {
    static var previews: some View {
        CardTest2()
    }
}
