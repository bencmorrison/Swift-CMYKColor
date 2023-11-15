// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension CMYKColor: Equatable {
    public static func == (lhs: CMYKColor, rhs: CMYKColor) -> Bool {
        return lhs.cyan == rhs.cyan &&
        lhs.magenta == rhs.magenta &&
        lhs.yellow == rhs.yellow &&
        lhs.key == rhs.key
    }
}
