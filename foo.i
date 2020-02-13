%{
#include <cstdint>
%}

%include "stdint.i"
//%include "typemaps.i"

#ifdef SWIGWORDSIZE64

%define PRIMITIVE_TYPEMAP(NEW_TYPE, TYPE)
%clear NEW_TYPE;
%apply TYPE { NEW_TYPE };
%enddef // PRIMITIVE_TYPEMAP

PRIMITIVE_TYPEMAP(long int, long long);
PRIMITIVE_TYPEMAP(unsigned long int, long long);
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
