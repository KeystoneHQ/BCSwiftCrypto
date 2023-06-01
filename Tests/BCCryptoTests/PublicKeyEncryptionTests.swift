import XCTest
import BCCrypto
import WolfBase

final class PublicKeyEncryptionTests: XCTestCase {
    func testX25519Keys() {
        var rng = makeFakeRandomNumberGenerator()
        let privateKey = x25519NewAgreementPrivateKey(using: &rng)
        XCTAssertEqual(privateKey, ‡"7eb559bbbf6cce2632cf9f194aeb50943de7e1cbad54dcfab27a42759f5e2fed")
        let publicKey = x25519AgreementPublicKeyFromPrivateKey(agreementPrivateKey: privateKey)
        XCTAssertEqual(publicKey, ‡"f1bd7a7e118ea461eba95126a3efef543ebb78439d1574bedcbe7d89174cf025")
        
        let derivedAgreementPrivateKey = x25519DeriveAgreementPrivateKey(keyMaterial: "password".utf8Data)
        XCTAssertEqual(derivedAgreementPrivateKey, ‡"7b19769132648ff43ae60cbaa696d5be3f6d53e6645db72e2d37516f0729619f")
        
        let derivedSigningPrivateKey = x25519DeriveSigningPrivateKey(keyMaterial: "password".utf8Data)
        XCTAssertEqual(derivedSigningPrivateKey, ‡"05cc550daa75058e613e606d9898fedf029e395911c43273a208b7e0e88e271b")
    }
    
    func testKeyAgreement() {
        var rng = makeFakeRandomNumberGenerator()
        let alicePrivateKey = x25519NewAgreementPrivateKey(using: &rng)
        let alicePublicKey = x25519AgreementPublicKeyFromPrivateKey(agreementPrivateKey: alicePrivateKey)
        let bobPrivateKey = x25519NewAgreementPrivateKey(using: &rng)
        let bobPublicKey = x25519AgreementPublicKeyFromPrivateKey(agreementPrivateKey: bobPrivateKey)
        let aliceSharedKey = x25519DeriveAgreementSharedKey(agreementPrivateKey: alicePrivateKey, agreementPublicKey: bobPublicKey)
        let bobSharedKey = x25519DeriveAgreementSharedKey(agreementPrivateKey: bobPrivateKey, agreementPublicKey: alicePublicKey)
        XCTAssertEqual(aliceSharedKey, bobSharedKey)
        XCTAssertEqual(aliceSharedKey, ‡"1e9040d1ff45df4bfca7ef2b4dd2b11101b40d91bf5bf83f8c83d53f0fbb6c23")
    }
}
