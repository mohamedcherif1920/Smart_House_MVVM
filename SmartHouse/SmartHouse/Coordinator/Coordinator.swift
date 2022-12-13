//
//  Coordinator.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import UIKit

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
