Pod::Spec.new do |s|
  s.name             = 'Texty'
  s.version          = '0.1.4'
  s.summary          = 'Enjoy clean and easy text styling using a simplified and structured syntax.'

  s.description      = <<-DESC
Enjoy clean and easy text styling using a simplified and structured syntax. Use things like
style containers, styled labels, and string styling via XML-like tags.
DESC

  s.homepage         = 'https://github.com/vectorform/Texty'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'Vectorform' => 'iefremov@vectorform.com' }
  s.source           = { :git => 'https://github.com/vectorform/Texty.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/vectorform'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'
end
