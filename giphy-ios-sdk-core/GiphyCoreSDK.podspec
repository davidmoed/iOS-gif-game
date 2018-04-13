Pod::Spec.new do |s|
    s.name = 'GiphyCoreSDK'
    s.module_name = 'GiphyCoreSDK'
    s.version = '1.2.0'
    s.license = 'Mozilla Public License v2'
    s.summary = 'Giphy API wrapper for iOS, tvOS, watchOS & OS X.'
    s.homepage = 'https://github.com/Giphy/giphy-ios-sdk-core'
    s.documentation_url = 'https://developers.giphy.com/'
    s.author   = { 'Giphy' => 'giphy@giphy.com' }
    s.source = { :git => 'https://github.com/Giphy/giphy-ios-sdk-core.git', :tag => s.version }
    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'
    s.tvos.deployment_target = '9.0'
    s.watchos.deployment_target = '2.0'

    s.source_files = [
        'Source/*.swift',
    ]
end
