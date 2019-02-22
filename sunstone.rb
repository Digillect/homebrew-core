class Sunstone < Formula
  desc "Ruby-style DSL preprocessor for Kubernetes resource manifests"
  homepage "https://github.com/digillect/sunstone"
  url "https://github.com/digillect/sunstone/archive/v0.1.0.tar.gz"
  sha256 "0910b43d118b0eca2a5d4d05ee39b3a017f6632f10eecc4d6b3eb41576bd9730"

  head "https://github.com/digillect/sunstone.git"

  depends_on "ruby" => :build if MacOS.version <= :sierra

  def install
    inreplace "bin/sunstone", "../lib", "../libexec"

    ENV["GEM_HOME"] = buildpath
    ENV["BUNDLE_PATH"] = buildpath
    ENV["BUNDLE_GEMFILE"] = buildpath/"Gemfile"

    system "gem", "install", "bundler"

    bundle = Dir["#{buildpath}/**/bundle"].last
    system bundle, "install", "--without", "development", "test"

    bin.install "bin/sunstone"
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
