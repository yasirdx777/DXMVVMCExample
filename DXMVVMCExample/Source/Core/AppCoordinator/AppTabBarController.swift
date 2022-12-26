//
//  TabBarController.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/12/22.
//

import UIKit


class AppTabBarController: UITabBarController {
    let catsCoordinator = Container.catsCoordinator()
    let dogsCoordinator = Container.dogsCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catsCoordinator.start()
        dogsCoordinator.start()
        
        viewControllers = [catsCoordinator.navigationController, dogsCoordinator.navigationController]
    }
}
