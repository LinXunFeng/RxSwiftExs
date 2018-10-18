#
# Be sure to run `pod lib lint RxSwiftExs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxSwiftExs'
  s.version          = '0.1.0'
  s.summary          = 'A collection of Rx tools'
  s.homepage         = 'https://github.com/LinXunFeng/RxSwiftExs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinXunFeng' => '598600855@qq.com' }
  s.source           = { :git => 'https://github.com/LinXunFeng/RxSwiftExs.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = "Core"
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.swift_version = '4.0'

#s.source_files = 'RxSwiftExs/Classes/**/*'
  
  s.subspec 'Core' do |ss|
      ss.source_files = 'RxSwiftExs/Classes/RxCocoa/', 'RxSwiftExs/Classes/Tools/'
  end
  
end
