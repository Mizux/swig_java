%{
#include <cstdint>
%}

%include "stdint.i"
//%include "typemaps.i"

#ifdef SWIGWORDSIZE64

%define PRIMITIVE_TYPEMAP(TYPE, JNITYPE, JTYPE)
%clear TYPE;
%typemap(jstype) TYPE "JTYPE";
%typemap(javain) TYPE "$javainput";
%typemap(jtype) TYPE "JTYPE";
%typemap(jni) TYPE "JNITYPE";
%typemap(in) TYPE %{ $1 = ($1_ltype)&$input; %}
%typemap(freearg) TYPE "";
%typemap(out) TYPE %{ $result = $1; %}
%typemap(javaout) TYPE %{ return $jnicall; %}

%enddef // PRIMITIVE_TYPEMAP

PRIMITIVE_TYPEMAP(long int, jlong, long);
PRIMITIVE_TYPEMAP(unsigned long int, jlong, long);
#undef PRIMITIVE_TYPEMAP

#endif // SWIGWORDSIZE64

%ignore "";

%feature("director") Foo;
%rename(Foo) Foo;
%rename(Bar) Foo::bar(int);
%rename(Bar) Foo::bar(int64_t);
//%rename(Bar) Foo::bar(long long int);

%rename (baz) baz(int);
%rename (baz) baz(int64_t);
//%rename (baz) baz(long long int);

%include "Foo.hpp"
