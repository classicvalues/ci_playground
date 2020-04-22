#!/bin/sh

# Usage:
# LLVM_OS: LLVM OS release to obtain clang binaries. Only needed for clang install.
# PACKAGES: Compiler packages to install.

set -e
echo ">>>>>"
echo ">>>>> APT: REPO.."
echo ">>>>>"
sudo -E apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
if test -n "${LLVM_OS}" ; then
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
	sudo -E apt-add-repository "deb http://apt.llvm.org/${LLVM_OS}/ llvm-toolchain-${LLVM_OS} main"
fi
echo ">>>>>"
echo ">>>>> APT: UPDATE.."
echo ">>>>>"
sudo -E apt-get update
echo ">>>>>"
echo ">>>>> APT: INSTALL ${PACKAGES}.."
echo ">>>>>"
sudo -E apt-get -yq --no-install-suggests --no-install-recommends install ${PACKAGES}

# Use, modification, and distribution are
# subject to the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#
# Copyright Rene Rivera 2020.
