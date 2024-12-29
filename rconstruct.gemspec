# frozen_string_literal: true

require_relative "lib/rconstruct/version"

Gem::Specification.new do |spec|
  spec.name = "rconstruct"
  spec.version = Rconstruct::VERSION
  spec.authors = ["Adam Wead"]
  spec.email = ["awead@noreply.github.com"]

  spec.summary = "Draws stuff in Minecraft using rcon"
  spec.description = "Draws shapes of different sizes using the rcon connection to your Minecraft server"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rconrb", "~> 0.1"
end
