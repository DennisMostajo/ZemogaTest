//
//  CommentViewModel.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit

/// Abstraction class from `Comment` view exposing properties.
class CommentViewModel {
    /// id value from `Comment` object.
    var id: Int = 0
    /// postId value from `Comment` object.
    var postId: Int = 0
    /// body value from `Comment` object.
    var body: String = ""
    /// name value from `Comment` object.
    var name: String = ""
    /// email value from `Comment` object.
    var email: String = ""
    
    /// Creates an instance from `CommentViewModel`.
    ///
    /// - Parameters:
    ///   - comment: The `Comment` object.
    init(comment: Comment) {
        self.id = comment.id
        self.postId = comment.postId
        self.body = comment.body
        self.name = comment.name
        self.email = comment.email
    }
}

