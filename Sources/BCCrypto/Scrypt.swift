import Foundation
import CryptoSwift

public func scrypt<D1, D2>(password: D1, salt: D2, dkLen: Int, n: Int, r: Int, p: Int) -> Data
where D1: DataProtocol, D2: DataProtocol
{
    try! Data(Scrypt(password: Array<UInt8>(password), salt: Array<UInt8>(salt), dkLen: dkLen, N: n, r: r, p: p).calculate())
}
