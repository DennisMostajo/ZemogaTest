//
//  GetUser.swift
//  ZemogaTestTests
//
//  Created by Dennis.Mostajo on 5/4/22.
//

import XCTest

class GetUser: XCTestCase {
    
    func testGetUser() {
        _ = NetworkManager.shared.request(API.getUserWithId(userId: 1), success: {responseRequest,responseData in
            if let user = try? JSONDecoder().decode(User.self, from: responseData as! Data) {
                debugPrint("getUser StatusCode:\(String(describing: responseRequest?.statusCode))")
                debugPrint("User:\(user)")
            }
        }, failure: {_,_, error in
            debugPrint("getUser error:\(error)")
        })
    }
}
