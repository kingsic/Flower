#
#  Be sure to run `pod spec lint SGFastfish.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name         = 'SGFastfish'
    s.version      = '1.0.0'
    s.summary      = 'Custom View'
    s.homepage     = 'https://github.com/kingsic/SGFastfish'
    s.license      = 'MIT'
    s.authors      = {'kingsic' => 'kingsic@126.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/kingsic/SGFastfish.git', :tag => s.version}
    s.source_files = 'SGFastfish/**/*.{h,m}'
    s.requires_arc = true
end
