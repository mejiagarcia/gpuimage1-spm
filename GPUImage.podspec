Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.3'
s.name = "GPUImage"
s.summary = "Private Disk Framework"
s.requires_arc = true
s.swift_version = "5.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Maria Paula Gomez" => "mariapaulagp@hotmail.com" }
s.homepage = "https://github.com/mejiagarcia/kooler-ios-gpuimage"
s.source = { :git => "https://github.com/mejiagarcia/kooler-ios-gpuimage", :tag => "#{s.version}", branch: "master"}
s.source_files = "Disk/Source/*/.{swift}"
#s.resources = "Disk/Source/*/.{json,png,jpeg,jpg,storyboard,xib,xcassets}"
end
