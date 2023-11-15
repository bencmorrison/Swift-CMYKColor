// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

/// Provides a structure that defines CMYK values for color use.
public struct CMYKColor {
    /// The cyan channel value represented as a percent 0 to 100
    public var cyan: UInt8 {
        get { _cyan }
        set { _cyan = newValue.clamp(.percentage) }
    }
    
    /// The magenta channel value represented as a percent 0 to 100
    public var magenta: UInt8 {
        get { _magenta }
        set { _magenta = newValue.clamp(.percentage) }
    }
    
    /// The yellow channel value represented as a percent 0 to 100
    public var yellow: UInt8 {
        get { _yellow }
        set { _yellow = newValue.clamp(.percentage) }
    }
    
    /// The key (black) channel value represented as a percent 0 to 100
    public var key: UInt8 {
        get { _key }
        set { _key = newValue.clamp(.percentage) }
    }
    
    private var _cyan: UInt8
    private var _magenta: UInt8
    private var _yellow: UInt8
    private var _key: UInt8
    
    /// A Tupal of the RGB represenation ordered respectively.
    public var rgbValues: (UInt8, UInt8, UInt8) {
        Self.rgbValues(fromCyan: cyan, magenta: magenta, yellow: yellow, key: key)
    }
    
    /// Creates a `CMYKColor` frome the provided channels in percentage form.
    /// - Note: If a channel value is over 100, it will be clamped to 100.
    /// - Parameters:
    ///   - cyan: The cyan channel value as a percent 0 to 100
    ///   - magenta: The magenta channel value as a percent 0 to 100
    ///   - yellow: The yellow channel value as a percent 0 to 100
    ///   - key: The key (black) channel value as a percent 0 to 100
    public init(cyan: UInt8, magenta: UInt8, yellow: UInt8, key: UInt8) {
        _cyan = cyan.clamp(.percentage)
        _magenta = magenta.clamp(.percentage)
        _yellow = yellow.clamp(.percentage)
        _key = key.clamp(.percentage)
    }
    
    /// Creates a `CMYKColor` frome the provided channels in a decimal 
    /// representation of a percentage.
    /// - Note: If a channel value is below 0.0 it is clammped to 0.0. 
    /// If it is above 1.0, it is clampped to 1.0
    /// - Parameters:
    ///   - cyan: The cyan channel value as a decimal representation of a percentage.
    ///   - magenta: The magenta channel value a decimal representation of a percentage.
    ///   - yellow: The yellow channel value as a decimal representation of a percentage.
    ///   - key: The key (black) channel value as a decimal representation of a percentage.
    public init(cyan: Double, magenta: Double, yellow: Double, key: Double) {
        _cyan = UInt8(cyan.clamp(.percentage) * 100)
        _magenta = UInt8(magenta.clamp(.percentage) * 100)
        _yellow = UInt8(yellow.clamp(.percentage) * 100)
        _key = UInt8(key.clamp(.percentage) * 100)
    }
    
    
    /// Creates a `CMYKColor` from the provided cmyk string that follows the following format:
    /// `cmyk(cyan%, magenta%, yellow%, key%)`
    /// - Throws: Throws an error when the format is not `cmyk(cyan%, magenta%, yellow%, key%)`
    /// - Parameter cmykString: The `String` representation of the cmyk color
    public init(_ cmykString: String) throws {
        let values = try Self.cmykValues(from: cmykString)
        self.init(cyan: values.0, magenta: values.1, yellow: values.2, key: values.3)
    }
    
    /// Creates a `CMYKColor` from the provided cmyk string that follows the following format:
    /// `cmyk(cyan%, magenta%, yellow%, key%)`.
    /// Returns nil when the string is the wrong format.
    /// - Parameter cmykString: The `String` representation of the cmyk color
    public init?(from cmykString: String) {
        guard let values = try? Self.cmykValues(from: cmykString) else { return nil }
        self.init(cyan: values.0, magenta: values.1, yellow: values.2, key: values.3)
    }
}
