import XCTest
import BCCrypto
import WolfBase

final class SigningTests: XCTestCase {
    func testSigning() {
        var rng = makeFakeRandomNumberGenerator()
        let privateKey = ecdsaNewPrivateKey(using: &rng)
        let message = "Ladies and Gentlemen of the class of '99: If I could offer you only one tip for the future, sunscreen would be it.".utf8Data

        let ecdsaPublicKey = ecdsaPublicKeyFromPrivateKey(privateKey: privateKey)
        let ecdsaSignature = ecdsaSign(privateKeyECDSA: privateKey, message: message)
        XCTAssertEqual(ecdsaSignature, ‡"e75702ed8f645ce7fe510507b2403029e461ef4570d12aa440e4f81385546a13740b7d16878ff0b46b1cbe08bc218ccb0b00937b61c4707de2ca6148508e51fb")
        XCTAssertTrue(ecdsaVerify(publicKeyECDSA: ecdsaPublicKey, signature: ecdsaSignature, message: message))
        
        let schnorrPublicKey = schnorrPublicKeyFromPrivateKey(privateKey: privateKey)
        let tag = rng.randomData(16)
        let schnorrSignature = schnorrSign(ecdsaPrivateKey: privateKey, message: message, tag: tag, rng: &rng)
        XCTAssertEqual(schnorrSignature, ‡"15d7396ed2862dfa813679a0a0377d8d55310ff693ef913bc9cddd48aa93e0542e416b52e0572ec20a2b47db1904c9e7632f1229d8b16af09fb4f6e3f8feefa0")
        XCTAssertTrue(schnorrVerify(schnorrPublicKey: schnorrPublicKey, signature: schnorrSignature, message: message, tag: tag))
    }
}
