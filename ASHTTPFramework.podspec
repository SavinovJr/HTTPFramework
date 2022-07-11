#
#  Be sure to run `pod spec lint ASHTTPFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name          = 'ASHTTPFramework'
  spec.version       = '0.3'
  spec.summary       = 'HTTPFramework based on Combine'
  spec.description   = 'ASHTTPFramework is HTTP framework that provides great functionality to interact with HTTP protocol using Apple Combine framework'
  spec.homepage      = 'https://github.com/SavinovJr/HTTPFramework'
  spec.license       = { :type => 'MIT', 
                         :file => 'MIT License' }
  spec.author        = { 'Anton Savinov' => 'anton-savinov@mail.ru' }
  spec.platform      = :ios, '13.0'
  spec.source        = { :git => 'https://github.com/SavinovJr/HTTPFramework.git', 
                         :tag => spec.version.to_s }
  spec.source_files  = 'HTTPFramework/**/*.{swift}'
  spec.swift_version = '5.3' 
  spec.dependency      'SwiftLint'

end
