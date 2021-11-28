
typedef unsigned long uint64;

struct sysinfo
{
  uint64 freemem;  /*the number of bytes of free memeory*/
  uint64 nproc;    /*the number of process whose state is not unused*/
};
