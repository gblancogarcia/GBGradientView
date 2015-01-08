#
# Be sure to run `pod lib lint GBGradientView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GBGradientView"
  s.version          = "0.1.1"
  s.summary          = "GBGradientView class provides an animated gradient view."
  s.homepage         = "https://github.com/gblancogarcia"
  s.screenshots     = "https://camo.githubusercontent.com/62f58d641cd90ceedaed3454d27941f446504a0d/68747470733a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f752f353335393130352f47424772616469656e74566965772f47424772616469656e74566965772e676966"
  s.license          = 'MIT'
  s.author           = { "Gerardo Blanco" => "gblancogarcia@hotmail.com" }
  s.source           = { :git => "https://github.com/gblancogarcia/GBGradientView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/gblancogarcia'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'GBGradientView' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
