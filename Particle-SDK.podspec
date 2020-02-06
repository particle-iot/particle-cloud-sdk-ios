Pod::Spec.new do |s|
    s.name             = "Particle-SDK"
    s.version          = "1.0.3"
    s.summary          = "Particle iOS Cloud SDK for interacting with Particle powered devices"
    s.description      = <<-DESC
                        Particle iOS Cloud SDK Cocoapod library
                        The Particle iOS Cloud SDK enables iOS apps to interact with Particle-powered connected products via the Particle Cloud.
                        Library will enable your app to easily manage active user sessions to the Particle cloud, query for device's type, info, read and write data to and from all Particle devices (via exposed firmware variables and functions) as well as publish/subscribe device and cloud events.
                        DESC
    s.homepage         = "https://github.com/particle-iot/particle-cloud-sdk-ios"
    s.screenshots      = "https://github.com/particle-iot/particle-cloud-sdk-ios/raw/master/particle-mark.png"
    s.license          = 'Apache 2.0'
    s.author           = { "Particle" => "ido@particle.io" }
    s.source           = { :git => "https://github.com/particle-iot/particle-cloud-sdk-ios.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/particle'

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.public_header_files = 'ParticleSDK/*.h'
    s.source_files = 'ParticleSDK/*.h'

    s.subspec 'Helpers' do |ss|
        ss.source_files = 'ParticleSDK/Helpers/*.{h,m}'
        ss.dependency 'AFNetworking', '~> 3.0'
        ss.ios.frameworks = 'SystemConfiguration', 'Security'
    end

    s.subspec 'SDK' do |ss|
        ss.source_files = 'ParticleSDK/SDK/Particle*.{h,m}'
        ss.dependency 'AFNetworking', '~> 3.0'
        ss.dependency 'Particle-SDK/Helpers'
    end

end
