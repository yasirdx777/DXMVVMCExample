//
//  File.swift
//  DXCats
//
//  Created by iQ on 8/28/22.
//

import Foundation
import UIKit

protocol Factory {
    var networkEngine: NetworkEngineProtocol { get }
    
//    func makeInitialViewController(coordinator: ProjectCoordinator) -> CatsViewController
//    func makeInitialViewModel(coordinator: RootCoordinator) -> CatsViewModel
    
}

class DependencyFactory: Factory {
    
    lazy var networkEngine: NetworkEngineProtocol = NetworkEngine()
    
//    func makeInitialCoordinator() -> ProjectCoordinator {
//        let coordinator = ProjectCoordinator(factory: self)
//        return coordinatr
//    }
    
//    func makeInitialViewController(coordinator: ProjectCoordinator) -> CatsViewController {
//        let viewModel = makeInitialViewModel(coordinator: coordinator)
//        let initialViewController = CatsViewController(coordinator: coordinator, viewModel: viewModel)
//        return initialViewController
//    }
//    
//    func makeInitialViewModel(coordinator: RootCoordinator) -> CatsViewModel {
//        let viewModel = CatsViewModel(coordinator: coordinator, networkEngine: networkEngine)
//        return viewModel
//    }
    
}
