%{
#include <cstdint>
%}

%include "stdint.i"
%include "typemaps.i"

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
