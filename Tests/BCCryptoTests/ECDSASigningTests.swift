import XCTest
import BCCrypto
import WolfBase

final class ECDSASigningTests: XCTestCase {
    func test1() {
        var rng = makeFakeRandomNumberGenerator()
        let privateKey = Crypto.newPrivateKeyECDSA(using: &rng)
        XCTAssertEqual(privateKey, ‡"7eb559bbbf6cce2632cf9f194aeb50943de7e1cbad54dcfab27a42759f5e2fed")
        let publicKey = Crypto.publicKeyFromPrivateKeyECDSA(privateKey: privateKey)
        XCTAssertEqual(publicKey, ‡"0271b92b6212a79b9215f1d24efb9e6294a1bedc95b6c8cf187cb94771ca02626b")
        
        let message = "Ladies and Gentlemen of the class of '99: If I could offer you only one tip for the future, sunscreen would be it.".utf8Data
        print(message.sha256Digest.sha256Digest.hex)
        let signature = Crypto.signECDSA(message: message, privateKeyECDSA: privateKey)
        print(signature.hex)
        
        XCTAssertTrue(Crypto.verifyECDSA(message: message, signature: signature, publicKeyECDSA: publicKey))
    }
}
