//
//  DogsCoordinator.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import UIKit

final class DogsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate  {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = Container.dogsViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController (forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let catsViewController = fromViewController as? DogsViewController {
            childDidFinish(catsViewController.coordinator)
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
        let vc = Container.dogsViewController()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        navigationController.pushViewController(vc, animated: true)
    }
    
}
