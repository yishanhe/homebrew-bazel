class BazelAT0260 < Formula
    desc "Fast, scalable, multi-language and extensible build system"
    homepage "https://bazel.build/"
    url "https://releases.bazel.build/0.26.0/release/bazel-0.26.0-installer-darwin-x86_64.sh", :using => :nounzip
    version "0.26.0"
    sha256 "57f46b9095667b344503d04cc22911192117edfbc48784ef82c1b8d8bb5552fa"

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
