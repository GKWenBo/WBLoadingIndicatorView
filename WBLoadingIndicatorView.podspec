Pod::Spec.new do |s|
  s.name             = 'WBLoadingIndicatorView'
  s.version          = '1.1.0'
  s.summary          = '一组精美的加载等待动画'
  s.homepage         = 'https://github.com/wenmobo/WBLoadingIndicatorView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wenmobo' => '1050794513@qq.com' }
  s.source           = { :git => 'https://github.com/wenmobo/WBLoadingIndicatorView.git', :tag => s.version.to_s }
  s.social_media_url = 'http://blogwenbo.com/'
  s.ios.deployment_target = '8.0'
  s.source_files = 'WBLoadingIndicatorView/Classes/**/*'
  s.frameworks = 'UIKit', 'QuartzCore'
  s.requires_arc = true;
end
