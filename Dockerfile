# Old Linux version for good GLIBC compatibility
FROM ubuntu:16.04

# Build and runtime deps 
RUN apt-get update && apt-get install -y vim zlib1g-dev patchelf \ 
libreadline-gplv2-dev  libncursesw5-dev libssl-dev libsqlite3-dev \
tk-dev libgdbm-dev libc6-dev libbz2-dev \
tk build-essential texinfo gawk bison flex tar \
wget gcc clang 

# Setup folders and files
RUN mkdir /app
RUN mkdir /app/deps
WORKDIR "/app"
COPY requirements.txt ./deps 
COPY FRETCalc.py ./deps
COPY res/ ./deps/res

# Here, Python 3.9.16 is used because it is relatively modern 
# yet compatible with Ubuntu 16.04
RUN wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz 
RUN tar -xzf Python-3.9.16.tgz
RUN rm Python-3.9.16.tgz 
RUN cd Python-3.9.16

# Configuration, Python compilation, pip deps installation
# and binary compilation
RUN /app/Python-3.9.16/configure --enable-optimizations
RUN make -j$(nproc)
RUN make install 
RUN pip3 install -r /app/deps/requirements.txt
RUN python3 -m nuitka --show-progress --onefile \
 --include-data-dir=$(pwd)/deps/res=res --enable-plugin=tk-inter deps/FRETCalc.py
