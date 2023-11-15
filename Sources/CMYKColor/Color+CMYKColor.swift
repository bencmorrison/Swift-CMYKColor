// Copyright © 2023 Ben Morrison. All rights reserved.

import SwiftUI

extension Color {
    /// Allows the creation of a `Color` form CMYK color string.
    /// - Note: Expects the format of the string to be `cmyk(cyan%, magenta%, yellow%, key%)`
    /// - Throws: an error when the format is not correct.
    /// - Parameter cmyk: The cmyk color string to use.
    public init(cmyk: String) throws {
        self = try CMYKColor(cmyk).color
    }
    
    /// Allows the creation of a `Color` form CMYK color string.
    /// - Note: Expects the format of the string to be `cmyk(cyan%, magenta%, yellow%, key%)`
    /// Returns nil when the string format is incorrect or the percents do not fall between 0 and 100.
    /// - Parameter cmykString: The cmyk color string to use.
    public init?(from cmykString: String) {
        do { self = try CMYKColor(cmykString).color }
        catch { return nil }
    }
    
    /// Creates a color using the CMKY color space
    /// - Parameter cmyk: A `CMYKColor` defining the color
    public init(_ cmyk: CMYKColor) {
        self = cmyk.color
    }
    
    /// Creates a color using the CMKY color space
    /// - Note: If a channel value is over 100, it will be clamped to 100.
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    public init(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) {
        let rgb = CMYKColor.rgbValues(fromCyan: cyan, magenta: magenta, yellow: yellow, key: key)
        self.init(
            red: Double(rgb.0) / 255.0,
            green: Double(rgb.1) / 255.0,
            blue: Double(rgb.2) / 255.0
        )
    }
    
    /// Creates  a color using the CMKY color space
    /// - Note: If a channel value is below 0.0 it is clammped to 0.0. 
    /// If it is above 1.0, it is clampped to 1.0
    /// - Parameters:
    ///   - cyan: The cyan channel value.
    ///   - magenta: The magenta channel value.
    ///   - yellow: The yellow channel value.
    ///   - key: The key (black) channel value.
    public init(cyan: Double, magenta: Double, yellow: Double, key: Double) {
        let rgb = CMYKColor.rgbValues(
            fromCyan: UInt8(cyan.clamp(.percentage) * 100),
            magenta: UInt8(magenta.clamp(.percentage) * 100),
            yellow: UInt8(yellow.clamp(.percentage) * 100),
            key: UInt8(key.clamp(.percentage) * 100)
        )
        self.init(
            red: Double(rgb.0) / 255.0,
            green: Double(rgb.1) / 255.0,
            blue: Double(rgb.2) / 255.0
        )
    }
}

extension CMYKColor {
    var color: Color {
        Color(
            red: Double(rgbValues.0) / 255.0,
            green: Double(rgbValues.1) / 255.0,
            blue: Double(rgbValues.2) / 255.0
        )
    }
}
