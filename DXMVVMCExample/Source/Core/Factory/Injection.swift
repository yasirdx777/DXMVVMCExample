//
//  Injection.swift
//  DXMVVMCExample
//
//  Created by iq on 12/18/22.
//

import Foundation


extension Container {
    static let networkEngine = Factory<NetworkEngineProtocol> { NetworkEngine() }
}
