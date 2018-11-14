Pod::Spec.new do |s|

  s.name         = "CoreNetwork"
  s.version      = "1.0.0"
  s.summary      = "Protocol oriented networking layer on top of Alamofire"
  s.homepage     = "https://github.com/AnasAlhasani"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Anas Alhasani" => "anasalhassni@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/AnasAlhasani/CoreNetwork.git" }
  s.source_files = '**/*.{m,h,mm,hpp,cpp,c,swift,png,jpg}'
  s.frameworks   = "Foundation"
  s.dependency 'Alamofire'

end
