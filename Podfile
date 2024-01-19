# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'SampleOfApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SkyFloatingLabelTextField'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'FirebaseFirestore'
  pod "FlagPhoneNumber"
  pod 'AEOTPTextField'
  pod 'MercariQRScanner'
  pod 'SwiftQRScanner', :git => ‘https://github.com/vinodiOS/SwiftQRScanner’
  pod 'BarcodeEasyScan'
  pod 'PhoneVerificationController'
  pod 'SVProgressHUD'
  pod 'SwiftyJSON'
  pod 'Alamofire', '4.9.0'
  pod 'AlamofireImage'
  pod 'AlamofireNetworkActivityIndicator'
  pod 'SwiftToast'
  pod 'Firebase/Crashlytics'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftyUserDefaults'
  pod 'XMLReader'
  pod 'Firebase/Database'
  pod 'SideMenu'
end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
