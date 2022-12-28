//
//  Environment.swift
//  DXMVVMCExample
//
//  Created by iq on 12/26/22.
//

import Foundation

enum Environment {
    
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
            static let apiKey = "API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        return dict
    }()
    
    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary [Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        
        guard let url = URL (string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        
        return url
    }()
    
    public static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary [Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        
        return apiKey
    }()
}
