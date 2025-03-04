# Docker images for LMN-3-DAW compilers

<p align="center">
  <a href="https://github.com/iamdey/LMN-3-DAW-docker-compiler">GitHub Repo</a> |
  <a href="https://hub.docker.com/r/iamdey/lmn-3-daw-docker-compiler">Docker Hub</a>
</p>

This build the images in order to cross-compile on a X86_64 platform
[JUCE](https://juce.com/) projects (especially
https://github.com/FundamentalFrequency/LMN-3-DAW). This can be used on a host
without invasive dependencies or in a CI. The following containers will compile
binaries for those target plateforms:

| images                           | target arch | target os                         |
| -------------------------------- | ----------- | --------------------------------- |
| iamdey/lmn-3-daw_compiler:armv7  | armv7       | Raspberry Pi OS 32bits (bullseye) |
| iamdey/lmn-3-daw_compiler:arm64  | arm64       | Raspberry Pi OS 64bits (bullseye) |
| iamdey/lmn-3-daw_compiler:x86_64 | x86_64      | Ubuntu 64bits (22.04)             |

> Note: Target OS is an indication on which OS LMN-3 will run and the minimum
> version required of glibc dependency.

## How to build the images

According to the target of the LMN-3-DAW to build:

```bash
# install armv7 and arm64 plateforms and build base image
make prepare
# build the image of the compiler for armv7
make build_armv7
```

## Usage

According to the target and version of LMN-3-DAW:

```bash
cd LMN-3-DAW
docker run  -v $PWD:/source iamdey/lmn-3-daw_compiler:armv7 /bin/bash -c '
  cd /source
  cmake -B build -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DCMAKE_BUILD_TYPE=Debug -DPACKAGE_TESTS=OFF
  cmake --build build -j8
  '
```

## Copyright

This repository has been heavily inspired by
https://github.com/FundamentalFrequency/juce-arm-linux-cross-compiler by Stone
Preston.
