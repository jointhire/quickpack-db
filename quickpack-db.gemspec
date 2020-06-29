# -*- encoding: utf-8 -*-
# stub: quickpack-db 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "quickpack-db".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "http://dummyserver.samubuc.co.jp" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Samubuc Co.,Ltd".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-05-20"
  s.description = "description".freeze
  s.email = ["info@samubuc.co.jp".freeze]
  s.files = [".gitignore".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/quickpack/db.rb".freeze, "lib/quickpack/db/base.rb".freeze, "lib/quickpack/db/dual.rb".freeze, "lib/quickpack/db/general.rb".freeze, "lib/quickpack/db/mysql2.rb".freeze, "lib/quickpack/db/oracle.rb".freeze, "lib/quickpack/db/quickpack_activerecord_sample.rb".freeze, "lib/quickpack/db/quickpack_two_way_sql.rb".freeze, "lib/quickpack/db/schema_migrations.rb".freeze, "lib/quickpack/db/version.rb".freeze, "quickpack-db.gemspec".freeze]
  s.homepage = "http://www.samubuc.co.jp".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "summary".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
