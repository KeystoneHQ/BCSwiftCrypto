import Foundation
import CryptoKit

public extension Crypto {
    static func x25519NewAgreementPrivateKey<T: RandomNumberGenerator>(using rng: inout T) -> Data {
        rng.randomData(32)
    }
    
    static func x25519NewAgreementPrivateKey() -> Data {
        var rng = SecureRandomNumberGenerator()
        return x25519NewAgreementPrivateKey(using: &rng)
    }
    
    static func x25519AgreementPublicKeyFromPrivateKey<D: DataProtocol>(agreementPrivateKey: D) -> Data {
        try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: Data(agreementPrivateKey)).publicKey.rawRepresentation
    }
    
    static func x25519DeriveAgreementPrivateKey<D: DataProtocol>(keyMaterial: D) -> Data {
        hkdfHMACSHA256(keyMaterial: keyMaterial, salt: "agreement".utf8Data, keyLen: 32)
    }
    
    static func x25519DeriveSigningPrivateKey<D: DataProtocol>(keyMaterial: D) -> Data {
        hkdfHMACSHA256(keyMaterial: keyMaterial, salt: "signing".utf8Data, keyLen: 32)
    }

    static func x25519DeriveAgreementSharedKey<D1, D2>(agreementPrivateKey: D1, agreementPublicKey: D2) -> Data
    where D1: DataProtocol, D2: DataProtocol {
        let agreementPrivateKey = try! Curve25519.KeyAgreement.PrivateKey(rawRepresentation: Data(agreementPrivateKey))
        let agreementPublicKey = try! Curve25519.KeyAgreement.PublicKey(rawRepresentation: Data(agreementPublicKey))
        let sharedSecret = try! agreementPrivateKey.sharedSecretFromKeyAgreement(with: agreementPublicKey)
        return sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self,
            salt: "agreement".utf8Data,
            sharedInfo: Data(),
            outputByteCount: 32
        ).withUnsafeBytes {
            Data($0)
        }
    }
}
