#
# Be sure to run `pod lib lint MockServer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MockServer"
  s.version          = "0.1.0"
  s.summary          = "An embedded server that captures app web traffic for validation."

s.description  = <<-DESC
                  MockServer is an HTTP server that can be embedded inside an application. It
                  captures all traffic sent to it, allowing each payload to be inspected for correctness.
                  A primary use case is redirecting the apps traffic to MockServer during tests. This
                  allows the network requests to be validated, and allows the real server to be mocked out
                  for testing.
                   DESC

  s.homepage     = "http://www.localytics.com"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author           = { "Char Software, Inc. d/b/a Localytics" => "support@localytics.com" }
  s.ios.deployment_target = '8.0'

  s.source           = { :git => "https://github.com/localytics/mock-server-ios.git", :tag => s.version.to_s }

  s.source_files = 'MockServer/Classes/**/*'
  s.public_header_files = "MockServer/MockServer.h" "MockServer/Classes/LLMockServer.h", "MockServer/Classes/HTTPMessage+Parsing.h"

  s.user_target_xcconfig = { "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES" }
  s.dependency "CocoaHTTPServer", "~> 2.3"
end
