//
//  Comment.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import RealmSwift

/// This class contains the attributes from the `Comment` provided as an example by `JSON placeholder`.
class Comment: Object, Codable {
        /// id:     The `primaryKey` value.
    @objc dynamic var id: Int = 0
        /// postId:     The `Key` value from `Post`.
    @objc dynamic var postId: Int = 0
        /// body:     The `content` as a description from the `Comment`.
    @objc dynamic var body: String = ""
        /// name:     The `name` from `User` that commented the `Post`.
    @objc dynamic var name: String = ""
        /// email:     The `email` from `User` that commented the `Post`.
    @objc dynamic var email: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    /// `CodingKeys` defined by cases.
    ///
    /// - `Cases`:  `id`, `postId`, `body`, `name`, `email`.
    private enum CodingKeys: String, CodingKey {
        case id
        case postId
        case body
        case name
        case email
    }
    
    /// `Init method` for decode values by keys.
    ///
    /// - `Keys`:  `id`, `postId`, `body`, `name`, `email`.
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.postId = try container.decode(Int.self, forKey: .postId)
        self.body = try container.decode(String.self, forKey: .body)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
