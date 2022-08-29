//
//  FirstCoordinator.swift
//  MVVM-C Tutorial
//
//  Created by Alexandre Quiblier on 19/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class DogsCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Coordinator
    
    func start() {
        showFirstViewController()
    }
    
    private func showFirstViewController() {
        let viewModel = DogsViewModel()
        let viewController = DogsViewController(style: .grouped)
        viewController.viewModel = viewModel
        viewModel.view = viewController
        presenter.viewControllers = [viewController]
    }
}
