//
//  MainTabBarController.swift
//  DXMVVMCExample
//
//  Created by iq on 12/12/22.
//

import UIKit


class MainTabBarController: UITabBarController {
    let catsCoordinator = CatsCoordinator(navigationController: UINavigationController())
    let dogsCoordinator = DogsCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catsCoordinator.start()
        dogsCoordinator.start()
        
        viewControllers = [catsCoordinator.navigationController, dogsCoordinator.navigationController]
    }
}
