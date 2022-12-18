//
//  CatViewCoordinator.swift
//  DXMVVMCExample
//
//  Created by iq on 12/12/22.
//

import UIKit


final class CatsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate  {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    @Injected(Container.networkEngine) private var networkEngine
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = CatsViewModel(coordinator: self, networkEngine: networkEngine)
        let vc = CatsViewController(viewModel: vm)
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: Int.random(in: 0...1000))
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController (forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        if let catsViewController = fromViewController as? CatsViewController {
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

extension CatsCoordinator {
    func nextCatView() {
        let ne: NetworkEngineProtocol = NetworkEngine()
        let vm = CatsViewModel(coordinator: self, networkEngine: ne)
        let vc = CatsViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
