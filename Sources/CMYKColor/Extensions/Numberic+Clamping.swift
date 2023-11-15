// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension Numeric where Self: Comparable {
    func clamp(_ range: ClosedRange<Self>) -> Self {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}
