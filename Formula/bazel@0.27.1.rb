class BazelAT0271 < Formula
    desc "Fast, scalable, multi-language and extensible build system"
    homepage "https://bazel.build/"
    url "https://releases.bazel.build/0.27.1/release/bazel-0.27.1-installer-darwin-x86_64.sh", :using => :nounzip
    version "0.27.1"
    sha256 "d7fed137ea907fce95dce21b6255c18f9c82dc26e3dc9bc54c14522cda7bfb4d"

    bottle :unneeded

    def install
        chmod 0555, "bazel-#{version}-installer-darwin-x86_64.sh"
        system "./bazel-#{version}-installer-darwin-x86_64.sh", "--prefix=#{buildpath}"
        bin.install "lib/bazel/bin/bazel" => "bazel"
        bin.install "lib/bazel/bin/bazel-real" => "bazel-real"
        bash_completion.install "lib/bazel/bin/bazel-complete.bash"
        zsh_completion.install "lib/bazel/bin/_bazel"
    end


    test do
        touch testpath/"WORKSPACE"
        (testpath/"Main.java").write <<~EOS
          public class Main {
            public static void main(String... args) {
              System.out.println("Hello world!");
            }
          }
        EOS
        (testpath/"BUILD").write <<~EOS
          java_binary(
            name = "main",
            srcs = ["Main.java"],
            main_class = "Main",
          )
        EOS
        system bin/"bazel", "build", "//:main"
        system "bazel-bin/main"
    end
end
