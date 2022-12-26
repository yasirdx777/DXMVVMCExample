//
//  CatViewCoordinator.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/12/22.
//

import UIKit

final class CatsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate  {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = Container.catsViewController()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController (forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let catsViewController = fromViewController as? CatsViewController {
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

extension CatsCoordinator {
    func nextCatsView() {
        let vc = Container.catsViewController()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        navigationController.pushViewController(vc, animated: true)
    }
}
