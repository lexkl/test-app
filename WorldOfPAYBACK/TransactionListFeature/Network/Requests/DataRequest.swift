//
//  DataRequest.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol DataRequest {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get }
}

extension DataRequest {
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String] {
        [:]
    }
    
    func asURLRequest() throws -> URLRequest? {
        guard !url.isEmpty, let requestURL = URL(string: url) else {
            throw NetworkError.generalError
        }
                
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
