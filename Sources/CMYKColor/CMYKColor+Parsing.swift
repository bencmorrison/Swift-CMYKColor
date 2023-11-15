// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension CMYKColor {
    /// Converts CMYK values to RGB
    /// - Note: If a channel value is above 100, it will be clamped to 100
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    /// - Returns: A tupal of the RGB values, in that order. The values will be 0 to 255.
    public static func rgbValues(
        fromCyan cyan: UInt8,
        magenta: UInt8,
        yellow: UInt8,
        key: UInt8
    ) -> (UInt8, UInt8, UInt8) {
        let adjustedKey = UInt(100 - key.clamp(.percentage))
        
        let red   = UInt(255 * (100 - UInt(cyan.clamp(.percentage))) * adjustedKey)
        let green = UInt(255 * (100 - UInt(magenta.clamp(.percentage))) * adjustedKey)
        let blue  = UInt(255 * (100 - UInt(yellow.clamp(.percentage))) * adjustedKey)
        
        return (
            UInt8(ceil(Double(red) / Double(10000))),
            UInt8(ceil(Double(green) / Double(10000))),
            UInt8(ceil(Double(blue) / Double(10000)))
        )
    }
    
    /// Converts RGB values to CMYK
    /// - Parameters:
    ///   - red: The red channel represenation
    ///   - green: The green channel represenation
    ///   - blue: The blue channel represenation
    /// - Returns: A tupal of CMYK values, in that order. Values are represented as 
    /// a percentage (0 - 100)
    public static func cmykValues(
        fromRed red: UInt8,
        green: UInt8,
        blue: UInt8
    ) -> (UInt8, UInt8, UInt8, UInt8) {
        let redPrime = UInt(floor(Double(UInt(red) * 100) / 255.0))
        let greenPrime = UInt(floor(Double(UInt(green) * 100) / 255.0))
        let bluePrime = UInt(floor(Double(UInt(blue) * 100) / 255.0))
        let key = 100 - max(redPrime, greenPrime, bluePrime)
        
        var adjustedKey = 100 - key
        if adjustedKey == 0 { adjustedKey = 1 }
        
        let cyan = Double(100 - redPrime - key) / Double(adjustedKey)
        let magenta = Double(100 - greenPrime - key) / Double(adjustedKey)
        let yellow = Double(100 - bluePrime - key) / Double(adjustedKey)
        
        return (
            UInt8(ceil(cyan * 100)),
            UInt8(ceil(magenta * 100)),
            UInt8(ceil(yellow * 100)),
            UInt8(key)
        )
    }
    
    /// Allows the values for a CMYK to be parsed from string notation.
    /// Example: `cmyk(100%, 75%, 0%, 88%)`
    /// - Parameter cmykString: The string containing the cmyk values in the specified format.
    /// - Returns: A tupal containing the CMYK values, in that order.
    public static func cmykValues(from cmykString: String) throws -> (UInt8, UInt8, UInt8, UInt8) {
        guard cmykString.contains(.cmykColor) else { throw CMYKColorError.stringDoesNotMeetExpectedFormat }
        
        var modifiedString = cmykString.lowercased()
        modifiedString = modifiedString.replacingOccurrences(of: "cmyk(", with: "")
        modifiedString = modifiedString.replacingOccurrences(of: ")", with: "")
        modifiedString = modifiedString.replacingOccurrences(of: " ", with: "")
        modifiedString = modifiedString.replacingOccurrences(of: "%", with: "")

        let split = modifiedString.split(separator: ",")

        let ensurePercent: (Substring) throws -> UInt8 = { value in
            let value = Int(value) ?? -1
            guard value >= 0 && value <= 100 else { throw CMYKColorError.valuesNotPercentages }
            return UInt8(value)
        }

        return (
            try ensurePercent(split[0]),
            try ensurePercent(split[1]),
            try ensurePercent(split[2]),
            try ensurePercent(split[3])
        )
    }
}
