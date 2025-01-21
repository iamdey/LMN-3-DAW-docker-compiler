FROM ubuntu:22.04 as base

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago

RUN apt-get update && apt-get install -y --no-install-recommends \
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
    && rm -rf /var/lib/apt/lists/*
