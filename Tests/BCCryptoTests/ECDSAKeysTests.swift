import XCTest
import BCCrypto
import WolfBase

final class ECDSAKeysTests: XCTestCase {
    func testECDSAKeys() {
        var rng = makeFakeRandomNumberGenerator()
        let privateKey = Crypto.newPrivateKeyECDSA(using: &rng)
        XCTAssertEqual(privateKey, ‡"7eb559bbbf6cce2632cf9f194aeb50943de7e1cbad54dcfab27a42759f5e2fed")
        let publicKey = Crypto.publicKeyFromPrivateKeyECDSA(privateKey: privateKey)
        XCTAssertEqual(publicKey, ‡"0271b92b6212a79b9215f1d24efb9e6294a1bedc95b6c8cf187cb94771ca02626b")
        
        let decompressed = Crypto.decompressPublicKeyECDSA(compressedPublicKey: publicKey)
        XCTAssertEqual(decompressed, ‡"0471b92b6212a79b9215f1d24efb9e6294a1bedc95b6c8cf187cb94771ca02626b72325f1f3bb69a44d3f1cb6d1fd488220dd502f49c0b1a46cb91ce3718d8334a")
        
        let compressed = Crypto.compressPublicKeyECDSA(uncompressedPublicKey: decompressed)
        XCTAssertEqual(compressed, publicKey)
        
        let xOnly = Crypto.xOnlyPublicKeyFromPrivateKeyECDSA(privateKey: privateKey)
        XCTAssertEqual(xOnly, ‡"71b92b6212a79b9215f1d24efb9e6294a1bedc95b6c8cf187cb94771ca02626b")
        
        let derivedPrivateKey = Crypto.derivePrivateKeyECDSA(keyMaterial: "password".utf8Data)
        XCTAssertEqual(derivedPrivateKey, ‡"05cc550daa75058e613e606d9898fedf029e395911c43273a208b7e0e88e271b")
    }
}
