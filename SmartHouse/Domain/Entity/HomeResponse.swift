//
//  HomeResponse.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
enum DeviceTest {
    case heaterOn
    case heaterOff
    case lightOn
    case lightOff
    case roller
    
}
// MARK: - RequestResponse
struct HomeResponse: Codable {
    let devices: [Device]
    let user: User
}

// MARK: - Device
struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: String
    let position, temperature: Int?
    
    
    static func getDevice(deviceType: DeviceTest) -> Device {
        switch deviceType {
        case .heaterOn:
            return Device(id: 10, deviceName: "Cuisine", intensity: nil, mode: "ON", productType: "Heater", position: nil, temperature: 20)
        case .roller :
            return Device(id: 15, deviceName: "Salon", intensity: nil, mode: nil, productType: "RollerShutter", position: 40, temperature: nil)
                
        default:
            return Device(id: 13, deviceName: "Cuisine", intensity: nil, mode: "OFF", productType: "Heater", position: nil, temperature: 20)
            
        }
      
    }
}


// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
