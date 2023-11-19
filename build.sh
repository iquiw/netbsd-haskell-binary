#! /bin/sh

set -euo pipefail

package=$1
binary=$2
ghc_version=$(ghc --numeric-version)

cabal unpack "${package}"
cd "${package}"
cabal new-build

mkdir "$package"

cp "dist-newstyle/build/x86_64-netbsd/ghc-${ghc_version}/${package}/x/${binary}/build/${binary}/${binary}" "${package}"
if [ -f LICENSE ]; then
        cp LICENSE "${package}"
fi
tar czf "../${package}.tar.gz" "${package}"

cd ..
rm -rf "${package}"
