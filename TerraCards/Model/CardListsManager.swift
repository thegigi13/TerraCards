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
            case let .failure(error) :
                completion(.failure(error))
            default :
                completion(.failure(.unknown))
                print("on voulait une cardlist et on a autre chose")
            }
        }
    }
}
