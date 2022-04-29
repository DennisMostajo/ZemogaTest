//
//  User.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import RealmSwift

/// This class contains the attributes from the `User` or person who uses the App to interact with the abstracts models
class User: Object, Codable {
            /// id:     The `primaryKey` value.
    @objc dynamic var id: Int = 0
            /// name:     The `name` from `User`.
    @objc dynamic var name: String? = ""
            /// username:     The `username` from `User`.
    @objc dynamic var username: String? = ""
            /// email:     The `email` from `User`.
    @objc dynamic var email: String? = ""
            /// phone:     The `phone`  provided by `User`.
    @objc dynamic var phone: String? = ""
            /// website:     The `website` provided by `User`.
    @objc dynamic var website: String? = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    /// `CodingKeys` defined by cases.
    ///
    /// - `Cases`:  `id`, `name`, `username`, `email`, `phone`, `website`.
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case website
    }
    
    /// `Init method` for decode values by keys.
    ///
    /// - `Keys`:  `id`, `name`, `username`, `email`, `phone`, `website`.
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
    }
}
