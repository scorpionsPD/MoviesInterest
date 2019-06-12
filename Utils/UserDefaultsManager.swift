//
//  UserDefaultsManager.swift
//  
//
//  Created by Pradeep Dahiya on 21.02.18.
//  Copyright © 2018 Pradeep Dahiya. All rights reserved.
//

import Foundation

enum UserDefaultsManager {
    static func getUsername() -> String? {
        return UserDefaults.standard
            .string(forKey: Constants.UserDefaults.usernameKey)
    }

    static func setUsername(_ username: String) {
        UserDefaults.standard
            .set(username, forKey: Constants.UserDefaults.usernameKey)
    }
}
