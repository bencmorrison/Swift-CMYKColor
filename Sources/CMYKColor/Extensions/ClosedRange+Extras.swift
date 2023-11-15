// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension ClosedRange where Bound == UInt8 {
    static let percentage: ClosedRange<Bound> = 0...100
}

extension ClosedRange where Bound == Double {
    static let percentage: ClosedRange<Bound> = 0...1.0
}
