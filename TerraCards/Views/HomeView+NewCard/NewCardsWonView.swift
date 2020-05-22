//
//  NewCardsWonView.swift
//  TerraCards
//
//  Created by Joséphine Delobel on 20/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct NewCardsWonView: View {
    var body: some View {
        VStack{
            
          // Prendre 2 cartes au hasard dans la liste des cartes non obtenues
            // utiliser un autre modele de carte? (ici c'est les cartes de collections)
            LittleCardView(titreCollection: "Amphibiens", imageCollection : "grenouille2", couleurCard: "amphibian")
            LittleCardView(titreCollection: "Amphibiens", imageCollection : "grenouille2", couleurCard: "amphibian")
            
        }.navigationBarTitle("Nouvelles cartes")
    }
}

struct NewCardsWonView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardsWonView()
    }
}
