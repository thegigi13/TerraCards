//
//  CardListsManager.swift
//  TerraCards
//
//  Created by foxy on 21/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI

extension CardsLists {
    func winCards(cards: [Card]) {
        for wonCard in cards {
            if self.wonCards.isEmpty || self.wonCards.first(where: {$0.name == wonCard.name}) == nil {
                self.wonCards.append(wonCard)
                UserSettings.userCards.append(wonCard.name)
            }
        }
    }
    
    func threeNewCardsOrLess() -> [Card]{
        let missCards = missingCards
        var result: [Card] = []
        var nbCardsInResult = 3
        if missingCards.count < 3 {
            nbCardsInResult = missingCards.count
        }
        for _ in 0..<nbCardsInResult {
            if var random = missCards.randomElement() {
                while
                    result.firstIndex(where: {$0.name == random.name}) != nil{
                        random = missCards.randomElement()!
                }
                result.append(random)
            }
            
        }
        print("au hasard : \(result)")
        return result
    }
}
extension CardsLists {
    typealias Completion = (Result<CardsLists,APIError>) -> ()
    
    func fillLists(completion: @escaping Completion) {
        print("youhou")

        fetchAllCards {responseFetch in
            switch responseFetch {
            case .success:
                self.fillWonCardsList()
                completion(.success(self))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllCards(completion: @escaping APIProvider.Completion) {
        APIProvider.shared.requestAllRecords(){response in
            switch response {
                case let .success(.data(data)):
                    self.fillAllCardsList(with: data) {response in
                        switch response {
                        case .failure: completion(.failure(.dataCantBeDecoded))
                        case let .success(cardList): completion(.success(.cardList(cardList: cardList)))
                    }
                }
                case let .failure(error):
                    completion(.failure(error))
                default:
                    completion(.failure(.unknown))
                    print("on voulait de la data, on a autre chose")
            }
        }
    }

    
    private func fillAllCardsList(with data: Data, completion: @escaping JSONProvider.Completion) {
        JSONProvider.decodeToCardList(from : data) {response in
            switch response {
            case let .success(cardList):
                self.allCards = []
                for cardRecord in cardList.records {
                    self.allCards.append(cardRecord.fields)
                }
                completion(.success(cardList))
            case let .failure(.decodingError(error: error)) :
                completion(.failure(.decodingError(error: error)))
            default :
                completion(.failure(.unknown))
                print("on voulait une cardList et on a autre chose")
            }
        }
    }
    
    private func fillWonCardsList() {
        var result: [Card] = []
        
        for cardName in UserSettings.userCards {
            let wonCard = allCards.first(where: {
                    $0.name == cardName
            })
            if let wonCard = wonCard {
                result.append(wonCard)
            }
        }
        print("Voici les cartes déjà obtenues par le joueur :")
        for re in result {
            print(re.name ?? "")
        }
        self.wonCards = result
    }
}
