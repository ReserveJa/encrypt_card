#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint encrypt_card.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'encrypt_card'
  s.version          = '0.0.7'
  s.summary          = 'An Adyen Flutter plugin to support the Adyen API integration inspired in adyen_flutter https://github.com/lab-box/adyen_flutter.'
  s.description      = <<-DESC
  An Adyen Flutter plugin to support the Adyen API integration inspired in adyen_flutter https://github.com/lab-box/adyen_flutter.
                       DESC
  s.homepage         = 'https://github.com/RubenSolAlva/encrypt_card'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'RubenSolAlva'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Adyen/Card', '~> 3.8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.3'
end
