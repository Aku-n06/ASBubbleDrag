Pod::Spec.new do |s|
  s.name         = "ASBubbleDrag"
  s.version      = "1.0.0"
  s.summary      = "ASBubbleDrag"

  s.description  = <<-DESC
                   ASBubbleDrag.
                   DESC

  s.homepage     = "https://github.com/scamps88/ASBubbleDrag"
  s.license      = "MIT"
  s.author             = { "Alberto Scampini" => "alberto.scampini" }
  s.source       = { :git => "https://github.com/scamps88/ASBubbleDrag.git", :tag => "1.0.0" }
  s.platform     = :ios, '7.1'
  s.source_files  = "UIConcept/ASBubbleDrag", "UIConcept/ASBubbleDrag/*.swift"
  s.resources = "UIConcept/ASBubbleDrag/*.png"
  s.framework  = 'SystemConfiguration'
  s.requires_arc = true

end
