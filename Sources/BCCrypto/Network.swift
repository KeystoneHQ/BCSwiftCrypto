import Foundation
import BCWally

public enum Network {
    case mainnet
    case testnet
    
    var wallyForm: BCWally.Network {
        switch self {
        case .mainnet:
            return .mainnet
        case .testnet:
            return .testnet
        }
    }
}
