Pod::Spec.new do |spec|
  spec.name         = "BCSwiftCrypto"
  spec.version      = "0.8.1"
  spec.summary      = "A Swift package that exposes a uniform API for the cryptographic primitives used in higher-level Blockchain Commons projects."
  spec.homepage     = "https://github.com/KeystoneHQ/BCSwiftCrypto"
  spec.license      = { :type => "BSD", :file => "LICENSE" }
  spec.author       = "Keystone"
  spec.social_media_url   = "https://twitter.com/KeystoneWallet"
  spec.swift_version = "5.6"
  spec.platform = :ios, '14.0'
  spec.source       = { :git => "https://github.com/KeystoneHQ/BCSwiftCrypto.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/BCCrypto/**/*.swift"
  spec.requires_arc = true
  spec.dependency "WolfBase", "~> 5.3.1"
  spec.dependency "CryptoSwift", "~> 1.7.1"
  spec.dependency "secp256k1SwiftLib", "~> 0.8.0"
  spec.dependency "BCWally", "~> 0.1.0"
  spec.dependency "CryptoBase", "~> 0.1.0"
  spec.dependency "SSKR", "~> 0.1.0"
end
