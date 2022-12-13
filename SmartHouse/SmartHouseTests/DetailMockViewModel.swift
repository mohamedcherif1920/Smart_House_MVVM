//
//  DetailMockViewModel.swift
//  SmartHouseTests
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
@testable import SmartHouse


class DetailMockViewModel: DetailViewModelProtocol {
    var device: Device
    
    init(device: Device) {
        self.device = Device.getDevice(deviceType: .heaterOn)
    }
    
    func getDeviceType() -> DeviceType {
        if device.productType == "Light" {
            return .lighter(device)
        }
        if device.productType == "Heater" {
            return .heater(device)
        }
        
        if device.productType == "RollerShutter" {
            return .roller(device)
        }
        return .none
    }
    
    internal func getImageNameOn() -> String {
        switch getDeviceType() {
        case .heater:
            return ImageNames.temperatureOn
        case .lighter:
            return ImageNames.lightOn
        default:
            return ImageNames.roller
            
        }
    }
        
    internal func getImageNameOff() -> String {
        switch getDeviceType() {
        case .heater:
            return ImageNames.temperatureOff
        case .lighter:
            return ImageNames.lightOff
        default:
            return ImageNames.roller
            
        }
    }
    
    
    internal func getStep() -> Float {
        switch getDeviceType() {
        case .heater:
            return 0.5
        default:
            return 1
            
        }
    }
    
    internal func getLabelText() -> String {
        switch getDeviceType() {
        case .heater:
            return "Degree Celisus"
        case .lighter:
            return "Intensity"
        default:
            return "Position"
            
        }
    }
    
    
    internal func getInitialSliderValue() -> Float {
        switch getDeviceType() {
        case .heater(let heater):
            return Float(heater.temperature ?? 0)
        case .lighter(let lighter):
            return Float(lighter.intensity ?? 0)
        case .roller(let roller):
            return Float(roller.position ?? 0)
        default:
            return 0
            
        }
    }
    
    
    func getImageOn() -> String {
        return getImageNameOn()
    }
    
    func getImageOff() -> String {
        return getImageNameOff()
    }
    
    func getValueSuffix() -> String {
        return getLabelText()
    }
    
    func getStepValue() -> Float {
        return getStep()
    }

    
    func updateDeviceType(type: DeviceTest) {
        self.device = Device.getDevice(deviceType: type)
    }
    
}
