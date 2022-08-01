# Uncomment the next line to define a global platform for your project
platform :ios, '15.5'

is_running_in_renovate = ENV['HOME'] == '/home/ubuntu'
if is_running_in_renovate
  # Renovateでの実行時にはXcodeGenが実行できず、xcodeprojが存在しないので `:integrate_targets => false` とする。
  install! 'cocoapods', :integrate_targets => false
else
  install! 'cocoapods'
end

target 'Renovate-iOS-sample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Renovateを実行するためSwiftバージョンを指定する
  # https://github.com/CocoaPods/CocoaPods/issues/8653#issuecomment-488767262
  current_target_definition.swift_version = '5.6.1'

  # Pods for Renovate-iOS-sample
  pod 'SwiftLint', '~> 0.48.0'
  pod 'RxSwift', '~> 6'
  pod 'RxCocoa', '~> 6'
  pod 'Alamofire', '~> 5.6.0'
  pod 'SwiftGen', '~> 6.0'
  pod 'Nimble', '~> 9.0'
end
