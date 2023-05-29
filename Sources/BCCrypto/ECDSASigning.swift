import Foundation

public extension Crypto {
    static func signECDSA<D1, D2>(message: D1, privateKeyECDSA key: D2) -> Data
    where D1: DataProtocol, D2: DataProtocol {
        LibSecP256K1.ecdsaSign(message: Data(message), secKey: Data(key))
    }
    
    static func verifyECDSA<D1, D2, D3>(message: D1, signature: D2, publicKeyECDSA publicKey: D3) -> Bool
    where D1: DataProtocol, D2: DataProtocol, D3: DataProtocol {
        precondition(signature.count == 64)
        let signature = LibSecP256K1.ecdsaSignature(from: Data(signature))!
        let publicKey = LibSecP256K1.ecPublicKey(from: Data(publicKey))!
        return LibSecP256K1.ecdsaVerify(message: Data(message), signature: signature, publicKey: publicKey)
    }
}
