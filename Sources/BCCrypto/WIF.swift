import Foundation
import BCWally

public extension Crypto {
    static func encodeWIF(key: Data, network: Network, isPublicKeyCompressed: Bool) -> String {
        Wally.encodeWIF(key: key, network: network.wallyForm, isPublicKeyCompressed: isPublicKeyCompressed)
    }
}
