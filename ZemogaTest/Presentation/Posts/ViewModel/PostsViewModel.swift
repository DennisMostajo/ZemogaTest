//
//  PostsViewModel.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import RealmSwift

/// Abstraction class from `Posts` view to handle business logic.
class PostsViewModel {
    /// Array of `PostViewModel` items.
    var postViewModels = [PostViewModel]()
    /// A list as `Results<Post>`  with all required items.
    var posts: Results<Post>? = nil
    
    /// Method to load `Posts` from database with respective `PostViewModel`.
    func loadLocal() {
        self.posts = nil
        self.postViewModels = []
        self.posts = RealmHelper.getPosts()
        if let posts = self.posts
        {
            for post in posts {
                let viewModel = PostViewModel(post: post)
                self.postViewModels.append(viewModel)
            }
        }
    }
    
    /// Method to load favorites `Posts` from database with respective `PostViewModel`.
    func loadFavorites() {
        self.posts = nil
        self.postViewModels = []
        self.posts = RealmHelper.getFavorites()
        if let posts = self.posts
        {
            for post in posts {
                let viewModel = PostViewModel(post: post)
                self.postViewModels.append(viewModel)
            }
        }
    }
    
    /// Method to load  `Posts` from `JSONPlaceholder API`.
    func loadFromNetwork(completion:@escaping () -> Void) {
        _ = NetworkManager.request(API.getPosts, success: {responseRequest,responseData in
            if let posts = try? JSONDecoder().decode([Post].self, from: responseData as! Data) {
                for post in posts {
                    RealmHelper.createOrUpdatePost(post)
                }
                self.loadLocal()
                completion()
            }
        }, failure: {_,_, error in
            debugPrint("getPosts error:\(error)")
            completion()
        })
    }
    
    /// Method to delete all  `Posts`.
    func deleteAllPosts() {
        RealmHelper.deletePosts()
        self.loadLocal()
    }
}
