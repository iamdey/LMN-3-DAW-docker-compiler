FROM --platform=linux/arm/v7 dtcooper/raspberrypi-os:bullseye as sysroot

# install dependencies for juce
RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    clang \
    cmake \
    g++ \
    git \
    llvm \
    lld \
    tzdata \
    zip \
    # juce dependencies
    ladspa-sdk \
    libasound2-dev \
    libcurl4-openssl-dev  \
    libfreetype6-dev \
    libglu1-mesa-dev \
    libjack-jackd2-dev \
    libx11-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxext-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libwebkit2gtk-4.0-dev \
    mesa-common-dev \
    && rm -rf /var/lib/apt/lists/*

FROM lmn-3-base

# Install x86_64 dependencies so pkg-config stops being annoying
# (I've tried to set `PKG_CONFIG_PATH` but it's not enough)
# (It seems the compiler doesn't care if it's not the same architecture)
RUN apt update && apt install -y --no-install-recommends \
    # juce dependencies
    ladspa-sdk \
    libasound2-dev \
    libcurl4-openssl-dev  \
    libfreetype6-dev \
    libglu1-mesa-dev \
    libjack-jackd2-dev \
    libx11-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxext-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libwebkit2gtk-4.0-dev \
    mesa-common-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y --no-install-recommends \
    curl\
    # required by clang to when used with sysroot
    pkg-config \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Prepare sysroot
COPY --from=sysroot /bin /toolchain/sysroot/bin
COPY --from=sysroot /lib /toolchain/sysroot/lib
COPY --from=sysroot /usr/lib /toolchain/sysroot/usr/lib
COPY --from=sysroot /usr/include /toolchain/sysroot/usr/include

# Fix symlinks
WORKDIR /tmp
RUN curl https://raw.githubusercontent.com/abhiTronix/rpi_rootfs/master/scripts/sysroot-relativelinks.py --output sysroot-relativelinks.py
RUN chmod +x ./sysroot-relativelinks.py
RUN ./sysroot-relativelinks.py /toolchain/sysroot

# Set the directory to retrieve library metadata for clang
ENV PKG_CONFIG_PATH /toolchain/sysroot/usr/lib/arm-linux-gnueabihf/pkgconfig

WORKDIR /toolchain
COPY ./rpi-armv7-toolchain.cmake ./toolchain.cmake
