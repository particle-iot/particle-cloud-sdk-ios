source 'https://cdn.cocoapods.org/'


platform :ios, '8.0'

target 'ParticleSDKPods' do
    pod 'AFNetworking'

    target 'ParticleSDKTests' do
        pod 'OHHTTPStubs/Swift'
    end
end


post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
    end
end