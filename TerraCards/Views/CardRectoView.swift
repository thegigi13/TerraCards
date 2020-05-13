//
//  CardRectoView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

class PositionController: ObservableObject {
    @Published var currentPosition: CGSize = .zero
    @Published var currentAngle: Double = .zero

    @Published var newPosition: CGSize = .zero
    
    @Published var totalWidthDrag: CGFloat = .zero {
        didSet {
            print("blabla2 \(totalWidthDrag)")

            switch totalWidthDrag {
            case 30 ..< 210:
                currentPosition.width = 30
                currentAngle = Double(totalWidthDrag - 30)
                
            case 210 ..< 270:
                currentPosition.width = 30 - (totalWidthDrag - 210)

                currentAngle = 180
            case 270 ..< 450:
                currentPosition.width = -30
                currentAngle = Double(totalWidthDrag - 90)
            case 450 ..< 510:
                currentPosition.width = -30 + (totalWidthDrag - 450)

                currentAngle = 0
            case 510 ..< .infinity:
                currentPosition.width = 30
                currentAngle = Double(totalWidthDrag - 510)
                
            
                
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

struct CardRectoView: View {
    @ObservedObject var positionController = PositionController()
    
    
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.positionController.currentPosition.height =  self.positionController.newPosition.height + value.translation.height
                
                self.positionController.totalWidthDrag = value.translation.width + self.positionController.newTotalWidthDrag
            }
            .onEnded { value in
                self.positionController.newPosition = self.positionController.currentPosition
                
                
                
                
                switch  self.positionController.currentAngle {
                case (-1 * .infinity) ..< -45 : withAnimation() {
                        //self.positionController.totalWidthDrag = -240
                    }
                    
                    
                case 45 ..< .infinity : withAnimation() {
                        //self.positionController.totalWidthDrag = 240
                    }
                
                default :
                    print("pataplouf")
                    self.positionController.currentAngle = 0
                    self.positionController.totalWidthDrag = 0
                }
                
                self.positionController.newTotalWidthDrag = self.positionController.totalWidthDrag
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
                        Text("Angle : \(self.positionController.currentAngle)")
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
            .offset(x: positionController.currentPosition.width, y: positionController.currentPosition.height)
            .rotation3DEffect(Angle(degrees: positionController.currentAngle) , axis: (x: 0, y: 1, z: 0))
            .gesture(drag)
            
            

        }
    }
}

struct CardRectoView_Previews: PreviewProvider {
    static var previews: some View {
        CardRectoView()
    }
}
