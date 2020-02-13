#include <cstdint>

class Foo {
  public:
  int bar(int param);
  int bar(int64_t param); // long int
// int bar(long long int param);
};

int baz(int param);
int baz(int64_t param); // long int
//int baz(long long int param);
