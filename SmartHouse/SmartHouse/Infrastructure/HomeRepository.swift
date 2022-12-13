//
//  HomeRepository.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import Foundation
import Combine
protocol HomeRepositoryProtocol {
    var service: ServiceProtocol { get}
    func fetchData()  -> AnyPublisher<HomeResponse, Error>
}

class HomeRepository: HomeRepositoryProtocol {
    var service: ServiceProtocol
    
    init(
        service: ServiceProtocol
    ) {
        self.service = service
    }
    
    func fetchData() -> AnyPublisher<HomeResponse, Error> {
        return service.fetchData()
    }

}
