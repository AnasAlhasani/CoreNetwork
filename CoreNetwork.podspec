Pod::Spec.new do |s|
  s.name         = 'CoreNetwork'
  s.version      = '1.0.2'
  s.summary      = 'Protocol oriented networking layer on top of Alamofire'

  s.homepage     = 'https://github.com/AnasAlhasani/CoreNetwork'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = 'Anas Alhasani'
  s.source       = { :git => 'https://github.com/AnasAlhasani/CoreNetwork.git', :tag => 'v' + s.version.to_s }
  s.social_media_url = 'https://twitter.com/AlhasaniAnas'

  s.ios.deployment_target = '10.0'
  s.watchos.deployment_target = '4.0'
  s.swift_version = '4.2'

  s.source_files = '**/*.{m,h,mm,hpp,cpp,c,swift,png,jpg}'
  
  s.frameworks   = 'Foundation'
  s.dependency     'Alamofire'
  s.dependency     'PromisesSwift'
end
