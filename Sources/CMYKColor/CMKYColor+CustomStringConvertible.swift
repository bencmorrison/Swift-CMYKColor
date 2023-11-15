// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension CMYKColor: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        "cmyk(\(cyan)%, \(magenta)%, \(yellow)%, \(key)%)"
    }
    
    public var debugDescription: String {
        """
           cyan: \(cyan)%
        magenta: \(magenta)%
         yellow: \(yellow)%
            key: \(key)%
        """
    }
}
