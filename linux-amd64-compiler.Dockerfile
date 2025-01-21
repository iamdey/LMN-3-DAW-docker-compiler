FROM lmn-3-base

# JUCE Linux Dependencies
# https://github.com/juce-framework/JUCE/blob/master/docs/Linux%20Dependencies.md
RUN apt-get update && apt-get install -y --no-install-recommends \
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
