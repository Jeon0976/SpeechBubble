#
# Be sure to run `pod lib lint SpeechBubble.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpeechBubble'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SpeechBubble.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  SpeechBubble is a versatile iOS View class that efficiently integrates both an arrow view and a label view. It allows for customizable speech bubble components in your iOS applications, enhancing user interface and experience by providing visually appealing, context-specific user interaction elements.

DESC

  s.homepage         = 'https://github.com/Jeon0976/SpeechBubble'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jeon0976' => 'jsh097610@gmail.com' }
  s.source           = { :git => 'https://github.com/Jeon0976/SpeechBubble.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'SpeechBubble/Classes/**/*'
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'SpeechBubble' => ['SpeechBubble/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
