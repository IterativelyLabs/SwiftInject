#
#  Be sure to run `pod spec lint SwiftInject.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SwiftInject"
  s.version      = "1.1.0"
  s.summary      = "A lightweight dependency injection for Swift projects."
  s.description  = <<-DESC
  A straight-forward and lightweight approach to providing dependency injection for Swift based projects.
                   DESC

  s.homepage     = "https://github.com/IterativelyLabs/SwiftInject"
  s.license      = { :type => "GNU GPL 3.0", :file => "LICENSE" }
  s.author             = "IterativelyLabs"
  s.social_media_url   = "https://twitter.com/iterativelyltd"

  s.source       = { :git => "https://github.com/IterativelyLabs/SwiftInject.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/SwiftInject/*.swift"

  s.swift_version = '5.1'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '11.0'
end
