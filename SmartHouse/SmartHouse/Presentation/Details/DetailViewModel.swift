//
//  DetailViewModel.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import Foundation
enum DeviceType {
    case heater(Device)
    case lighter(Device)
    case roller(Device)
    case none
}

protocol DetailViewModelProtocol {
    var device: Device { get set}
    
    func getDeviceType() -> DeviceType
    func getImageNameOn() -> String
    func getImageNameOff() -> String
    func getStep() -> Float
    func getLabelText() -> String
    func getInitialSliderValue() -> Float
    func getImageOn() -> String
    func getImageOff() -> String
    func getValueSuffix() -> String
    func getStepValue() -> Float
}
class DetailViewModel: DetailViewModelProtocol {
    var device: Device
    
    @Published var sliderValue: Float = 0
    @Published var switchOn: Bool = false
    init(
        device: Device
    ) {
        self.device = device
        self.sliderValue = getInitialSliderValue()
        self.switchOn = device.mode == "ON"
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
    
}
