//
//  HomeUseCase.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import Combine
protocol HomeUseCaseProtocol {
    var repository: HomeRepositoryProtocol { get}
    func execute()  -> AnyPublisher<[Device], Error>
}


class HomeUseCase: HomeUseCaseProtocol {
    var repository: HomeRepositoryProtocol
    
    init( repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute()  -> AnyPublisher<[Device], Error> {
        repository.fetchData()
            .map({$0.devices})
            .eraseToAnyPublisher()
    }
}
