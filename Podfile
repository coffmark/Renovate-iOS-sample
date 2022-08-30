# Uncomment the next line to define a global platform for your project

is_running_in_renovate = ENV['HOME'] == '/home/ubuntu'

if is_running_in_renovate
  # Renovateでの実行時にはXcodeGenが実行できず、xcodeprojが存在しないので `:integrate_targets => false` とする。
  inhibit_all_warnings!
  install! 'cocoapods', :integrate_targets => false
else
  install! 'cocoapods'
end

platform :ios, '15.5'

target 'Renovate-iOS-sample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Renovateを実行するためSwiftバージョンを指定する
  # https://github.com/CocoaPods/CocoaPods/issues/8653#issuecomment-488767262
  # すでに定義されてあれば、必要なさそう
  current_target_definition.swift_version = '5.6.1'

  # Pods for Renovate-iOS-sample
  pod 'SwiftLint', '0.49.0'
  pod 'RxSwift', '~> 6'
  pod 'RxCocoa', '~> 6'
  pod 'Alamofire', '~> 5.6.0'
  pod 'SwiftGen', '~> 6.0'
  pod 'Nimble', '~> 10.0'
  pod 'Crossroad', '~> 4.0'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftyJSON', '~> 5.0'
  pod 'AFNetworking', '4.0.1'
  pod 'Charts', '~> 3.0'

  pod 'PrivateCocoaPodsProj', :git => "https://github.com/coffmark/PrivateCocoaPodsProj.git", :tag => "0.0.2"
end
