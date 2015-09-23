Pod::Spec.new do |s|
  s.name = "LSAgent"
  s.version = "0.0.1"
  s.summary = "Objective-C port of TJ's wonderful superagent library"
  s.description  = <<-DESC
  DESC
  s.homepage = "https://github.com/littlstar/LSAgent"
  s.license = "MIT"
  s.author = {"Joseph Werle" => "werle@littlstar.com"}
  s.requires_arc = true
  s.source = {:git => "https://github.com/littlstar/LSAgent.git", :tag => s.version.to_s}
  s.source_files = "src/*.m"
  s.public_header_files = "include/*/*.h"
  s.preserve_paths = "include/*/*.h"
end
