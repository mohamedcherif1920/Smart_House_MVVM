//
//  HomeViewModel.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import Combine


class HomeViewModel {
    var useCase: HomeUseCaseProtocol
    
    init(     useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    enum State {
        case initial
        case loading
        case success([Device])
        case fail(Error)
        
    }
    var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state = State.initial

    func fetchData() {
        useCase.execute()
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let `self` = self else { return }
            switch completion {
            case .failure(let error):
                self.state = .fail(error)
            case .finished:
                print("nothing much to do here")
            }
        } receiveValue: { [weak self ](response) in
            guard let `self` = self else { return }
            debugPrint(response)
            self.state = .success(response)
        }
        .store(in: &subscriptions)
    }
    
    
}
