#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/param.h"

int main(int argc, char* argv[])
{
    char *input_arr[100] = {0};
    //char *p_arr[100] = {0};
    char *cmd_arr[MAXARG] = {0};
    int pid;
    //int j = 0;
    //int i = 0;
    printf("number of input cmd:%d\n",argc);
    pid = fork();
    if(pid == 0)
    {
        read(0,input_arr,sizeof(input_arr));//0 is the default output path of shell
        //p_arr = &input_arr[0];
        printf("input_arr:%s,input_arr[1]:%s\n",input_arr[0],input_arr[1]);
        //cmd_arr[i+1] = p_arr[i];
        // while(input_arr[i]!= 0 )
        // {
        //     printf("cmd_arr:%s\n",input_arr[i]);
        //     i++;
        // }
        strcpy(argv[argc],(const char *)&input_arr[0]);
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