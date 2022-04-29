# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

def shared_pods
    pod 'Alamofire'
    pod 'RealmSwift'
    pod 'SwiftyJSON'
    pod 'Toast-Swift'
    pod 'Reachability'
end

target 'ZemogaTest' do
  # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
  # Pods for Test
    shared_pods
end

target 'ZemogaTestTests' do
    use_frameworks!
  # Pods for Testing
    shared_pods
end

target 'ZemogaTestUITests' do
    use_frameworks!
  # Pods for Testing
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # This works around a unit test issue introduced in Xcode 10.
            # We only apply it to the Debug configuration to avoid bloating the app size
            if config.name == "Debug" && defined?(target.product_type) && target.product_type == "com.apple.product-type.framework"
                config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = "YES"
            end
            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"
        end
    end
end
