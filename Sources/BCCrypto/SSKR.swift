import Foundation
import SSKR

extension Crypto {
    public static func splitSSKR<D: DataProtocol>(groupThreshold: Int, groups: [(Int, Int)], secret: D, testRandomGenerator: @escaping RandomGenerator = Self.randomData) throws -> [[SSKRShare]] {
        try SSKRGenerate(groupThreshold: groupThreshold, groups: sskrGroups(groups), secret: Data(secret), randomGenerator: testRandomGenerator)
    }
    
    public static func combineSSKR(shares: [SSKRShare]) throws -> Data {
        try SSKRCombine(shares: shares)
    }

    public static func countSharesSSKR(groupThreshold: Int, groups: [(Int, Int)]) throws -> Int {
        try SSKRCountShares(groupThreshold: groupThreshold, groups: sskrGroups(groups))
    }
    
    private static func sskrGroups(_ groups: [(Int, Int)]) -> [SSKRGroupDescriptor] {
        groups.map {
            let threshold = $0.0
            precondition((1...16).contains(threshold))
            let count = $0.1
            precondition((1...16).contains(count))
            return SSKRGroupDescriptor(threshold: UInt8(threshold), count: UInt8(count))
        }
    }
}

public extension SSKRShare {
    var identifier: UInt16 {
        (UInt16(data[0]) << 8) | UInt16(data[1])
    }
    
    var identifierHex: String {
        Data(data[0...1]).hex
    }

    var groupThreshold: Int {
        Int(data[2] >> 4) + 1
    }
    
    var groupCount: Int {
        Int(data[2] & 0xf) + 1
    }
    
    var groupIndex: Int {
        Int(data[3]) >> 4
    }
    
    var memberThreshold: Int {
        Int(data[3] & 0xf) + 1
    }
    
    var memberIndex: Int {
        Int(data[4] & 0xf)
    }
    
    static func ==(lhs: SSKRShare, rhs: SSKRShare) -> Bool {
        lhs.data == rhs.data
    }
}

extension SSKRShare: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
}
