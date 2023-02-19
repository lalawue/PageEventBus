#
#  Be sure to run `pod spec lint PageEventBus.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "PageEventBus"
  spec.version      = "0.1.20230219"
  spec.summary      = "Typed Event bus for View and ViewController."

  spec.description  = <<-DESC
An typed event bus modular system build for page internal data exchange, UI and business logic independent.
                   DESC

  spec.homepage     = "https://github.com/lalawue/PageEventBus"
  spec.license      = "MIT"

  spec.author       = "lalawue"

  spec.source       = { :git => "https://github.com/lalawue/PageEventBus.git", :tag => "#{spec.version}" }

  spec.source_files  = "PageEventBus/Classes/**/*"

  spec.ios.deployment_target = '9.0'
  spec.swift_version = '4.2'

end

