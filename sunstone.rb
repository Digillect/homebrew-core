class Sunstone < Formula
  desc "Declarative language for Kubernetes resource manifests and Helm charts"
  homepage "https://github.com/digillect/sunstone"
  url "https://github.com/digillect/sunstone/archive/v0.7.8.tar.gz"
  sha256 "97dec5f295c930a0f5c2200d84a9f788266694991c0329ecb796ccb5bbf832bb"

  head "https://github.com/digillect/sunstone.git"

  depends_on "ruby" => "3.0"

  def install
    (buildpath/"sunstone").write <<~EOS
      #!/bin/sh

      export BUNDLE_GEMFILE="#{libexec}/gems.rb"

      /usr/bin/env ruby "#{libexec}/sunstone.rb" $*
    EOS

    ENV["GEM_HOME"] = buildpath
    ENV["BUNDLE_PATH"] = buildpath
    ENV["BUNDLE_GEMFILE"] = buildpath/"gems.rb"

    system "gem", "install", "bundler"

    bundle = Dir["#{buildpath}/**/bundle"].last
    system bundle, "config", "set", "without", "development", "test"
    system bundle, "install"

    bin.install "sunstone"
    libexec.install Dir["lib"], "sunstone.rb", "gems", "gems.rb", "gems.locked"
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
