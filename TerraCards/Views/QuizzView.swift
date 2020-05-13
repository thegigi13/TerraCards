//
//  QuizzView.swift
//  TerraCards
//
//  Created by annecrepin on 12/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

struct QuizzView: View {
    
//    Récupération d'une carte au hasard dans celles possédées
//    var cardQuestion = cardList.randomElement()!
    
//    Récupération de la catégorie de cette carte
//    var cardCategorie = cardQuestion.catégorie
    
//    Puis de la photo arrière
//    var cardPhoto = cardQuestion.photo
    var cardPhoto = "mesange"

//    Enfin de son nom
//    var goodAnswer = cardQuestion.name
    var goodAnswer = "Mésange Bleue"
    
//    Récupération de cartes au hasard dans la catégorie de la carte pioché ...
    var wrongAnswer1 = "Pie"
    var wrongAnswer2 = "Moineau"
    var wrongAnswer3 = "Pigeon"
    
//    tableau des 4 réponses possibles a la question
    var answerList: [String] = [ "Pie","Pigeon", "Moineau", "Mésange Bleue"]

    

    @State var win:Bool = false
    
//    Vue vers le menu ?
    @State var menuView = false
//    Vue vers les résultats ?
    @State var validAnswerView = false



    var body: some View {

        VStack{

            HStack{

//                NavigationLink(destination: menuView(), isActive: $menuView ){
//                    EmptyView()
//                }
                
                // Bouton quitter ?
                Button(
                    action: {

                        if self.win == true {
                        }else{
                            
                        }

                        self.menuView = true
                    },
                    label: {

                        Text("Retour")
                    }
                )
                Spacer()


            }
            .padding()

            Image(cardPhoto)
                .resizable()
                .frame(width:250, height: 200)
            
            Spacer()

            Text("Comment s'appelle-t-il ?")
                .font(.system(Font.TextStyle.title))
                .bold()


            Spacer()

            //Reponses List
            ForEach(answerList.shuffled(), id: \.self) { answer in


                ButtonStyle(
                    action: {},
                    text: answer
                )

            }

            Spacer()

//            NavigationLink(destination: validAnswerView(), isActive: $validAnswerView ){
//                EmptyView()
//            }

//            // Next Button
            Button(
                action: {

                    if self.win == true {
                        
                    }else{
                        
                    }

            },
                label: {

                    Text("Valider")
                        .bold()
                        .foregroundColor(Color.white)
            }
            )

                .frame(width:150,height:50)
                .background(Color.blue)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)

        }
//            .navigationBarTitle("Quizz")


    }
}

struct ButtonStyle: View {
    var action: ()-> Void
    var text: String
    
    var body: some View {
        
        Button(
            action: action,
            label: {
                
                Text(self.text)
                    .bold()
                    .foregroundColor(Color.white)
        }
        )
            .frame(width:300,height:50)
            .background(Color.blue)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .cornerRadius(20)
            .padding(10)
        
    }
}


struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
    }
}
