Pod::Spec.new do |spec|
  spec.name         = "BCWally"
  spec.version      = "0.1.1"
  spec.summary      = "Thin Swift wrapper around LibWally."
  spec.homepage     = "https://github.com/KeystoneHQ/BCSwiftCrypto"
  spec.license      = { :type => "BSD", :text => "Copyright © 2019 Blockchain Commons, LLC" }
  spec.author       = "Keystone"
  spec.social_media_url   = "https://twitter.com/KeystoneWallet"
  spec.swift_version = "5.6"
  spec.platform = :ios, '14.0'
  spec.source       = { :http => "https://github.com/KeystoneHQ/BCSwiftCrypto/releases/download/0.8.2/BCWally-0.1.1.zip", :type => "zip" }
  spec.ios.vendored_frameworks = 'BCWally.xcframework'
end
