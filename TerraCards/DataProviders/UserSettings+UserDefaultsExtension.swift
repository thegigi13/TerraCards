//
//  UserDefaultsExtension.swift
//  TerraCards
//
//  Created by foxy on 21/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    enum Keys: String {
        case nbLaunches, userName, userCards
    }
    
}

struct UserSettings {
    @UserDefault(UserDefaults.Keys.nbLaunches.rawValue, defaultValue: 0) static var nbLaunches: Int
    @UserDefault(UserDefaults.Keys.userName.rawValue, defaultValue: "username") static var userName: String
    @UserDefault(UserDefaults.Keys.userCards.rawValue, defaultValue: []) static var userCards: [String]

}

