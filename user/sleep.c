#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


int sleep_atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}
int main(int argc, char*argv[])
{
	int sleep_num = 0;
	int argv_cov;
	printf("running sleep program!\n");
	for (int i = 0; i < argc ; i ++)
	{
		argv_cov = sleep_atoi(argv[i]);
		sleep_num += sleep_num*10 + argv_cov;
	}
	printf("sleep time:%d \n",sleep_num);
	if(sleep_num < 10000)
	{
		sleep(sleep_num);
	}
	exit(0);
}
