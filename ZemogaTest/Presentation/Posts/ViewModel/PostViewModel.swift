//
//  PostViewModel.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/30/22.
//

/// Abstraction class from `Post` view exposing properties.
class PostViewModel {
    /// id value from `Post `object.
    var id = 0
    /// userId value from `Post `object.
    var userId = 0
    /// title value from `Post `object.
    var title = ""
    /// body value from `Post `object.
    var body = ""
    /// isFavorite value from `Post `object.
    var isFavorite = false
    
    /// Creates an instance from `PostViewModel`.
    ///
    /// - Parameters:
    ///   - post:     The `Post` object.
    init(post: Post) {
        self.id = post.id
        self.userId = post.userId
        self.title = post.title
        self.isFavorite = post.isFavorite
    }
    
    /// Method to delete the item.
    func delete() {
        RealmHelper.deletePostById(self.id)
    }
}