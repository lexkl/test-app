//
//  URLLoader.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation

enum EnvironmentURL: String {
    case production
    case test
}

struct URLLoader {
    let loader: PlistLoader
    
    private let baseURLSourceName = "URLs"
    
    func load() -> [EnvironmentURL: String] {
        guard let loadedPlist = try? loader.stringDictionaryPlist(name: baseURLSourceName) else {
            return [:]
        }
        
        return map(plist: loadedPlist)
    }
    
    private func map(plist: [String: String]) -> [EnvironmentURL: String] {
        var mappedPlist = [EnvironmentURL: String]()
        
        plist.forEach { (key: String, value: String) in
            guard let keyAsBaseURL = EnvironmentURL(rawValue: key) else {
                return
            }
            
            mappedPlist[keyAsBaseURL] = value
        }
        
        return mappedPlist
    }
}
