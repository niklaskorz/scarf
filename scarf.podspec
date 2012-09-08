Pod::Spec.new do |s|
    s.name          = 'Scarf'
    s.version       = '0.1'
    s.license       = 'https://raw.github.com/dindresto/scarf/master/LICENSE'
    s.summary       = ''
    s.homepage      = 'https://github.com/dindresto/scarf'
    s.author        = {
        'Niklas Korz' => 'korz.niklask@gmail.com'
    }
    s.source        = {
        :git => 'https://github.com/dindresto/scarf.git',
        :tag => '0.1'
    }
    s.source_files  = 'Scarf'
    s.requires_arc  = true
    s.dependency      'CocoaAsyncSocket'
    s.dependency      'CocoaLumberjack'
end
