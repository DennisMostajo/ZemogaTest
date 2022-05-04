//
//  UserViewModel.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit

/// Abstraction class from `User` view exposing properties.
class UserViewModel {
    /// id value from `User` value.
    var id: Int = 0
    /// name value from `User` value.
    var name: String = ""
    /// username value from `User` value.
    var username: String = ""
    /// email value from `User` value.
    var email: String = ""
    /// phone value from `User` value.
    var phone: String = ""
    /// website value from `User` value.
    var website: String = ""
    
    /// Creates an instance from `UserViewModel`.
    ///
    /// - Parameters:
    ///   - user: The `User` object.
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.phone = user.phone
        self.website = user.website
    }
}
