Pod::Spec.new do |s|
  s.name             = 'ASNet'
  s.version          = '1.0'
  s.summary          = 'A swift-baked networking library wrapped over NSURLSession thingy.'
 
  s.description      = <<-DESC
A Swift-Baked lightweight network library in addition with the json parsing facility with the help of ObjectMapper. It frees you from the stress of json parsing - Every API call returns you an object or an array of objects. Less Coding - More Efficiency. Happy coding.
                       DESC
 
  s.homepage         = 'https://github.com/ronstorm/ASNet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Amit Sen' => 'amit.ron.cse@gmail.com' }
  s.source           = { :git => 'https://github.com/ronstorm/ASNet.git', :tag => s.version.to_s }
 
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }
  s.ios.deployment_target = '11.0'
  s.source_files = 'Source/*.swift'
  
  s.dependency 'ObjectMapper'
 
end