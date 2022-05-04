//
//  GetPosts.swift
//  ZemogaTestTests
//
//  Created by Dennis.Mostajo on 5/4/22.
//

import XCTest
@testable import Pods_ZemogaTestTests

class GetPosts: XCTestCase {
    
    func testGetPosts() {            
        _ = NetworkManager.shared.request(API.getPosts, success: {responseRequest,responseData in
            if let posts = try? JSONDecoder().decode([Post].self, from: responseData as! Data) {
                debugPrint("getPosts StatusCode:\(String(describing: responseRequest?.statusCode))")
                debugPrint("Posts:\(posts)")
                }
            }, failure: {_,_, error in
                debugPrint("getPosts error:\(error)")
            })
    }
}
