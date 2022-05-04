//
//  NetworkManager.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 4/29/22.
//

import Alamofire

/// Custom class used for executing requests with a specific configuration
///
/// Implemented to handle the custom `Request` and callbacks
class NetworkManager {
    /// Closure to be executed when handling request success
    public typealias NetworkSuccessHandler = (HTTPURLResponse?, AnyObject?) -> Void
    /// Closure to be executed when handling request failure
    public typealias NetworkFailureHandler = (HTTPURLResponse?, AnyObject?, Error) -> Void
    
    /// Creates an instance with the specified `url`, `success method`, and ` failure method`.
    ///
    /// - Parameters:
    ///   - url:     The `URLConvertible` value.
    ///   - success:  The `NetworkSuccessHandler closure`.
    ///   - failure: The `NetworkFailureHandler closure`.
    /// - Returns: A `Request` object with the request properties defined.
    open func request(
        _ url: URLRequestConvertible,
        success: NetworkSuccessHandler?,
        failure: NetworkFailureHandler?) -> Request? {
        
        let request = AF.request(url).response {
            response in
            if let error = response.error {
                failure?(response.response, response.data as AnyObject?, error)
            } else {
                success?(response.response, response.data as AnyObject)
            }
        }.resume()
        return request
    }
}
