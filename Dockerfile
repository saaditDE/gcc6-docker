# modified by SAAD-IT 2020
# original https://raw.githubusercontent.com/kunitoki/cxx-docker-images/master/images/clang-6/Dockerfile

FROM ubuntu:16.04
LABEL maintainer="Lucio Asnaghi <kunitoki@gmail.com>"

ARG CMAKE_VERSION=3.23.2

RUN apt-get -qq update -y \
    && apt-get -qq install -y --no-install-recommends \
        ca-certificates \
        build-essential \
        python \
        ninja-build \
        ccache \
        xz-utils \
        curl \
        git \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# https://web.archive.org/web/20220915121551/https://objects.githubusercontent.com/github-production-release-asset-2e65be/537699/91d64bef-2691-4691-95c6-40c33d8000dc?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220915%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220915T121551Z&X-Amz-Expires=300&X-Amz-Signature=73271553e2d3805dc168ce350b01d10c379a7416c5dd079eee083c7f32d57d66&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=537699&response-content-disposition=attachment%3B%20filename%3Dcmake-3.23.2-linux-x86_64.sh&response-content-type=application%2Foctet-stream
RUN curl -SL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh -o /tmp/curl-install.sh \
    && chmod u+x /tmp/curl-install.sh \
    && mkdir /usr/bin/cmake \
    && /tmp/curl-install.sh --skip-license --prefix=/usr/bin/cmake \
    && rm /tmp/curl-install.sh

# https://web.archive.org/web/20210819034502/releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN curl -SL http://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz | tar -xJC . \
    && mv clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04 clang_6.0.1

ENV PATH="/clang_6.0.1/bin:/usr/bin/cmake/bin:${PATH}"
ENV LD_LIBRARY_PATH="/clang_6.0.1/lib:${LD_LIBRARY_PATH}"
ENV CC="/clang_6.0.1/bin/clang"
ENV CXX="/clang_6.0.1/bin/clang++"
