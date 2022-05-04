//
//  API.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import Alamofire

/// Custom Enumeration used for call the `endpoints` provided by `JSON placeholder API`
///
/// Adopting the `URLRequestConvertible` protocol to use safely construct `URL Request`
enum API: URLRequestConvertible {
    /// Base URL of the request.
    static let baseURLString = "https://jsonplaceholder.typicode.com"
    /// Case `endpoint` for get `Posts`.
    case getPosts
    /// Case `endpoint` for get `Comments` from `Post`.
    case getCommentsFromPostWithId(postId: Int)
    /// Case `endpoint` for get `User` by `id`.
    case getUserWithId(userId: Int)
    
    /// Defined `HTTP method` for each `endpoint`.
    var method: Alamofire.HTTPMethod {
        switch self {
            case .getPosts:
                return .get
            case .getCommentsFromPostWithId:
                return .get
            case .getUserWithId:
                return .get
        }
    }
    
    /// Defined `path` for each `endpoint`.
    var path:String {
        switch self {
            case .getPosts:
                return "posts"
            case .getCommentsFromPostWithId:
                return "comments"
            case .getUserWithId(let userId):
                return "users/\(userId)"
        }
    }
    
    /// Method to build the `request` with the properties defined by the developer, including `base url` and `HTTP method`.
    /// - Returns: A `URLRequest` object with the request properties defined.
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: API.baseURLString)!
        var request = URLRequest(url:URL.appendingPathComponent(path))
        debugPrint("URL request:\(URL.appendingPathComponent(path))")
        request.httpMethod = method.rawValue
        var parameters:[String: AnyObject] = [:]
        switch self {
            case .getPosts:
                break
            case .getCommentsFromPostWithId(let postId):
                parameters["postId"] = postId as AnyObject
            case .getUserWithId:
                break
        }
        debugPrint(parameters)
        request = try! URLEncoding().encode(request, with: parameters)
        dump(request)
        return request
    }
}
