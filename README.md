<div align="center">
    <a href="https://metacall.io" target="_blank"><img src="https://raw.githubusercontent.com/metacall/core/master/deploy/images/logo.png" alt="M E T A C A L L" style="max-width:100%;" width="32" height="32">
    <p><b>M E T A C A L L</b></p></a>
    <p>MetaCall complete example with Function Mesh between multiple programming languages.</p>
</div>

# Motivation

This example has been designed in order to illustrate how to use Rust loader through ports of other languages, especially the Python port. 

This allows the users to invoke functions of rust libraries from other languages, including python, js, ruby, etc.

# Usage

## Install metacall or build it from source

We can build metacall from source using following commands:

```bash
git clone --branch v0.5.30 https://github.com/metacall/core --depth 1
mkdir core/build && cd core/build
cmake \
    -DNODEJS_CMAKE_DEBUG=On \
    -DOPTION_BUILD_LOADERS_PY=On \
    -DOPTION_BUILD_LOADERS_RS=On \
    -DOPTION_BUILD_PORTS=On \
    -DOPTION_BUILD_PORTS_PY=On \
    -DOPTION_BUILD_DETOURS=Off \
    -DOPTION_BUILD_SCRIPTS=Off \
    -DOPTION_BUILD_TESTS=Off \
    -DOPTION_BUILD_EXAMPLES=Off \
    ..
cmake --build . --target install
ldconfig /usr/local/lib
```

## Prepare the rust library

Here we choose to wrap [melody](https://github.com/yoav-lavi/melody), a language that compiles to ECMAScript regular expressions. In that way, we can create regex formula in a more readable and maintainable way, not just for rust but for many other languages.

Create a rust library, add `melody` as a dependency, and wrap the `compile` function of `melody`. The reason why we create a wrapper layer is that we can export the functions we need instead of all of them.

Check the `src/lib.rs` and you will find that it's super intuitive to wrap a function. Basically, you just write a regular rust function and mark it as `pub`.

After that, compile the library with `cargo b`.

## Call the function inside Python

After obtaining the rust library, we can call it from python.

Check the `main.py` to see what is happening.

First, we load the compiled library using `metacall_load_from_package`, and then invoke the function with `metacall`.

**Note that you should install `metacall` first or provide a environment variable `LOADER_LIBRARY_PATH` which includes `metacall` libraries, in order to use the python port.**

## Run in docker

```bash
# build docker image
docker build -t metacall/python-rust-example .
# run it!
docker run --rm -it metacall/python-rust-example
```

# Supported data types

Currently, Rust loader supports primitive types as parameters and the return value, including:

1. Numeric types
2. String
3. Vec
4. HashMap