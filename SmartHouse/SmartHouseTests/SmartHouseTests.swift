//
//  SmartHouseTests.swift
//  SmartHouseTests
//
//   Created by Devinsley on 12/12/2022.
//

import XCTest
@testable import SmartHouse

class SmartHouseTests: XCTestCase {
    var viewModel: DetailMockViewModel!
    override func setUp() {
        viewModel = DetailMockViewModel(device: Device.getDevice(deviceType: .heaterOn))
    }

    override func tearDown()  {
       viewModel = nil
    }
// MARK : - Heater
    func testHeaterIcon_WhenHeater_shoudReturnTrue()  {
        let sut = viewModel.getImageOn()
        XCTAssertEqual(sut, ImageNames.temperatureOn)
    }
    
    
    func testSuffixLabel_WhenHeater_shoudReturnTrue()  {
        let sut = viewModel.getValueSuffix()
        XCTAssertEqual(sut, "Degree Celisus")
    }
    

    func testLightIcon_WhenLight_shoudReturnTrue()  {
        viewModel.updateDeviceType(type: .heaterOff)
        let sut = viewModel.getImageOn()
        XCTAssertEqual(sut, ImageNames.roller)
    }
    
    // light
    func testHeaterIcon_WhenHeater_shoudReturnfalse()  {
        viewModel.updateDeviceType(type: .heaterOff)
        let sut = viewModel.getImageOn()
        XCTAssertNotEqual(sut, ImageNames.roller)
    }
    // test subFixLAbel if type roller (should return Position)
    func testSuffixLabel_whenRoller_ShouldReturnTrue()
    {
        viewModel.updateDeviceType(type: .roller)
        let sut = viewModel.getValueSuffix()
        XCTAssertEqual(sut, "Position")
    }
    

    func getDevice(type: DeviceTest) -> Device {
        return Device.getDevice(deviceType: type)
    }

}
