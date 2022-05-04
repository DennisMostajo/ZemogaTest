//
//  RealmHelper.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import RealmSwift

/// A `Realm` Database manager
///
/// Implemented to handle methods such as `create or update`, `get`, `update specific values` and `delete`
class RealmHelper {
    
    /// Change the value of `DB_VERSION` every time a change is made to the `REALM database`.
    static let DB_VERSION: UInt64 = 1
    
    //MARK: Create Methods
    
    /// Method to create and/or update the `User` object.
    ///
    /// - Parameters:
    ///   - user:     The `User` object.
    class func createOrUpdateUser(_ user: User) {
        do {
            let realm = try Realm()
            realm.refresh()
            try realm.write {
                realm.add(user, update: .all)
                debugPrint("User added or updated: \(user.id)")
            }
            
        } catch {
            debugPrint("Error creating or updating User")
        }
    }
    
    /// Method to create and/or update the `Post` object.
    ///
    /// - Parameters:
    ///   - post:     The `Post` object.
    class func createOrUpdatePost(_ post: Post) {
        do {
            let realm = try Realm()
            realm.refresh()
            try realm.write {
                realm.add(post, update: .all)
                debugPrint("Post added or updated: \(post.id)")
            }
            
        } catch {
            debugPrint("Error creating or updating Post")
        }
    }
    
    /// Method to create and/or update the `Comment` object.
    ///
    /// - Parameters:
    ///   - comment:     The `Comment` object.
    class func createOrUpdateComment(_ comment: Comment) {
        do {
            let realm = try Realm()
            realm.refresh()
            try realm.write {
                realm.add(comment, update: .all)
                debugPrint("Comment added or updated: \(comment.id)")
            }
            
        } catch {
            debugPrint("Error creating or updating Comment")
        }
    }
    
    //MARK: Update Methods
    
    /// Method to update the `isFavorite` value from `Post` object.
    ///
    /// - Parameters:
    ///   - postId:   The `id` as primary key from `Post`object.
    ///   - value:    The bool `value` to set.
    class func updateIsFavoritePost(postId: Int, value: Bool) {
        if let post = self.getPostById(postId: postId) {
            do {
                let realm = try Realm()
                realm.refresh()
                try realm.write {
                    post.isFavorite = value
                    realm.add(post, update: .modified)
                }
                debugPrint("post:\(post.id) isFavorite:\(post.isFavorite)")
            }
            catch {
                debugPrint("can't update Post Value")
            }
        }
    }
    
    //MARK: Get Methods
    
    /// Method to get all `Post` objects.
    ///
    /// - Returns: A list as `Results<Post>`  with all required items.
    class func getPosts() -> Results<Post>? {
        do {
            let realm = try Realm()
            let sortProperties = [SortDescriptor(keyPath: "isFavorite", ascending: false), SortDescriptor(keyPath: "id", ascending: true)]
            return realm.objects(Post.self).sorted(by:sortProperties)
        } catch {
            debugPrint("Error getting posts from database")
            return nil
        }
    }
    
    /// Method to get the all  favorites `Post` objects.
    ///
    /// - Returns: A list as `Results<Post>`  with all required items.
    class func getFavorites() -> Results<Post>? {
        do {
            let realm = try Realm()
            return realm.objects(Post.self).filter("isFavorite == true").sorted(byKeyPath: "id", ascending: true)
        } catch {
            debugPrint("Error getting comments from database")
            return nil
        }
    }
    
    /// Method to get the `Post` object.
    ///
    /// - Parameters:
    ///   - postId: The `id` as primary key from `Post` object.
    /// - Returns: The `Post` object required.
    class func getPostById(postId:Int) -> Post? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Post.self, forPrimaryKey: postId)
        } catch {
            debugPrint("Error getting post from database")
            return nil
        }
    }
    
    /// Method to get the `User` object.
    ///
    /// - Parameters:
    ///   - userId: The `id` as primary key from `User` object.
    /// - Returns: The `User` object required.
    class func getUserById(userId:Int) -> User? {
        do {
            let realm = try Realm()
            return realm.object(ofType: User.self, forPrimaryKey: userId)
        } catch {
            debugPrint("Error getting user from database")
            return nil
        }
    }
    
    /// Method to get the all `Comment` objects by `postId`.
    ///
    /// - Parameters:
    ///   - postId: The `id` as primary key from `Post` object.
    /// - Returns: A list as `Results<Comment>`  with all required items.
    class func getCommentsByPostId(postId:Int) -> Results<Comment>? {
        do {
            let realm = try Realm()
            return realm.objects(Comment.self).filter("postId == %i", postId).sorted(byKeyPath: "id", ascending: true)
        } catch {
            debugPrint("Error getting comments from database")
            return nil
        }
    }
    
    //MARK: Delete Methods
    
    /// Method to delete all `Post` objects from the `database`.
    class func deletePosts() {
        do {
            let realm = try Realm()
            let requestToDelete = realm.objects(Post.self)
            realm.refresh()
            try realm.write {
                realm.delete(requestToDelete)
                debugPrint("Posts deleted")
            }
        } catch {}
    }
    
    /// Method to delete the `Post` object by `postId`.
    /// - Parameters:
    ///   - postId: The `id` as primary key from `Post` object.
    class func deletePostById(_ postId: Int) {
        if let post = self.getPostById(postId: postId) {
            do {
                let realm = try Realm()
                realm.refresh()
                try realm.write {
                    realm.delete(post)
                }
                debugPrint("post deleted")
            }
            catch {
                debugPrint("can't deleted post")
            }
        }
    }
    
    /// Method to delete the `Comment` objects by `postId`.
    /// - Parameters:
    ///   - postId: The `id` as primary key from `Post` object.
    class func deleteCommentsByPostId(_ postId: Int) {
        do {
            let realm = try Realm()
            let comments = realm.objects(Comment.self).filter("postId = %i",postId)
            realm.refresh()
            try realm.write {
                realm.delete(comments)
            }
            debugPrint("comments deleted")
        }
        catch {
            debugPrint("can't deleted comments")
        }
    }
    
    /// Method to delete the `User` object by `postId`.
    /// - Parameters:
    ///   - id: The `id` as primary key from `Post` object.
    class func deleteUserByPostId(_ id: Int) {
        do {
            let realm = try Realm()
            let user = realm.object(ofType: User.self, forPrimaryKey: id)
            realm.refresh()
            try realm.write {
                realm.delete(user!)
            }
            debugPrint("user deleted")
        }
        catch {
            debugPrint("can't deleted user")
        }
    }
    
    //MARK: Migrations
    
    /// Method to update the whole schema of `Realm database`.
    class func DBUpdate() {
        /**
         Define a migration block.

         You can define this inline, but we will reuse this to migrate realm files from multiple versions to the most current version of our data model.

         ```
         //---------------------------------------------------------------------//
         //              THIS IS FOR ANY NEW CLASS OR COLUMN ADDED
         //---------------------------------------------------------------------//
         migration.enumerate("name class".className()) { oldObject, newObject in
             // No-op.
             // dynamic properties are defaulting the new column to true
             // but the migration block is still needed
         }
        ```
         */
         let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
          //-----------------------------------------------------------------------------------//
          //                                TO MIGRATION
          //-----------------------------------------------------------------------------------//
          // Change the value of DB_VERSION every time a change is made to the REALM database
          //-----------------------------------------------------------------------------------//
            }
            debugPrint("->oldSchemaVersion:\(oldSchemaVersion)")
            debugPrint("Migration complete.")
        }
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: DB_VERSION, migrationBlock: migrationBlock)
        _ = try! Realm()
        debugPrint("--->Path to realm file:\(String(describing: Realm.Configuration.defaultConfiguration.fileURL?.absoluteString))")
    }
}

/// `Results` is an auto-updating container type in Realm returned from object queries.
extension Results {
    /// Method to convert the `Results` in an `Array`
    /// - Parameters:
    ///   - T.Type: as realm model object.
    /// - Returns: an array of required realm objects.
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
