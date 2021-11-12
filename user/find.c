#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char* fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  //memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
void exec_find(char *path,char *findTar)
{
    int fd;
    int i = 0;
    char buf[50];
    struct dirent de;
    struct stat st;
    int fd1;
    struct stat st1;
    if((fd = open(path,0))< 0)
    {
        printf("file cannot open:%s\n",path);
        return;
    }
    //printf("input path:%s\n",fmtname(path));
    //pathdes = fmtname(path);
    if(fstat(fd,&st) < 0)
    {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    //printf("path type:%d\n",st.type);
    switch(st.type)
    {
        case T_FILE:
        {
            printf("Given path not a directory\n");
        }break;
        case T_DIR://"."
        {
            if(strlen(path) + 1 + DIRSIZ > sizeof(buf))
            {
                printf("ls: path too long\n");
                break;
            }
            // strcpy(buf,path);
            // p=buf+strlen(buf);
            // *p++ = '/';
            // buf[strlen(buf)+1] = '/';
            while(read(fd,&de,sizeof(de))==sizeof(de))//open the path and store it at arrary,with the type dirent, read function read it with the sizeof de one time
            {
                //printf("de.num:%d,de.name:%s,sizeof(de):%d,line71\n",de.inum,de.name,sizeof(de));
                //memmove(&(buf[strlen(buf)+2]), de.name, strlen(de.name));
                strcpy(buf,path);
                //p=buf+strlen(buf);
                //*p++ = '/';
                buf[strlen(buf)] = '/';
                //printf("buf before:%s\n",buf);
                while(de.name[i] != 0)
                {
                    buf[strlen(buf)] = de.name[i];
                    //printf("de.name[i]:%c,buf:%s,buf long:%d\n",de.name[i],buf,strlen(buf));
                    i++;
                }
                //memmove(&(buf[strlen(buf)+2]), de.name, strlen(de.name));
                buf[strlen(buf)+1]= 0;
                //printf("buf after:%s\n",buf);
                //buf[50]= buf[strlen(buf)]+de.name;
                


                //struct dirent de1;
                if(((strcmp(de.name,".") != 0)) && ((strcmp(de.name,"..") != 0)) &&((strcmp(de.name,"") != 0)))
                {
                    //printf("current path:%s,de.name:%s\n",buf,de.name);
                    if((fd1 = open(buf,0))< 0)
                    {
                        printf("file cannot open:%s\n",buf);
                        //continue;
                    }
                    else
                    {
                        //printf("input path:%s\n",fmtname(p));
                        if(fstat(fd1,&st1) < 0)
                        {
                            //fprintf(2, "find: cannot stat %s\n", p);
                            //close(fd1);
                            //return;
                        }
                        //printf("%s:%d\n",buf,st1.type);
                        switch(st1.type)
                        {
                            
                            case T_FILE:
                            {
                                //read(fd1,&de1,sizeof(de1));
                                //strcpy(p,de.name);
                                //printf("de.name:%s lin123\n",de.name);
                                if(0 == strcmp(de.name,findTar))
                                {

                                    //printf("target %s not find at path %s\n",findTar,path);
                                    printf("%s/%s\n",path,findTar);
                                }
                                else
                                {
                                    //printf("%s/%s\n",path,findTar);
                                }
                            }break;
                            case T_DIR:
                            {
                                //printf("de.name:%s lin137\n",de.name);
                                exec_find(buf,findTar);
                            }break;
                            default:
                            break;
                        }
                    }
                    close(fd1);// close the file opened release memeory, or not all the file will be opened
                }
                i = 0;
                memset(buf,0,sizeof(buf));
            }

        }break;
        default:
        break;
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
            exec_find(argv[1], argv[i]);
        }
        exit(0);
    }

    
}
