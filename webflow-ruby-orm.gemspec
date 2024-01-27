# frozen_string_literal: true

require_relative "lib/webflow/version"

Gem::Specification.new do |spec|
  spec.name = "webflow-ruby-orm"
  spec.version = Webflow::VERSION
  spec.authors = ["Pavel Titov"]
  spec.email = ["ptitov@gmail.com"]

  spec.summary = "ORM wrapper for the Webflow API."
  spec.homepage = "https://github.com/TitovDigital/webflow-ruby-orm"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3" # uses ActiveSupport inflectors

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
