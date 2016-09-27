Pod::Spec.new do |s|

  s.name         = "SwiftAssociatedObjects"
  s.module_name  = "AssociatedObjects"
  s.version      = "0.1.2"

  s.summary      = "Associated objects (and values) in pure Swift 3"
  s.description  = <<-DESC
    Allows associating an object or value onto any object instance using a key.
    Associations are maintained for the lifetime of the object that owns them.
                   DESC

  s.homepage     = "https://github.com/j-h-a/AssociatedObjects"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Jay Abbott"

  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/j-h-a/AssociatedObjects.git",
                     :tag => s.version.to_s }

  s.source_files  = "AssociatedObjects"
end
