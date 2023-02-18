import XCTest
import BCCrypto
import WolfBase

final class HashTests: XCTestCase {
    func testSHA() {
        let input = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
        let digest256 = Crypto.sha256(input.utf8Data)
        XCTAssertEqual(digest256.hex, "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1")
        let digest512 = Crypto.sha512(input.utf8Data)
        XCTAssertEqual(digest512.hex, "204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445")
    }
    
    func testHMACSHA() {
        let key = ‡"0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"
        let message = "Hi There".utf8Data
        let hmac256 = Crypto.hmacSHA256(key: key, message: message)
        XCTAssertEqual(hmac256, ‡"b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7")
        let hmac512 = Crypto.hmacSHA512(key: key, message: message)
        XCTAssertEqual(hmac512, ‡"87aa7cdea5ef619d4ff0b4241a1d6cb02379f4e2ce4ec2787ad0b30545e17cdedaa833b7d6b8a702038b274eaea3f4e4be9d914eeb61f1702e696c203a126854")
    }
    
    func testPBKDF2HMACSHA256() {
        let key = Crypto.pbkdf2HMACSHA256(pass: "password".utf8Data, salt: "salt".utf8Data, iterations: 1, keyLen: 32)
        XCTAssertEqual(key, ‡"120fb6cffcf8b32c43e7225256c4f837a86548c92ccc35480805987cb70be17b")
    }
    
    func testHKDFHMACSHA256() {
        let message = "hello".utf8Data
        let salt = ‡"8e94ef805b93e683ff18"
        let key = Crypto.hkdfHMACSHA256(keyMaterial: message, salt: salt, keyLen: 32)
        XCTAssertEqual(key, ‡"13485067e21af17c0900f70d885f02593c0e61e46f86450e4a0201a54c14db76")
    }

    func testCRC32() {
        let input = "Hello, world!".utf8Data
        let checksum = Crypto.crc32(input)
        XCTAssertEqual(checksum, 0xebe6c6e6)
        XCTAssertEqual(Crypto.crc32data(input), ‡"ebe6c6e6")
        XCTAssertEqual(Crypto.crc32data(input, littleEndian: true), ‡"e6c6e6eb")
    }
}
