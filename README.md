[![Status][linux_svg]][linux_link]

[linux_svg]: https://github.com/Mizux/swig_java/workflows/Linux%20CI/badge.svg
[linux_link]: https://github.com/Mizux/swig_java/actions?query=workflow%3A"Linux+CI"

# SWIG Java issue
Test int64_t wrapping issue in Java

# Context
I have a C++ code with overload `int` and `int64_t` that I need to wrap to Java...

see [Foo.hpp](Foo.hpp) and the swig file [foo.i](foo.i)

# GCC
When using GCC `int64_t` will be define as `long int` see:
```sh
grepc -rn "typedef.*INT64_TYPE" /lib/gcc
/lib/gcc/x86_64-linux-gnu/9/include/stdint-gcc.h:43:typedef __INT64_TYPE__ int64_t;
```
and then
```sh
gcc -dM -E -x c++ /dev/null | grep __INT64
#define __INT64_TYPE__ long int
```

So I use `-DSWIGWORDSIZE64` to avoid wrapper wrong type issue
```sh
grep "int64" -C 1 /usr/local/share/swig/4.0.1/stdint.i 
#if defined(SWIGWORDSIZE64)
typedef long int		int64_t;
#else
typedef long long int		int64_t;
#endif
```
src: https://github.com/swig/swig/blob/master/Lib/stdint.i


So far so good (at least for Python and .NET wrapper), BUT in Java...

# SWIG Java
in Java SWIG swig seems to wrap C++ `long int` to C Wrapper `int` (also truncating 2^64 to 2^32...)
Ref: http://www.swig.org/Doc4.0/SWIGDocumentation.html#Java_default_primitive_type_mappings
Src: https://github.com/swig/swig/blob/master/Lib/java/typemaps.i

So these both methods will have the same prototype -> one is ignored...

AFAIK [java/typemaps.i](https://github.com/swig/swig/blob/master/Lib/java/typemaps.i) nor [java.swg](https://github.com/swig/swig/blob/master/Lib/java/java.swg) support the `SWIGWORDSIZE64` switch...

# Test Protocol
To reproduce the issue (ed I'm using swig 4.0.1)
```sh
mkdir -p gen
swig -DSWIGWORDSIZE64 -I. -c++ -java -o gen/foo_java_wrap.cc -package com.google.Foo -module main -outdir gen foo.i
```

## Observed
```sh
foo.hpp:9: Warning 516: Overloaded method baz(int64_t) ignored,
foo.hpp:8: Warning 516: using baz(int) instead.

cat gen/main.java
...
package com.google.Foo;

public class main {
  public static int baz(int param) {
    return mainJNI.baz__SWIG_0(param);
  }

}
```

see: https://stackoverflow.com/questions/60205627/swig-java-convert-int64-t-to-jlong-when-using-dswigwordsize64

# License

Apache 2. See the LICENSE file for details.

# Disclaimer

This is not an official Google product, it is just code that happens to be
owned by Google.
