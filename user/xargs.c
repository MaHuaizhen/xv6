#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/param.h"
#if 0
int main(int argc, char* argv[])
{
    char p_arr[100] = {0};
    char *cmd_arr[MAXARG] = {0};
    int pid;
    //int j = 0;
    //int i = 0;
    printf("number of input cmd:%d\n",argc);
    pid = fork();
    if(pid == 0)
    {
        read(0,p_arr,sizeof(char));//0 is the default output path of shell
        //p_arr = &input_arr[0];
        //printf("input_arr:%s,input_arr[1]:%s\n",input_arr[0],input_arr[1]);
        //cmd_arr[i+1] = p_arr[i];
        // while(input_arr[i]!= 0 )
        // {
        //     printf("cmd_arr:%s\n",input_arr[i]);
        //     i++;
        // }
        strcpy(argv[argc],(const char *)&p_arr[0]);
        // while(argv[i]!= 0 )
        // {
        //     printf("cmd_arr:%c\n",*argv[0]);
        //     i++;
        // }
        strcpy(cmd_arr[0],(const char *)&argv[1]);
        // while(cmd_arr[i]!= 0 )
        // {
        //     printf("cmd_arr:%c\n",*cmd_arr[0]);
        //     i++;
        // }
        printf("cmd_arr[0]:%s\n",*cmd_arr[0]);
        exec(cmd_arr[0],&cmd_arr[0]);
        printf("exec failed\n");
        exit(1);
    }
    wait(0);
    exit(0);
}
#endif
int main(int argc, char *argv[])
{
    int buf_idx,i,read_len;
    char buf[512];
    char *exe_argv[MAXARG];
    for(i=1;i<argc;i++)
    {
        exe_argv[i-1]=argv[i];
    }
    while(1)
    {
        buf_idx = -1;
        do
        {
            buf_idx++;
            read_len = read(0,&buf[buf_idx],sizeof(char));
            printf("line64:%d\n",buf[buf_idx]);
        }while(read_len>0&&buf[buf_idx]!='\n');
        printf("read_len:%d,buf_idx:%d,buf[buf_idx]:%d\n",read_len,buf_idx,buf[buf_idx]);
        if(read_len ==0&&buf_idx==0){break;}
    }
    buf[buf_idx]='\0';
    i=0;
    while(buf[i]!='\0')
    {
        printf("line71:%c\n",buf[i]);
        i++;
    }
    exe_argv[argc-1]=buf;
    if(fork()==0)
    {
        exec(exe_argv[0],exe_argv);
        exit(0);
    }
    else
    {
        wait(0);
    }
    exit(0);
}