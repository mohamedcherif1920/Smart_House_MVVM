//
//  DetailViewFactory.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import SwiftUI
protocol DetailViewManufactoring {
    static func makeView(from device: Device) -> DetailsViewController
}
// MARK: - Factory
final class DetailViewFactory: DetailViewManufactoring {
    
   public func configureView(from device: Device) -> DetailsViewController {
       let viewModel = makeViewModel(from: device)
        let view = DetailsViewController(viewModel: viewModel)
        return view
    }

    private func makeViewModel(from device: Device) -> DetailViewModel {
        return DetailViewModel(device: device)
    }
    
    static func makeView(from device: Device) -> DetailsViewController {
        self.init().configureView(from: device)
    }
}
