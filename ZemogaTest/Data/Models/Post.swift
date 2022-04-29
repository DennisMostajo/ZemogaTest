//
//  Post.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import RealmSwift

/// This class contains the attributes from the `Post` provided as an example by `JSON placeholder`.
class Post: Object, Codable {
        /// id:     The `primaryKey` value.
    @objc dynamic var id: Int = 0
        /// userId:     The `Key` value from `User`.
    @objc dynamic var userId: Int = 0
        /// title:     The `title` as a main reference from the `Post`
    @objc dynamic var title: String? = ""
        /// body:     The `content` as a description from the `Post`
    @objc dynamic var body: String? = ""
        /// isFavorite:     The `boolean` value to check if  `User` has a preference about the `Post`
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    /// `CodingKeys` defined by cases.
    ///
    /// - `Cases`:  `id`, `userId`, `title`, `body`.
    private enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case body
    }
    
    /// `Init method` for decode values by keys.
    ///
    /// - `Keys`:  `id`, `userId`, `title`, `body`.
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
}
