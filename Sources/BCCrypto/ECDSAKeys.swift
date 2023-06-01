import Foundation
import BCWally

public extension Crypto {
    static let ecdsaPrivateKeySize = 32
    static let ecdsaPublicKeySize = 33
    static let ecdsaPublicKeyUncompressedSize = 65
    
    static func ecdsaNewPrivateKey() -> Data {
        var rng = SecureRandomNumberGenerator()
        return ecdsaNewPrivateKey(using: &rng)
    }
    
    static func ecdsaNewPrivateKey<T>(using rng: inout T) -> Data
        where T: RandomNumberGenerator
    {
        return rng.randomData(32)
    }
    
    static func ecdsaPublicKeyFromPrivateKey<D: DataProtocol>(privateKey: D) -> Data {
        Wally.ecPublicKeyFromPrivateKey(data: Data(privateKey))
    }
    
    static func ecdsaDecompressPublicKey<D: DataProtocol>(compressedPublicKey: D) -> Data {
        Wally.ecPublicKeyDecompress(data: Data(compressedPublicKey))
    }
    
    static func ecdsaCompressPublicKey<D: DataProtocol>(uncompressedPublicKey: D) -> Data {
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
    
    static func ecdsaDerivePrivateKey<D: DataProtocol>(keyMaterial: D) -> Data {
        hkdfHMACSHA256(keyMaterial: keyMaterial, salt: "signing".utf8Data, keyLen: 32)
    }
    
    static func schnorrPublicKeyFromPrivateKey<D: DataProtocol>(privateKey: D) -> Data {
        let kp = LibSecP256K1.keyPair(from: Data(privateKey))!
        let x = LibSecP256K1.schnorrPublicKey(from: kp)
        return LibSecP256K1.serialize(key: x)
    }
}
