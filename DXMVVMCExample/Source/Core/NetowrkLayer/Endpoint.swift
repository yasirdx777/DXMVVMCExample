//
//  Endpoints.swift
//  shoppy
//
//  Created by iQ on 8/12/22.
//

import Foundation

protocol Endpoint {
    
    var scheme: String { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    
    var method: String { get }
}
