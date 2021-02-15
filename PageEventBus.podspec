#
#  Be sure to run `pod spec lint PageEventBus.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "PageEventBus"
  spec.version      = "0.0.1"
  spec.summary      = "An auto connected event bus with view model modular."

  spec.description  = <<-DESC
 An auto connected event bus with view model modular
                   DESC

  spec.homepage     = "http://github.com/lalawue/PageEventBus"
  spec.license      = "MIT"

  spec.author       = "lalawue"

  spec.source       = { :git => "http://github.com/lalawue/PageEventBus.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/*"
  spec.exclude_files = "Classes/Exclude"

  spec.ios.deployment_target = '9.0'
  spec.swift_version = '4.2'

end

