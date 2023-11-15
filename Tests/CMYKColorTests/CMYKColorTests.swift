// Copyright © 2023 Ben Morrison. All rights reserved.

import XCTest
import SwiftUI

@testable import CMYKColor

final class CMYKColorTests: XCTestCase {
    func testCMYKtoRGB() throws {
        for color in TestColor.allCases {
            AssertCMYKtoRGBIsvaludForColor(color)
        }
    }
    
    func testRGBtoCMYK() throws {
        for color in TestColor.allCases {
            AssertRGBtoCMYKIsvaludForColor(color)
        }
    }
    
    func testStringtoCMYK() throws {
        var testValues = CMYKStringHelper(
            cyan: 100,
            magenta: 55,
            yellow: 9,
            key: 44
        )
        
        let values = try CMYKColor.cmykValues(from: testValues.string)
        let result = CMYKStringHelper(
            cyan: values.0,
            magenta: values.1,
            yellow: values.2,
            key: values.3
        )
        
        XCTAssertEqual(testValues, result, "CMYK from String parsing failed.")
    }
}

extension XCTest {
    fileprivate func AssertCMYKtoRGBIsvaludForColor(_ color: TestColor, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
        let rgbValue = CMYKColor.rgbValues(fromCyan: color.cmyk.0, magenta: color.cmyk.1, yellow: color.cmyk.2, key: color.cmyk.3)
        XCTAssertEqual(rgbValue.0, color.rgb.0, "Test color: \(color.rawValue.uppercased()) has Red Failure" + message())
        XCTAssertEqual(rgbValue.1, color.rgb.1, "Test color: \(color.rawValue.uppercased()) has Green Failure" + message())
        XCTAssertEqual(rgbValue.2, color.rgb.2, "Test color: \(color.rawValue.uppercased()) has Blue Failure" + message())
    }
    
    fileprivate func AssertRGBtoCMYKIsvaludForColor(_ color: TestColor, _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line) {
        let cmykValue = CMYKColor.cmykValues(fromRed: color.rgb.0, green: color.rgb.1, blue: color.rgb.2)
        let cmyk = CMYKColor(cyan: cmykValue.0, magenta: cmykValue.1, yellow: cmykValue.2, key: cmykValue.3)
        let rgb = cmyk.rgbValues
        XCTAssertEqual(rgb.0, color.rgb.0, "Test color: \(color.rawValue.uppercased()) has Red Failure" + message())
        XCTAssertEqual(rgb.1, color.rgb.1, "Test color: \(color.rawValue.uppercased()) has Green Failure" + message())
        XCTAssertEqual(rgb.2, color.rgb.2, "Test color: \(color.rawValue.uppercased()) has Blue Failure" + message())
    }
}

private struct CMYKStringHelper: Equatable {
    let cyan, magenta, yellow, key: UInt8
    
    lazy var string: String = {
        "cmyk(\(cyan)%, \(magenta)%, \(yellow)%, \(key)%)"
    }()
    
    init(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) {
        self.cyan = cyan
        self.magenta = magenta
        self.yellow = yellow
        self.key = key
    }
    
    init(string: String) throws {
        let values = try CMYKColor.cmykValues(from: string)
        cyan = values.0
        magenta = values.1
        yellow = values.2
        key = values.3
    }
}
