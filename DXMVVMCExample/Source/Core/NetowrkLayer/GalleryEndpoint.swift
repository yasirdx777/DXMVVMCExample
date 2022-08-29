//
//  HomeEndpoint.swift
//  shoppy
//
//  Created by iQ on 8/12/22.
//

import Foundation

enum GalleryEndpoint: Endpoint {
    case getData(query: String)
    
    var scheme: String {
        switch self {
        case .getData:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .getData:
            return unsplashBaseURl
        }
    }
    
    var path: String {
        switch self {
        case .getData:
            return "/search/photos"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getData(let query):
            return [URLQueryItem(name: "query", value: query)]
        }
    }
    
    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
    
    
}
