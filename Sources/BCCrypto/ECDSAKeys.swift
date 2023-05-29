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
    
    static func compressPublicKeyECDSA<D: DataProtocol>(decompressedPublicKey: D) -> Data {
        Wally.ecPublicKeyCompress(data: Data(decompressedPublicKey))
    }
    
    static func derivePrivateKeyECDSA<D: DataProtocol>(keyMaterial: D) -> Data {
        hkdfHMACSHA256(keyMaterial: keyMaterial, salt: "signing".utf8Data, keyLen: 32)
    }
}
