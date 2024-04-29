#
# Be sure to run `pod lib lint SpeechBubble.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpeechBubble'
  s.version          = '0.1.3'
  s.summary       = "An iOS View class for displaying speech bubbles with customizable arrows and text labels."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description  = <<-DESC
                     SpeechBubble is an iOS View class that enables the easy creation of customizable speech bubbles with arrows and labels. It supports extensive customization options including colors, fonts, and arrow positioning.
                    DESC

  s.homepage         = 'https://github.com/Jeon0976/SpeechBubble'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jeon0976' => 'jsh097610@gmail.com' }
  s.source           = { :git => 'https://github.com/Jeon0976/SpeechBubble.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/SpeechBubble/Classes/**/*'
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'SpeechBubble' => ['SpeechBubble/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
