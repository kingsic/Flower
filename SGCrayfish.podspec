#
#  Be sure to run `pod spec lint SGCrayfish.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name         = 'SGCrayfish'
    s.version      = '0.1.2'
    s.summary      = 'Custom View'
    s.homepage     = 'https://github.com/kingsic/SGCrayfish'
    s.license      = 'MIT'
    s.authors      = {'kingsic' => 'kingsic@126.com'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://github.com/kingsic/SGCrayfish.git', :tag => s.version}
    s.source_files = 'SGCrayfish/**/*.{h,m}'
    s.requires_arc = true
end
