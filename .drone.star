# Use, modification, and distribution are
# subject to the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#
# Copyright Rene Rivera 2020.

# Configuration for https://cloud.drone.io/.

def main(ctx):
  return [
    linux_cxx("GCC 9", "g++9", packages="g++-9"),
    linux_cxx("GCC 8", "g++8", packages="g++-8"),
  ]

# Generate pipeline for Linux platform compilers.
def linux_cxx(name, cxx, cxxflags="", packages="", llvm_repo="", arch="amd64"):
  return {
    "name": "Linux %s" % name,
    "kind": "pipeline",
    "type": "exec",
    "trigger": { "branch": [ "master" ] },
    "platform": {
      "os": "linux",
      "arch": arch
    },
    "environment": {
      "CXX": cxx,
      "CXXFLAGS": cxxflags,
      "PACKAGES": packages,
      "LLVM_REPO": llvm_repo
    },
    "steps": [
      {
        "name": "Install Toolset",
        "commands": [
          "uname -a",
          "./.ci_playground/linux-cxx-install.sh"
        ]
      },
      {
        "name": "Install Toolset",
        "commands": [
          "${CXX} --version",
          "${CXX} ${CXXFLAGS} -v src/main.cpp"
        ]
      }
    ]
  }