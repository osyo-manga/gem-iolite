# frozen_string_literal: true

require_relative "lib/iolite/version"

Gem::Specification.new do |spec|
  spec.name = "iolite"
  spec.version = Iolite::VERSION
  spec.authors = ["manga_osyo"]
  spec.email = ["manga.osyo@gmail.com"]

  spec.summary = "unblockable library"
  spec.description = "unblockable library"
  spec.homepage = "https://github.com/osyo-manga/gem-iolite"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/osyo-manga/gem-iolite"
  spec.metadata["changelog_uri"] = "https://github.com/osyo-manga/gem-iolite"

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
