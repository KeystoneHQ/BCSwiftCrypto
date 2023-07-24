Pod::Spec.new do |spec|
  spec.name         = "SSKR"
  spec.version      = "0.2.0"
  spec.summary      = "Sharded Secret Key Reconstruction (SSKR) reference library in C"
  spec.homepage     = "https://github.com/KeystoneHQ/BCSwiftCrypto"
  spec.license      = { :type => "BSD", :text => "Copyright © 2019 Blockchain Commons, LLC" }
  spec.author       = "Keystone"
  spec.social_media_url   = "https://twitter.com/KeystoneWallet"
  spec.swift_version = "5.6"
  spec.platform = :ios, '13.0'
  spec.source       = { :http => "https://github.com/KeystoneHQ/BCSwiftCrypto/releases/download/0.9.0/SSKR-0.2.0.zip", :type => "zip" }
  spec.ios.vendored_frameworks = 'SSKR.xcframework'
end
