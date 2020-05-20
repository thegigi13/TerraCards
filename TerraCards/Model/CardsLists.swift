//
//  CardsModelView.swift
//  TerraCards
//
//  Created by foxy on 07/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation
import SwiftUI

class CardsLists: ObservableObject {
    @Published var wonCards: [Card] = []
    @Published var missingCards: [Card] = []
    @Published var allCards: [Card] = []

    @Published var connection: Bool = true
}

class CardList: Decodable {
    let records: [CardRecord]
}

class CardRecord: Decodable {
    let id: String
    let fields: Card
}

extension CardsLists {
    func fillAllCardsList() throws {
        let url = URL(string: "https://api.airtable.com/v0/appPrjpqmbTjrOAI9/Card")!
       
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let params = ["api_key":"keyXSumLVSJRFmMRd"]
        components?.queryItems = params.map({URLQueryItem(name: $0, value: $1)})
        var request = URLRequest(url: (components?.url!)!)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.configuration.waitsForConnectivity = true
        URLSession.shared.configuration.timeoutIntervalForResource = 3600
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            var result: CardList?
            if error != nil {
                print(error.debugDescription)
            } else {
                print("hoho")
                let decoder = JSONDecoder()
                do {
                    try result = decoder.decode(CardList.self, from: data!)
                } catch {
                    print("hmmm")
                    print(error)
                }
                print(String(data: data!, encoding: .utf8)!)
                print(result?.records)
                if result != nil {
                    var cards: [Card] = []
                    for record in result!.records {
                        cards.append(record.fields)
                    }
                    DispatchQueue.main.async {
                        self.allCards = cards
                    }
                    
                }
                
            }
        }
        
        task.resume()
    }
}
