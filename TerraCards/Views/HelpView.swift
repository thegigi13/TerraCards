//
//  Help.swift
//  TerraCards
//
//  Created by MacBookGP on 13/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct Help: View {
    
    @EnvironmentObject var cardsModelView: CardsLists
    
    @State var offset = [CGSize(width: 0, height: 0),CGSize(width: 0, height: 0),CGSize(width: 0, height: 0)]
    
    @State var sheet = 0
    @State var endFlip = false
    @State var opacity = 0.1
    
    var card: Card? {
        return cardsModelView.allCards.first {
            $0.name == "Mésange bleue"
        }
    }
    var body: some View {
        let drag = DragGesture()
            .onChanged({value in
                if  value.translation.width < 0 {
                    self.offset[self.sheet].width = value.translation.width
                }
            })
            .onEnded({value in
                withAnimation(.linear(duration: 0.5)) {
                    if self.offset[self.sheet].width < -100 {
                        
                        self.offset[self.sheet].width = -1 * UIScreen.main.bounds.width
                    } else {
                        self.offset[self.sheet].width = 0
                    }
                }
                
                if self.offset[self.sheet].width < -100 {
                    self.sheet += 1
                    withAnimation(.linear(duration: 0.5)) {
                        //self.showed[self.sheet].toggle()
                    }
                }
                
            })
        
        
        return
            ZStack {
                VStack {
                    Text("")
                }
                .onAppear() {
                    withAnimation(.linear(duration: 0.5)) {
                        //self.showed2.toggle()
                    }
                }
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*120/100)
                .background(Color(UIColor.systemGreen))
                .offset(x: self.offset[2].width, y: 0)                .gesture(drag)
                .disabled(self.sheet != 2)
                
                
                VStack {
                    Spacer().frame(height:200)
                    if card != nil {
                        CardFlip(flip: $endFlip, versoView: {
                            AnyView(CardVerso(card: self.card!))
                        }, rectoView: {
                            CardRecto(card: self.card!)
                        })
                            .scaleEffect(0.6)
                            .padding(.bottom, -50)
                            .disabled(endFlip)
                    }
                    
                    Text("Tu vas collectionner des cartes qui te permettront d'avoir des informations sur des animaux et des plantes des environs")
                        .padding(.horizontal, 40)
                    Text("Retourne cette carte pour voir !")
                        .padding()
                    //if showed[1] {
                    
                    if endFlip {
                        HStack {
                            AnimatedChevron()
                            Text("Glisse pour continuer")
                                .foregroundColor(Color.white)
                            
                            
                        }
                        .opacity(opacity)
                        .onAppear() {
                            withAnimation(.linear(duration: 1)) {
                                self.opacity = 1
                            }
                        }
                        
                    }
                    
                    //}
                    
                    Spacer()
                }
                    
                    
                .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*120/100)
                .background(Color(UIColor.systemBlue))
                .offset(x: self.offset[1].width, y: 0)                .gesture(drag)
                .disabled(self.sheet != 1)
                
                
                ThreeVerticalView(delays: [2.5,5,0],
                                  firstView: {
                                    ThreeWords(sentence: "Bienvenue dans TerraCards")
                                        .font(.title)
                }, secondView: {
                    HStack {
                        //if self.showed[0] {
                        Text("Avec TerraCards tu vas apprendre beaucoup de choses sur la faune et la flore qui t'entoure. Que tu habites à la campagne, au bord de la mer, ou même en ville")
                            
                            .padding(40)
                            .transition(.move(edge: .bottom))
                        
                    }
                }, thirdView: {
                    ThreeWords(sentence : "Glisse pour continuer")
                    
                    //.foregroundColor(Color.white)
                    
                })
                    
                    .frame(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*120/100)
                    .background(Color(UIColor.systemRed))
                    .offset(x: self.offset[0].width, y: 0)
                    .gesture(drag)
                    .disabled(self.sheet != 0)
                
                
            }.edgesIgnoringSafeArea(.all)
        
        
    }
}


struct ThreeWords: View {
    
    var words: [String]
    @State var opacities: [Double]
    init(sentence: String) {
        self.words = sentence.map { String($0) }
        self._opacities = State(initialValue: Array(repeating: 0.0, count: self.words.count))
    }
    
    init(arrayOfWords: [String]) {
        self.words = arrayOfWords
        self._opacities = State(initialValue: Array(repeating: 0.0, count: self.words.count))
    }
    
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach (0..<words.count) {i in
                    Text(self.words[i])
                        .padding(0)
                        .opacity(self.opacities[i])
                }
            }.onAppear() {
                for i in 0..<self.opacities.count {
                    withAnimation(Animation.linear(duration: 0.5).delay(Double(i)*0.05)) {
                        self.opacities[i] = 1
                        
                    }
                }
                
            }
        }
    }
}

struct AnimatedChevron: View {
    @State var chevronX: CGFloat = 0
    @State var opacityChevron: Double = 1
    
    var body: some View {
        Image(systemName: "chevron.left")
            .offset(x: self.chevronX, y: 0)
            .foregroundColor(Color.white)
            .opacity(self.opacityChevron)
            .onAppear() {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                    self.chevronX = -100
                }
                withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                    self.opacityChevron = 0
                    
                }
        }
    }
}

struct ThreeVerticalView<FirstView: View, SecondView: View, ThirdView: View>: View {
    var delays: [Double]
    
    var firstView: () -> FirstView
    var secondView: () -> SecondView
    var thirdView: () -> ThirdView
    @State var show = false
    @State var opacities: [Double] = [0, 0, 0]
    @State var showed = false
    var body: some View {
        VStack {
            firstView().opacity(self.opacities[0])
            
            secondView().opacity(self.opacities[1])
            if self.showed {
                HStack {
                    AnimatedChevron()
                    thirdView()
                        .foregroundColor(Color.white)
                    
                    
                }
            }
            else {
                HStack {
                    AnimatedChevron()
                    thirdView()
                        .foregroundColor(Color.white)
                    
                    
                }.hidden()
            }
            
            
            
            
            
            
        }.onAppear() {
            for i in 0..<self.opacities.count {
                withAnimation(
                    Animation.linear(duration: 1)
                        .delay(i == 0 ? 0 : self.delays[i-1]))
                {
                    self.opacities[i] = 1
                }
            }
            
        }
        .onAppear() {
            withAnimation(Animation.linear.delay(self.delays[1])) {
                self.showed.toggle()
            }
        }
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        let env = CardsLists()
        return Help()
            .environmentObject(env)
            .onAppear(){
                env.fillLists(){response in
                    switch response {
                    case .success:
                        // ici ce sont les cartes qui étaient déjà dans les UserSettings
                        for card in env.wonCards {
                            print("carte de départ en preview : \(card.name ?? "")")
                        }
                        
                        
                        //                carte de départ en preview : Optional("Chêne")
                        //                carte de départ en preview : Optional("Dauphin")
                        //                carte de départ en preview : Optional("Ortie")
                        //                carte de départ en preview : Optional("Pavot cornu")
                        //                carte de départ en preview : Optional("Jacinthe des bois")
                        
                        // on en gagne quelques autres pour le fun, attention si le nom est pas le même exactement que dans la base : crash
                        var cardsToAdd: [Card] = []
                        cardsToAdd.append(env.allCards.first(where: {$0.name == "Mésange bleue"})!)
                        cardsToAdd.append(env.allCards.first(where: {$0.name == "Vipère aspic"})!)
                        env.winCards(cards: cardsToAdd)
                        
                    case .failure :
                        print("mince")
                    }
                }
                
        }
        
    }
}
