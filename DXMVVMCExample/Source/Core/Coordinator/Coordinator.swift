//
//  Coordintor.swift
//  DXMVVMCExample
//
//  Created by iq on 12/12/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
