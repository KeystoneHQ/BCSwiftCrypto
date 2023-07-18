Pod::Spec.new do |spec|
  spec.name         = "SSKR"
  spec.version      = "0.1.0"
  spec.summary      = "Sharded Secret Key Reconstruction (SSKR) reference library in C"
  spec.homepage     = "https://github.com/KeystoneHQ/BCSwiftCrypto"
  spec.license      = { :type => "BSD", :file => "LICENSE" }
  spec.author       = "Keystone"
  spec.social_media_url   = "https://twitter.com/KeystoneWallet"
  spec.swift_version = "5.6"
  spec.platform = :ios, '14.0'
  spec.source       = { :http => "https://github.com/KeystoneHQ/BCSwiftCrypto/raw/master/Frameworks/SSKR-0.1.0.zip", :type => "zip" }
  spec.ios.vendored_frameworks = 'SSKR.xcframework'
end
