import XCTest
import BCCrypto

final class SSKRTests: XCTestCase {
    func test1() throws {
        let secret = Crypto.randomData(count: 32)
        let shares = try Crypto.splitSSKR(groupThreshold: 1, groups: [(2, 3)], secret: secret).flatMap { $0 }
        let recoveredShares = [shares[0], shares[2]]
        let recoveredSecret = try Crypto.combineSSKR(shares: recoveredShares)
        XCTAssertEqual(secret, recoveredSecret)
    }
}
