Pod::Spec.new do |spec|
  spec.name         = "SSKR"
  spec.version      = "0.1.1"
  spec.summary      = "Sharded Secret Key Reconstruction (SSKR) reference library in C"
  spec.homepage     = "https://github.com/KeystoneHQ/BCSwiftCrypto"
  spec.license      = { :type => "BSD", :file => "LICENSE" }
  spec.author       = "Keystone"
  spec.social_media_url   = "https://twitter.com/KeystoneWallet"
  spec.swift_version = "5.6"
  spec.platform = :ios, '14.0'
  spec.source       = { :http => "https://github.com/KeystoneHQ/BCSwiftCrypto/releases/download/0.8.2/SSKR-0.1.1.zip", :type => "zip" }
  spec.ios.vendored_frameworks = 'SSKR.xcframework'
end
