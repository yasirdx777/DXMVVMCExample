//
//  FirstCoordinator.swift
//  MVVM-C Tutorial
//
//  Created by Alexandre Quiblier on 19/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class DogsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate  {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    @Injected(Container.networkEngine) private var networkEngine
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = DogsViewModel(coordinator: self, networkEngine: networkEngine)
        let vc = DogsViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController (forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let catsViewController = fromViewController as? DogsViewController {
            childDidFinish(catsViewController.viewModel.coordinator)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
                childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}

extension DogsCoordinator {
    func nextDogsView() {
        let ne: NetworkEngineProtocol = NetworkEngine()
        let vm = DogsViewModel(coordinator: self, networkEngine: ne)
        let vc = DogsViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
