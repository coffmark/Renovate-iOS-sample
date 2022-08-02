# Uncomment the next line to define a global platform for your project

is_running_in_renovate = ENV['HOME'] == '/home/ubuntu' && ENV["CP_HOME_DIR"] == "/tmp/renovate-cache/others/cocoapods"

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
  pod 'SwiftLint', '~> 0.48.0'
  pod 'RxSwift', '~> 6'
  pod 'RxCocoa', '~> 5'
  pod 'Alamofire', '~> 5.6.0'
  pod 'SwiftGen', '~> 4.0'
  pod 'Nimble', '~> 10.0'
  pod 'Crossroad', '~> 4.0'
  pod 'SDWebImage', '~> 4.0'
end
