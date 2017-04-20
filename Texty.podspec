# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Texty'
  s.version          = '0.1.0'
  s.summary          = 'Texty is a POD whose goal is to make managing styles and annotated strings clean and easy.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Texty is a POD whose goal is to make managing styles and annotated strings clean and easy.  Texty Provides TextStyle that can be applied to TextyLabels or the tags contained within them. 
                       DESC

  s.homepage         = 'https://github.com/vectorform/Texty'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'Vectorform' => 'iefremov@vectorform.com' }
  s.source           = { :git => 'https://github.com/vectorform/Texty.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/**/*'
end
