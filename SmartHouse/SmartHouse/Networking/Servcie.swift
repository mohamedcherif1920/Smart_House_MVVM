//
//  Servcie.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
import Combine

protocol ServiceProtocol: AnyObject {
    func fetchData() -> AnyPublisher<HomeResponse, Error>
}


enum FetchError: Error {
    case failed
}

class Service: ServiceProtocol {
        
    func fetchData() -> AnyPublisher<HomeResponse, Error> {
        guard let url = URL(string: BaseUrls.usine) else {
            return Future<HomeResponse, Error>(){ promise in
                promise(.failure(FetchError.failed))
            }.eraseToAnyPublisher()
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: HomeResponse.self,
                    decoder: JSONDecoder())
            .catch { error in
                Future<HomeResponse, Error>(){ promise in
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }
}
