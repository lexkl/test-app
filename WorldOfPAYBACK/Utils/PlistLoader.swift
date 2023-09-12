//
//  PlistLoader.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation

enum PlistLoaderError: Error {
    case cantGetFilePath
    case cantLoadFile
    case cantReadFile
}

struct PlistLoader {
    func stringDictionaryPlist(name: String) throws -> [String: String] {
        let plist = try plist(name: name) as? [String: String]
        guard let loadedPlist = plist else {
            throw PlistLoaderError.cantReadFile
        }
        
        return loadedPlist
    }
    
    
    private func plist(name: String) throws -> Any {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            throw PlistLoaderError.cantGetFilePath
        }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else {
            throw PlistLoaderError.cantLoadFile
        }

        let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        guard let loadedPlist = plist else {
            throw PlistLoaderError.cantReadFile
        }
        
        return loadedPlist
    }
}
