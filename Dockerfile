#
#	MetaCall Python Rust Melody Example by Tricster
#	An example of Python with Rust with a regex transformer.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM debian:bullseye-slim

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Tricster" \
	maintainer.address="mediosrity@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Install dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		cmake \
		ca-certificates \
		git \
		python3 \
		python3-dev \
		python3-pip \
        curl \
    && pip3 install regex

# Install rust nightly
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2021-12-04 --profile default

# Set working directory to home
WORKDIR /root

# Clone and build the project
RUN git clone --branch v0.5.32 https://github.com/metacall/core --depth 1 \
	&& mkdir core/build && cd core/build \
	&& cmake \
		-DNODEJS_CMAKE_DEBUG=On \
        -DOPTION_BUILD_LOADERS_PY=On \
        -DOPTION_BUILD_LOADERS_RS=On \
		-DOPTION_BUILD_PORTS=On \
		-DOPTION_BUILD_PORTS_PY=On \
		-DOPTION_BUILD_DETOURS=Off \
		-DOPTION_BUILD_SCRIPTS=Off \
		-DOPTION_BUILD_TESTS=Off \
		-DOPTION_BUILD_EXAMPLES=Off \
		.. \
	&& cmake --build . --target install \
	&& ldconfig /usr/local/lib

# Copy source files
COPY melody_wrapper /root/melody_wrapper
COPY *.py /root/
COPY *.rs /root/

# Set up enviroment variables
ENV LOADER_LIBRARY_PATH=/usr/local/lib

# Build the rust source
RUN . ~/.cargo/env && cd melody_wrapper/ && cargo build

# entry point
CMD ["python3", "/root/main.py"]