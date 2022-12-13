//
//  CellViewModel.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
class CellViewModel {
    
    let deviceName: String
    let mode: String?
    let productType : String?
    let temperature : Int?
    let intensity : Int?
    let position: Int?
    
    init(
        deviceName: String,
         mode: String? = nil,
        productType: String,
        temperature: Int?,
        intensity: Int?,
        position: Int?
        
        
    ) {
        self.deviceName = deviceName
        self.mode = mode
        self.productType = productType
        self.intensity = intensity
        self.temperature = temperature
        self.position = position
    }
}
