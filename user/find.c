#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
void exec_find(char *path,char *findTar)
{
    int fd;
    if((fd = open(path,0))< 0)
    {
        printf("file cannot open:%s\n",path);
    }
}
int main(int argc, char *argv[])
{
    int i = 0;
    if(argc < 2)
    {
        printf("error, lack of find target!\n");
        exit(0);
    }
    else if(argc == 2)
    {
        
        /*find at current file*/
        exec_find(".",argv[1]);
        exit(0);
    }
    else
    {
        for(i=2;i < argc;i++)
        {
            exec_find(argv[i], argv[1]);
        }
        exit(0);
    }

    
}