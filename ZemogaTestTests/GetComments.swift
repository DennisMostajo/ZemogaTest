//
//  GetComments.swift
//  ZemogaTestTests
//
//  Created by Dennis.Mostajo on 5/4/22.
//

import XCTest

class GetComments: XCTestCase {

    func testGetComments() {
        _ = NetworkManager.shared.request(API.getCommentsFromPostWithId(postId: 1), success: {responseRequest,responseData in
            if let comments = try? JSONDecoder().decode([Comment].self, from: responseData as! Data) {
                debugPrint("getComments StatusCode:\(String(describing: responseRequest?.statusCode))")
                debugPrint("Comments:\(comments)")
                }
            }, failure: {_,_, error in
                debugPrint("getComments error:\(error)")
            })
    }
}
