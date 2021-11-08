#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    int p[2] = {0};  
    int pid1,pid2;
    char charbuf[1024];
    char *ptr = "test";
    int forkN;
    pipe(p);
    forkN = fork();//执行两次，子进程返回0，父进程返回子进程processID
    printf("forkN:%d\n",forkN);
    if(forkN == 0)
    {
        //close(0);
        //dup(p[0]);
        //close(p[0]);
        close(p[1]);
        pid1 = getpid();
        printf("line 22\n");
        read(p[0],charbuf,sizeof(charbuf));
        printf("pong received:%s\n",charbuf);
        printf("%d:received ping\n",pid1);
        close(p[0]);
    }
    else
    {
        close(p[0]);
        pid2= getpid();
        printf("%d:received pong\n",pid2);
        //read(p[0],ar[0],1);
        write(p[1],ptr,strlen(ptr));
        //printf("pong received:%p",ar[0]);
        wait(0);
        close(p[1]);
    }



    // if(fork() == 0)
    // {
    //     close(0);
    //     dup(p[1]);
    //     close(p[0]);
    //     close(p[1]);
    //     pid1 = getpid();
    //     //write(p[0],"1",1);
    //     printf("%d:received ping\n",pid1);
    // }
    // if(fork() == 0)
    // {
    //     close(0);
    //     dup(p[0]);
    //     close(p[0]);
    //     close(p[1]);
    //     pid2 = getpid();
    //     read(p[0],ar[0],1);
    //     printf("%d:received pong\n",pid2);
    // }
    // wait(0);
    // wait(0);
    // both process will exec this line, and when all the process finished, exec exit(0)
    exit(0);

}