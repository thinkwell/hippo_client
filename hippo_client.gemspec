# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "hippo_client"
  s.version = "0.0.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brandon Turner"]
  s.date = "2012-01-27"
  s.description = "Ruby bindings for accessing Hippo"
  s.email = "brandont@thinkwell.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "hippo_client.gemspec",
    "lib/hippo_client.rb",
    "lib/hippo_client/client.rb",
    "lib/hippo_client/client/content.rb",
    "lib/hippo_client/client/course_trees.rb",
    "lib/hippo_client/client/courses.rb",
    "lib/hippo_client/client/products.rb",
    "lib/hippo_client/errors/hippo_error.rb",
    "lib/hippo_client/errors/network_error.rb",
    "lib/hippo_client/hash_initialize.rb",
    "lib/hippo_client/hydrate.rb",
    "lib/hippo_client/model/content.rb",
    "lib/hippo_client/model/course.rb",
    "lib/hippo_client/model/course_tree.rb",
    "lib/hippo_client/model/node.rb",
    "lib/hippo_client/model/product.rb",
    "lib/hippo_client/request.rb",
    "spec/cassettes/Thinkwell_Hippo_Client/content.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/contentView.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/course.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/course_tree.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/courses.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/product.yml",
    "spec/cassettes/Thinkwell_Hippo_Client/products.yml",
    "spec/hippo_client/client/content_spec.rb",
    "spec/hippo_client/client/course_trees_spec.rb",
    "spec/hippo_client/client/courses_spec.rb",
    "spec/hippo_client/client/products_spec.rb",
    "spec/hippo_client/client_spec.rb",
    "spec/hippo_client/model/course_tree_spec.rb",
    "spec/hippo_client_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/thinkwell/hippo_client"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Ruby bindings for accessing Hippo"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<john-hancock>, [">= 0.0.6"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.21"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<john-hancock>, [">= 0.0.6"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.7.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.21"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<john-hancock>, [">= 0.0.6"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.7.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.21"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end

