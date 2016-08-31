Gem::Specification.new do |s|

  s.name        = 'refresher'
  s.version     = '0.1.2'
  s.date        = '2016-08-31'
  s.summary     = "db-refresher"
  s.description = "Fast database prototyping with Rails"
  s.authors     = ["Mufid Afif"]
  s.email       = 'mufid@outlook.com'
  s.files       = [
    'refresher.gemspec',
  ].concat( Dir.glob('lib/**/*').reject {|f| File.directory?(f) || f =~ /~$/ } )
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage    = 'https://github.com/mufid/refresher'
  s.license     = 'MIT'
end
