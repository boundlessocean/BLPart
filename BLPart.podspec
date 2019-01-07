#
# Be sure to run `pod lib lint BLPrat.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BLPart'
    s.version          = '1.1.10'
    s.summary          = 'A short description of BLPrat.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/boundlessocean/BLPart'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'fuhaiyang' => 'fuhaiyang@xycentury.com' }
    s.source           = { :git => 'https://github.com/boundlessocean/BLPart.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.subspec 'BLBannerView' do |ss|
        ss.source_files = 'BLPart/Classes/BLBannerView/**/*'
        ss.dependency 'AFNetworking'
        ss.dependency 'Masonry'
    end
    
    s.subspec 'BLHTTPClient' do |ss|
        ss.source_files = 'BLPart/Classes/BLHTTPClient/**/*'
        ss.dependency 'AFNetworking'
    end
    
    s.subspec 'BLHUDManager' do |ss|
        ss.source_files = 'BLPart/Classes/BLHUDManager/**/*'
        ss.dependency 'MBProgressHUD'
    end
    
    s.subspec 'BLIAPManager' do |ss|
        ss.source_files = 'BLPart/Classes/BLIAPManager/**/*'
    end
    
    s.subspec 'BLImagePickerController' do |ss|
        ss.source_files = 'BLPart/Classes/BLImagePickerController/**/*'
    end
    
    s.subspec 'BLSliderViewController' do |ss|
        ss.source_files = 'BLPart/Classes/BLSliderViewController/**/*'
    end
    
    
    # s.resource_bundles = {
    #   'BLPrat' => ['BLPrat/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
