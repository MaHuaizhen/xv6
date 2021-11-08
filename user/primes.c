#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


void ProcessSendRec(int *buf_input)
{
    int p[2] = {0};
    //int buf[100] = {0};
    int buf1[30] = {0};
    int buf2[30] = {0};
    int lop1 = 0;
    int lop = 0;
    int i = 0;
    if(buf_input[0] != 0)
    {
        pipe(p);
        if(fork()==0)
        {
            close(p[1]);
            if(read(p[0],buf2,sizeof(buf2)) != 0)
            {
                while(buf2[lop1] != 0)
                {
                    //printf("child read:%d\n",buf2[lop1]);
                    lop1++;
                }
                
                close(p[0]);
                if(buf2 != 0)
                {
                    //printf("line32:buf_input[0]:%d\n",*buf2);
                    ProcessSendRec(buf2);
                }
                
            }
            else
            {
                close(p[0]);
            }
        }
        else
        {
            close(p[0]);

            if(buf_input[0]!=0)
            {
               
                printf("prime %d\n",buf_input[0]);
                while(buf_input[i]!=0)
                {
                    if(buf_input[i] % buf_input[0]!=0)
                    {
                        buf1[lop]=buf_input[i];
                        lop ++;
                    }
                    i++;
                }
                write(p[1],buf1,sizeof(buf1));
            }
            wait(0);
            close(p[1]);    
        }
    }
   
}
int main()
{
    //int p[2] = {0};
    int buf[35] = {0};
    // int buf1[100] = {0};
    // int buf2[100] = {0};
    // int lop1 = 0;
    // int lop = 0;
    // int i = 0;
    for(int k = 0;k <=33;k ++)
    {
        buf[k]= k+2;
        //printf("line15:%d\n",buf[k]);
    }
    ProcessSendRec(buf);
    // pipe(p);
    // if(fork()==0)
    // {
    //     close(p[1]);
    //     if(read(p[0],buf2,sizeof(buf2)) != 0)
    //     {
    //         while(buf2[lop1] != 0)
    //         {
    //             printf("child read:%d\n",buf2[lop1]);
    //             lop1++;
    //         }
    //         close(p[0]);
    //         int buf3[100] = {0};
    //         int p1[2] = {0};
    //         int lop2=0;
    //         int lop3=0;
    //         int j=0;
    //         pipe(p1);
    //         if(fork()==0)
    //         {
    //             close(p1[1]);
    //             read(p1[0],buf3,sizeof(buf3));
    //             while(buf3[lop3]!=0)
    //             {
    //                 printf("gran child read:%d\n",buf3[lop3]);
    //                 lop3++;
    //             }
    //             close(p1[0]);
    //         }
    //         else
    //         {
    //             close(p1[0]);
    //             if(buf2[0] != 0)
    //             {
    //                 printf("prime %d\n",buf2[0]);
    //                 while(buf2[j] != 0)
    //                 {
    //                     if(buf2[j] % buf2[0]!= 0)
    //                     {
    //                         buf3[lop2] = buf2[j];
    //                         lop2++;
    //                     }
    //                     j++;
    //                 }
    //                 write(p1[1],buf3,sizeof(buf3));
    //             }

    //             wait(0);
    //             close(p1[1]);
    //         }
    //     }
    // }
    // else
    // {
    //     close(p[0]);
    //     if(buf[0]!=0)
    //     {
    //         printf("prime %d\n",buf[0]);
    //         while(buf[i]!=0)
    //         {
    //             if(buf[i] % buf[0]!=0)
    //             {
    //                 buf1[lop]=buf[i];
    //                 lop ++;
    //             }
    //             i++;
    //         }
    //         write(p[1],buf1,sizeof(buf1));
    //     }
    //     wait(0);
    //     close(p[1]);    
    // }
    exit(0);
}