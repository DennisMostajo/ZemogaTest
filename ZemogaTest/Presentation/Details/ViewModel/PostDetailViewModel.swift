//
//  PostDetailViewModel.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import RealmSwift

/// Abstraction class from `Post`detail  view to handle business logic.
class PostDetailViewModel {
    /// Array of `CommentViewModel` items.
    var commentViewModels = [CommentViewModel]()
    /// A list as `Results<Comment>`  with all required items.
    var comments: Results<Comment>? = nil
    /// Dictionary to handle `PostViewModel`and `UserViewModel`.
    var otherViewModels = [String: Any]()
    
    /// Method to load all required data from database.
    func loadLocal(post:Post) {
        self.comments = nil
        self.commentViewModels = []
        self.comments = RealmHelper.getCommentsByPostId(postId: post.id)
        if let comments = self.comments {
            for comment in comments {
                let viewModel = CommentViewModel(comment: comment)
                self.commentViewModels.append(viewModel)
            }
        }
        self.otherViewModels.updateValue(PostViewModel(post: post), forKey: "postViewModel")
        if let user = RealmHelper.getUserById(userId: post.userId) {
            self.otherViewModels.updateValue(UserViewModel(user: user), forKey: "userViewModel")
        }
    }
    
    /// Method to load  all detail data from `JSONPlaceholder API`.
    func loadFromNetwork(post:Post, completion:@escaping () -> Void) {
        _ = NetworkManager.shared.request(API.getUserWithId(userId: post.userId), success: {responseRequest,responseData in
            if let user = try? JSONDecoder().decode(User.self, from: responseData as! Data) {
                RealmHelper.createOrUpdateUser(user)
            }
            _ = NetworkManager.shared.request(API.getCommentsFromPostWithId(postId: post.id), success: {responseRequest,responseData in
                if let comments = try? JSONDecoder().decode([Comment].self, from: responseData as! Data) {
                    for comment in comments {
                        RealmHelper.createOrUpdateComment(comment)
                    }
                }
                self.loadLocal(post: post)
                completion()
            }, failure: {_,_, error in
                debugPrint("getComments error:\(error)")
                completion()
            })
            
        }, failure: {_,_, error in
            debugPrint("getUser error:\(error)")
            completion()})
    }
}

