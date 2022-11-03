# xMakeDocker
## Abstract
Allows to cross-compile C/C++ programs within a Docker Container using XMake.

## Usage
### Building Container
This Docker container is currently not available on Docker Hub. Building it is easy though :

```sh
git clone git@github.com:IncroyablePix/xMakeDocker.git
cd ./xMakeDocker
docker . build -t xmake-builder:latest
```

### Using the container
Using this container is also simple because it requires few arguments.

```sh
docker run \
	-v <XMAKE_PROJECT_ROOT>:/var/src \
	-v <BUILD_OUTPUT_DIRECTORY>:/var/build \
	-e BUILD_PLATFORM=<PLATFORM> \
	-e BUILD_ARCH=<ARCHITECTURE> \
	--name xmake-build \
	xmake-builder:latest
```

#### Platforms
The BUILD_PLATFORM environment variable sets the target platform:
- **WIN**: Microsoft Windows
- **LINUX**: Linux
- **APPLE**: MacOS

The system defaults to LINUX.

#### Architectures
The BUILD_ARCH environment variable sets the target architecture:
- *WIN*:
	- x86_64
	- x86
- *LINUX*:
	- x86
	- x86_64
	- arm
	- arm64

The system defaults to x86_64.

## Build system
### XMake
The container uses [XMake](https://xmake.io/) as build system, requiring your project to be an xmake project. Xmake is a cross-platform build utility that handles all dependencies for you. It is able to use several toolchains such as CLang, MingW, LLVM, etc. 

For Linux, the default GCC compiler suite is used while Windows cross-compilation uses MinGW cross compiler. In order to build for Windows, it might be wise that your xmake project statically links MinGW static libs for not to be forced to provide libstdc++, libgcc_s_seh or libwinpthread DLLs along. 

### Caching
Since XMake downloads and manages the different dependencies for your project, you might want to keep them for different builds. In order to do that, you need to create a volume between your host's permanent xmake directory and your container's XMake directory.

This can be done by creating a volume to the ```/var/xmake``` directory.

