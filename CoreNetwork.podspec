Pod::Spec.new do |s|
  s.name         = 'CoreNetwork'
  s.version      = '1.0.0'
  s.summary      = 'Protocol oriented networking layer on top of Alamofire'

  s.homepage     = 'https://github.com/AnasAlhasani/CoreNetwork'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Anas Alhasani'
  s.social_media_url = 'https://twitter.com/AlhasaniAnas'

  s.ios.deployment_target = '10.0'
  s.source       = { :git => 'https://github.com/AnasAlhasani/CoreNetwork.git', :tag => s.version.to_s }
  
  s.source_files = '**/*.{m,h,mm,hpp,cpp,c,swift,png,jpg}'
  
  s.frameworks   = 'Foundation'
  s.dependency 'Alamofire'
  s.swift_version = '4.2'
end