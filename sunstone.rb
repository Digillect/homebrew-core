class Sunstone < Formula
  desc "Declarative language for Kubernetes resource manifests and Helm charts"
  homepage "https://github.com/digillect/sunstone"
  url "https://github.com/digillect/sunstone/archive/v0.6.1.tar.gz"
  sha256 "e4d7d10e2330e3b5c1ed977ba10f36a3cbc61a02f74c1bee48c924bfe0f2a20d"

  head "https://github.com/digillect/sunstone.git"

  depends_on "ruby" => :build if MacOS.version <= :sierra

  def install
    (buildpath/"sunstone").write <<~EOS
      #!/bin/sh

      export BUNDLE_GEMFILE="#{libexec}/Gemfile"
      
      /usr/bin/env ruby "#{libexec}/sunstone.rb" $*
    EOS
    
    ENV["GEM_HOME"] = buildpath
    ENV["BUNDLE_PATH"] = buildpath
    ENV["BUNDLE_GEMFILE"] = buildpath/"Gemfile"

    system "gem", "install", "bundler"

    bundle = Dir["#{buildpath}/**/bundle"].last
    system bundle, "install", "--without", "development", "test"

    bin.install "sunstone"
    libexec.install Dir["lib/*"], "gems", "Gemfile", "Gemfile.lock"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test sunstone`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
