import Foundation

public extension Crypto {
    static func signSchnorr<D1, D2, D3, T>(message: D1, tag: D2 = Data(), privateKeyECDSA key: D3, rng: inout T) -> Data
    where D1: DataProtocol, D2: DataProtocol, D3: DataProtocol, T: RandomNumberGenerator {
        let kp = LibSecP256K1.keyPair(from: Data(key))!
        return LibSecP256K1.schnorrSign(msg: Data(message), tag: Data(tag), keyPair: kp, rng: &rng)
    }
    
    static func verifySchnorr<D1, D2, D3, D4>(message: D1, tag: D2 = Data(), signature: D3, xOnlyPublicKeyECDSA publicKey: D4) -> Bool
    where D1: DataProtocol, D2: DataProtocol, D3: DataProtocol, D4: DataProtocol {
        let publicKey = LibSecP256K1.xOnlyPublicKey(from: Data(publicKey))!
        return LibSecP256K1.schnorrVerify(msg: Data(message), tag: Data(tag), signature: Data(signature), publicKey: publicKey)
    }
}
