#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/sysinfo.h"
int main(int argc, char* argv[])
{
    struct sysinfo ken_sysinfo;
    sysinfo(&ken_sysinfo);
    printf("remained mem:%d bytes\n",ken_sysinfo.freemem);
    printf("num of process unused:%d\n",ken_sysinfo.nproc);
    exit(0);
}