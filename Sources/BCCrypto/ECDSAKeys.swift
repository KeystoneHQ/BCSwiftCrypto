import Foundation
import BCWally

public extension Crypto {
    static let privateKeyLenECDSA = 32
    static let publicKeyLenECDSA = 33
    static let publicKeyUncompressedLenECDSA = 65
    
    static func newPrivateKeyECDSA() -> Data {
        var rng = SecureRandomNumberGenerator()
        return newPrivateKeyECDSA(using: &rng)
    }
    
    static func newPrivateKeyECDSA<T>(using rng: inout T) -> Data
        where T: RandomNumberGenerator
    {
        return rng.randomData(32)
    }
    
    static func publicKeyFromPrivateKeyECDSA<D: DataProtocol>(privateKey: D) -> Data {
        Wally.ecPublicKeyFromPrivateKey(data: Data(privateKey))
    }
    
    static func decompressPublicKeyECDSA<D: DataProtocol>(compressedPublicKey: D) -> Data {
        Wally.ecPublicKeyDecompress(data: Data(compressedPublicKey))
    }
    
    static func compressPublicKeyECDSA<D: DataProtocol>(uncompressedPublicKey: D) -> Data {
        let data = Data(uncompressedPublicKey)
        precondition(data.count == 65)
        precondition(data[0] == 0x04)

        let x = data[1...32]
        let y = data[33...64]

        if y.last! % 2 == 0 {
            return Data([0x02]) + x
        } else {
            return Data([0x03]) + x
        }
    }
    
    static func derivePrivateKeyECDSA<D: DataProtocol>(keyMaterial: D) -> Data {
        hkdfHMACSHA256(keyMaterial: keyMaterial, salt: "signing".utf8Data, keyLen: 32)
    }
    
    static func xOnlyPublicKeyFromPrivateKeyECDSA<D: DataProtocol>(privateKey: D) -> Data {
        let kp = LibSecP256K1.keyPair(from: Data(privateKey))!
        let x = LibSecP256K1.xOnlyPublicKey(from: kp)
        return LibSecP256K1.serialize(key: x)
    }
}
