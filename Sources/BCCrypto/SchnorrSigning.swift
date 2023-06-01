import Foundation

public func schnorrSign<D1, D2, D3, T>(ecdsaPrivateKey: D1, message: D2, tag: D3, rng: inout T) -> Data
where D1: DataProtocol, D2: DataProtocol, D3: DataProtocol, T: RandomNumberGenerator
{
    let kp = LibSecP256K1.keyPair(from: Data(ecdsaPrivateKey))!
    return LibSecP256K1.schnorrSign(msg: Data(message), tag: Data(tag), keyPair: kp, rng: &rng)
}

public func schnorrVerify<D1, D2, D3, D4>(schnorrPublicKey: D1, signature: D2, message: D3, tag: D4) -> Bool
where D1: DataProtocol, D2: DataProtocol, D3: DataProtocol, D4: DataProtocol
{
    let publicKey = LibSecP256K1.schnorrPublicKey(from: Data(schnorrPublicKey))!
    return LibSecP256K1.schnorrVerify(msg: Data(message), tag: Data(tag), signature: Data(signature), publicKey: publicKey)
}
