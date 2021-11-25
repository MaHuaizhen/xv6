#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

uint64 trace_atoi(const char *s)
{
  uint64 n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
int main(int argc,char*argv[])
{
    printf("enter trace main\n");
    uint64 TraceId;
    TraceId = trace_atoi(argv[1]);

    //printf("exec trace\n");
    (void)trace(TraceId);

    exec(argv[2],&argv[2]);
    printf("trace exec fail\n");
    exit(0);
}