//
//  HomeFactory.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import SwiftUI
protocol HomeViewManufactoring {
     static func makeView() -> HomeViewController
}
// MARK: - Factory
final class HomeViewFactory: HomeViewManufactoring {
    
   public func configureView() -> HomeViewController {
        let viewModel = makeViewModel()
        let view = HomeViewController(viewModel: viewModel)
        return view
    }
    
    private func makeRepository() -> HomeRepositoryProtocol {
        return HomeRepository(service: Service())
    }
    
    private func makeUseCase() -> HomeUseCaseProtocol {
        return HomeUseCase(repository: makeRepository())
    }
    
    private func makeViewModel() -> HomeViewModel {
        return HomeViewModel(useCase: makeUseCase())
    }
    
    public static func makeView() -> HomeViewController {
        return self.init().configureView()
    }
}

