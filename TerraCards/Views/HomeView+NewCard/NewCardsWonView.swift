//
//  NewCardsWonView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 20/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct NewCardsWonView: View {
    @EnvironmentObject var cardsModelView: CardsLists
    @State var randomCards: [Card] = []
    var bgColor: Color
    var body: some View {
        VStack{
            CollectionView(cardList: randomCards, bgColor: bgColor)
        }
    .onAppear(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.randomCards = self.cardsModelView.threeNewCardsOrLess()
            print("cartes hasard à afficher : \(self.randomCards)")
            self.cardsModelView.winCards(cards: self.randomCards)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            UserSettings.lastFreeWins = formatter.string(from: Date())
            
            print("gagné le \(UserSettings.lastFreeWins)")
            print (self.cardsModelView.possibleToWinMoreForFree ? "il est possible de gagner + aujourd'hui" : "il n'est PAS possible de gagner + aujourd'hui")
        })
    }
    }
}

struct NewCardsWonView_Previews: PreviewProvider {
    static var previews: some View {
        let env = CardsLists()
        return NewCardsWonView(bgColor: Color.yellow)
            .environmentObject(env)
            .onAppear(){
                env.fillLists(){response in
                    switch response {
                    case .success:
                        // ici ce sont les cartes qui étaient déjà dans les UserSettings
                        UserSettings.userCards = []
                        UserSettings.lastFreeWins = "2001-01-01"
                        print (env.possibleToWinMoreForFree ? "il est possible de gagner + aujourd'hui" : "il n'est PAS possible de gagner + aujourd'hui")
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
