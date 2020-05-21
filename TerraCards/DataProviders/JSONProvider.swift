//
//  JSONObjects.swift
//  TerraCards
//
//  Created by foxy on 21/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation

struct ImageJson: Codable {
    let url: String
}

class CardList: Decodable {
    let records: [CardRecord]
}

class CardRecord: Decodable {
    let id: String
    let fields: Card
}

enum JSONError: Error {
    case decodingError(error: Error)
    case unknown
}
struct JSONProvider {
    
    typealias Completion = (Result<CardList,JSONError>) -> ()
    
    static func decodeToCardList(from data: Data, completion: @escaping Completion){
        var result: CardList
        let decoder = JSONDecoder()
        
        do {
            try result = decoder.decode(CardList.self, from: data)
            
            var cards: [Card] = []
            for record in result.records {
                cards.append(record.fields)
            }
            DispatchQueue.main.async {
                completion(.success(result))
            }
        } catch {
            print("erreur lors du décodage du JSON")
            completion(.failure(.decodingError(error: error)))
        }
        

    }
}
