// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

public enum CMYKColorError: Error {
    case stringDoesNotMeetExpectedFormat
    case valuesNotPercentages
    
    var message: String {
        switch self {
        case .stringDoesNotMeetExpectedFormat:
            return "Expected format: cmyk(c%, m%, y%, k%)"
        case .valuesNotPercentages:
            return "CMYK Values should be percents."
        }
    }
}
