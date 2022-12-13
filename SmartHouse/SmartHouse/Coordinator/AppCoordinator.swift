//
//  AppCoordinator.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//
import UIKit
import Combine
class ApplicationFlowCoordinator: Coordinator {

    // MARK: - Private properties -
    @Published var didTapPush: Bool = false
    private var window: UIWindow

    // MARK: - Internal properties -

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initialization -

    init(navigationController: UINavigationController, window: UIWindow) {
        self.window = window
        self.navigationController = navigationController
    }

    // MARK: - Internal methods -

    func start() {
        showEntryViewController()
    }

    // MARK: - Private methods -

    private func showEntryViewController() {
        let viewController = HomeViewFactory.makeView()
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        
       _ = viewController.callback = { [weak self] (device) in
           guard let `self` = self else { return }
           self.prepareSecondViewController(device: device)
        }
    }
    
    
    private func prepareSecondViewController(device: Device) {
        let nextViewController = DetailViewFactory.makeView(from: device)
        self.showViewController(nextViewController)
    }

    private func showViewController(_ viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController.pushViewController(viewController, animated: true)

        }
    }
}
