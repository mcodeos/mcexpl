#!/usr/bin/env bash
# Build the public documentation site -- the BP16 product.
#
# The site is the product, and its build number is part of its
# coordinate.  The version face of this repository is one file
# (`VERSION`), holding the version alone; the batch number is an
# environment fact, never a constant, so the build refuses to run
# without it -- a site that carries no build number cannot pass the
# release gate later on.
#
#   MCC_BUILD_NR=<batch> scripts/release/build-site.sh
#
# The archive name carries the number (`mcexpl-<version>.b<batch>.tar.gz`),
# and the site carries it too: every page shows the build number, and
# the build record travels beside the files.
set -euo pipefail

here=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
root=$(CDPATH= cd -- "$here/../.." && pwd)
cd "$root"

die() { echo "build-site: $*" >&2; exit 1; }

: "${MCC_BUILD_NR:?the batch number must be given: MCC_BUILD_NR}"

# The batch number is written in two shapes in this workspace: bare
# (`8236`) and prefixed (`b8236`).  The coordinate on the product is
# always the bare one -- `.b8236` -- so the prefix is stripped here.
batch="${MCC_BUILD_NR#b}"
case "$batch" in
  ''|*[!0-9]*) die "the batch number is not a number: $MCC_BUILD_NR" ;;
esac

# The version face: one file, at the root of the repository.
[ -f VERSION ] || die "the version face is missing: VERSION"
version=$(tr -d '[:space:]' < VERSION)
[ -n "$version" ] || die "the site carries no version"

# The build number: the version and the batch, in one string.  It is the
# product's own word on which build it is -- the coordinate of the
# release is carried by the batch alone.
build="$version.b$batch"

stage="build/release/stage"
out="build/release/dist"
# The stage is scratch: it starts empty, so an archive never carries a
# file that this run did not put there.
rm -rf "$stage"
mkdir -p "$stage/site" "$out"

# The site is built with the number injected: the VitePress config reads
# it from the environment and puts it on every page.
export MCC_BUILD_NR="$batch"
export MCEXPL_BUILD="$build"

pnpm install --frozen-lockfile
pnpm docs:build

dist="docs/.vitepress/dist"
[ -d "$dist" ] || die "the site did not build: $dist is not there"

cp -R "$dist/." "$stage/site/"

# The build record travels inside the product: a site that carries it
# says which build it is, without asking anybody.
cat > "$stage/site/build-info.json" <<JSON
{
  "name": "mcexpl",
  "version": "$version",
  "batch": $batch,
  "build": "$build"
}
JSON

# The checksum of every file travels inside the archive: the receiver
# checks them before serving anything.
(cd "$stage" && find . -type f ! -name SHA256SUMS -print0 \
  | LC_ALL=C sort -z \
  | xargs -0 shasum -a 256 > SHA256SUMS)

name="mcexpl-$version.b$batch"
# The archive carries the site and nothing else: no AppleDouble sidecars
# (they are the file system's own bookkeeping, not the product).
COPYFILE_DISABLE=1 tar -czf "$out/$name.tar.gz" -C "$stage" .
artifact="$out/$name.tar.gz"
rm -rf "$stage"

# The digest of the archive itself travels beside it: a receiver checks
# the download against this file before unpacking it.
(cd "$out" && shasum -a 256 "$(basename "$artifact")" > SHA256SUMS)

echo "build-site: $artifact"
