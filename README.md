# homebrew-bazel
a tap for bazel with versions


## Usage

First, to uninstall or unlink the installed bazel from homebrew-core or bazelbuild/tap

- `brew unlink bazel` or `brew uninstall bazel`
- `brew untap bazelbuild/tap`

Then

- `brew tap yishanhe/bazel` to add this repo as a tap for homebrew.
- `brew update`
- `brew install bael@0.29.0`
- `brew install bael@0.28.1`

The bazel will be install at `/usr/local/Cellar` and symbol linked at `/usr/local/bin`

To switch bazel verions

- `brew unlink bazel@0.29.0`
- `brew link bazel@0.28.1`


## Repo Usage

to add more versions, update the `tools/versions` file, then run `toos/build.sh`
