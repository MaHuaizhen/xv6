
user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char* fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   e:	00000097          	auipc	ra,0x0
  12:	380080e7          	jalr	896(ra) # 38e <strlen>
  16:	02051593          	slli	a1,a0,0x20
  1a:	9181                	srli	a1,a1,0x20
  1c:	95a6                	add	a1,a1,s1
  1e:	02f00713          	li	a4,47
  22:	0095e963          	bltu	a1,s1,34 <fmtname+0x34>
  26:	0005c783          	lbu	a5,0(a1)
  2a:	00e78563          	beq	a5,a4,34 <fmtname+0x34>
  2e:	15fd                	addi	a1,a1,-1
  30:	fe95fbe3          	bgeu	a1,s1,26 <fmtname+0x26>
    ;
  p++;
  34:	00158493          	addi	s1,a1,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  38:	8526                	mv	a0,s1
  3a:	00000097          	auipc	ra,0x0
  3e:	354080e7          	jalr	852(ra) # 38e <strlen>
  42:	2501                	sext.w	a0,a0
  44:	47b5                	li	a5,13
  46:	00a7f963          	bgeu	a5,a0,58 <fmtname+0x58>
    return p;
  memmove(buf, p, strlen(p));
  //memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4a:	8526                	mv	a0,s1
  4c:	60e2                	ld	ra,24(sp)
  4e:	6442                	ld	s0,16(sp)
  50:	64a2                	ld	s1,8(sp)
  52:	6902                	ld	s2,0(sp)
  54:	6105                	addi	sp,sp,32
  56:	8082                	ret
  memmove(buf, p, strlen(p));
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	334080e7          	jalr	820(ra) # 38e <strlen>
  62:	00001917          	auipc	s2,0x1
  66:	b5690913          	addi	s2,s2,-1194 # bb8 <buf.1112>
  6a:	0005061b          	sext.w	a2,a0
  6e:	85a6                	mv	a1,s1
  70:	854a                	mv	a0,s2
  72:	00000097          	auipc	ra,0x0
  76:	494080e7          	jalr	1172(ra) # 506 <memmove>
  return buf;
  7a:	84ca                	mv	s1,s2
  7c:	b7f9                	j	4a <fmtname+0x4a>

000000000000007e <exec_find>:
void exec_find(char *path,char *findTar)
{
  7e:	7155                	addi	sp,sp,-208
  80:	e586                	sd	ra,200(sp)
  82:	e1a2                	sd	s0,192(sp)
  84:	fd26                	sd	s1,184(sp)
  86:	f94a                	sd	s2,176(sp)
  88:	f54e                	sd	s3,168(sp)
  8a:	f152                	sd	s4,160(sp)
  8c:	ed56                	sd	s5,152(sp)
  8e:	e95a                	sd	s6,144(sp)
  90:	e55e                	sd	s7,136(sp)
  92:	e162                	sd	s8,128(sp)
  94:	0980                	addi	s0,sp,208
  96:	89aa                	mv	s3,a0
  98:	8a2e                	mv	s4,a1
    char buf[50];
    struct dirent de;
    struct stat st;
    int fd1;
    struct stat st1;
    if((fd = open(path,0))< 0)
  9a:	4581                	li	a1,0
  9c:	00000097          	auipc	ra,0x0
  a0:	560080e7          	jalr	1376(ra) # 5fc <open>
  a4:	02054e63          	bltz	a0,e0 <exec_find+0x62>
  a8:	892a                	mv	s2,a0
        printf("file cannot open:%s\n",path);
        return;
    }
    //printf("input path:%s\n",fmtname(path));
    //pathdes = fmtname(path);
    if(fstat(fd,&st) < 0)
  aa:	f5040593          	addi	a1,s0,-176
  ae:	00000097          	auipc	ra,0x0
  b2:	566080e7          	jalr	1382(ra) # 614 <fstat>
  b6:	04054a63          	bltz	a0,10a <exec_find+0x8c>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    //printf("path type:%d\n",st.type);
    switch(st.type)
  ba:	f5841783          	lh	a5,-168(s0)
  be:	0007869b          	sext.w	a3,a5
  c2:	4705                	li	a4,1
  c4:	06e68363          	beq	a3,a4,12a <exec_find+0xac>
  c8:	4709                	li	a4,2
  ca:	02e69463          	bne	a3,a4,f2 <exec_find+0x74>
    {
        case T_FILE:
        {
            printf("Given path not a directory\n");
  ce:	00001517          	auipc	a0,0x1
  d2:	a4a50513          	addi	a0,a0,-1462 # b18 <malloc+0x116>
  d6:	00001097          	auipc	ra,0x1
  da:	86e080e7          	jalr	-1938(ra) # 944 <printf>
        }break;
  de:	a811                	j	f2 <exec_find+0x74>
        printf("file cannot open:%s\n",path);
  e0:	85ce                	mv	a1,s3
  e2:	00001517          	auipc	a0,0x1
  e6:	a0650513          	addi	a0,a0,-1530 # ae8 <malloc+0xe6>
  ea:	00001097          	auipc	ra,0x1
  ee:	85a080e7          	jalr	-1958(ra) # 944 <printf>
        }break;
        default:
        break;
    }

}
  f2:	60ae                	ld	ra,200(sp)
  f4:	640e                	ld	s0,192(sp)
  f6:	74ea                	ld	s1,184(sp)
  f8:	794a                	ld	s2,176(sp)
  fa:	79aa                	ld	s3,168(sp)
  fc:	7a0a                	ld	s4,160(sp)
  fe:	6aea                	ld	s5,152(sp)
 100:	6b4a                	ld	s6,144(sp)
 102:	6baa                	ld	s7,136(sp)
 104:	6c0a                	ld	s8,128(sp)
 106:	6169                	addi	sp,sp,208
 108:	8082                	ret
        fprintf(2, "find: cannot stat %s\n", path);
 10a:	864e                	mv	a2,s3
 10c:	00001597          	auipc	a1,0x1
 110:	9f458593          	addi	a1,a1,-1548 # b00 <malloc+0xfe>
 114:	4509                	li	a0,2
 116:	00001097          	auipc	ra,0x1
 11a:	800080e7          	jalr	-2048(ra) # 916 <fprintf>
        close(fd);
 11e:	854a                	mv	a0,s2
 120:	00000097          	auipc	ra,0x0
 124:	4c4080e7          	jalr	1220(ra) # 5e4 <close>
        return;
 128:	b7e9                	j	f2 <exec_find+0x74>
            if(strlen(path) + 1 + DIRSIZ > sizeof(buf))
 12a:	854e                	mv	a0,s3
 12c:	00000097          	auipc	ra,0x0
 130:	262080e7          	jalr	610(ra) # 38e <strlen>
 134:	253d                	addiw	a0,a0,15
 136:	03200793          	li	a5,50
 13a:	02a7e163          	bltu	a5,a0,15c <exec_find+0xde>
                buf[strlen(buf)] = '/';
 13e:	02f00b13          	li	s6,47
                if(((strcmp(de.name,".") != 0)) && ((strcmp(de.name,"..") != 0)) &&((strcmp(de.name,"") != 0)))
 142:	00001a97          	auipc	s5,0x1
 146:	a0ea8a93          	addi	s5,s5,-1522 # b50 <malloc+0x14e>
 14a:	00001b97          	auipc	s7,0x1
 14e:	a0eb8b93          	addi	s7,s7,-1522 # b58 <malloc+0x156>
 152:	00001c17          	auipc	s8,0x1
 156:	a0ec0c13          	addi	s8,s8,-1522 # b60 <malloc+0x15e>
 15a:	a091                	j	19e <exec_find+0x120>
                printf("ls: path too long\n");
 15c:	00001517          	auipc	a0,0x1
 160:	9dc50513          	addi	a0,a0,-1572 # b38 <malloc+0x136>
 164:	00000097          	auipc	ra,0x0
 168:	7e0080e7          	jalr	2016(ra) # 944 <printf>
                break;
 16c:	b759                	j	f2 <exec_find+0x74>
                        printf("file cannot open:%s\n",buf);
 16e:	f7840593          	addi	a1,s0,-136
 172:	00001517          	auipc	a0,0x1
 176:	97650513          	addi	a0,a0,-1674 # ae8 <malloc+0xe6>
 17a:	00000097          	auipc	ra,0x0
 17e:	7ca080e7          	jalr	1994(ra) # 944 <printf>
                    close(fd1);// close the file opened release memeory, or not all the file will be opened
 182:	8526                	mv	a0,s1
 184:	00000097          	auipc	ra,0x0
 188:	460080e7          	jalr	1120(ra) # 5e4 <close>
                memset(buf,0,sizeof(buf));
 18c:	03200613          	li	a2,50
 190:	4581                	li	a1,0
 192:	f7840513          	addi	a0,s0,-136
 196:	00000097          	auipc	ra,0x0
 19a:	222080e7          	jalr	546(ra) # 3b8 <memset>
            while(read(fd,&de,sizeof(de))==sizeof(de))//open the path and store it at arrary,with the type dirent, read function read it with the sizeof de one time
 19e:	4641                	li	a2,16
 1a0:	f6840593          	addi	a1,s0,-152
 1a4:	854a                	mv	a0,s2
 1a6:	00000097          	auipc	ra,0x0
 1aa:	42e080e7          	jalr	1070(ra) # 5d4 <read>
 1ae:	47c1                	li	a5,16
 1b0:	f4f511e3          	bne	a0,a5,f2 <exec_find+0x74>
                strcpy(buf,path);
 1b4:	85ce                	mv	a1,s3
 1b6:	f7840513          	addi	a0,s0,-136
 1ba:	00000097          	auipc	ra,0x0
 1be:	18c080e7          	jalr	396(ra) # 346 <strcpy>
                buf[strlen(buf)] = '/';
 1c2:	f7840513          	addi	a0,s0,-136
 1c6:	00000097          	auipc	ra,0x0
 1ca:	1c8080e7          	jalr	456(ra) # 38e <strlen>
 1ce:	1502                	slli	a0,a0,0x20
 1d0:	9101                	srli	a0,a0,0x20
 1d2:	fb040793          	addi	a5,s0,-80
 1d6:	953e                	add	a0,a0,a5
 1d8:	fd650423          	sb	s6,-56(a0)
                while(de.name[i] != 0)
 1dc:	f6a44783          	lbu	a5,-150(s0)
 1e0:	c79d                	beqz	a5,20e <exec_find+0x190>
 1e2:	f6a40493          	addi	s1,s0,-150
                    buf[strlen(buf)] = de.name[i];
 1e6:	f7840513          	addi	a0,s0,-136
 1ea:	00000097          	auipc	ra,0x0
 1ee:	1a4080e7          	jalr	420(ra) # 38e <strlen>
 1f2:	02051793          	slli	a5,a0,0x20
 1f6:	9381                	srli	a5,a5,0x20
 1f8:	fb040713          	addi	a4,s0,-80
 1fc:	97ba                	add	a5,a5,a4
 1fe:	0004c703          	lbu	a4,0(s1)
 202:	fce78423          	sb	a4,-56(a5)
                while(de.name[i] != 0)
 206:	0485                	addi	s1,s1,1
 208:	0004c783          	lbu	a5,0(s1)
 20c:	ffe9                	bnez	a5,1e6 <exec_find+0x168>
                buf[strlen(buf)+1]= 0;
 20e:	f7840513          	addi	a0,s0,-136
 212:	00000097          	auipc	ra,0x0
 216:	17c080e7          	jalr	380(ra) # 38e <strlen>
 21a:	0015079b          	addiw	a5,a0,1
 21e:	1782                	slli	a5,a5,0x20
 220:	9381                	srli	a5,a5,0x20
 222:	fb040713          	addi	a4,s0,-80
 226:	97ba                	add	a5,a5,a4
 228:	fc078423          	sb	zero,-56(a5)
                if(((strcmp(de.name,".") != 0)) && ((strcmp(de.name,"..") != 0)) &&((strcmp(de.name,"") != 0)))
 22c:	85d6                	mv	a1,s5
 22e:	f6a40513          	addi	a0,s0,-150
 232:	00000097          	auipc	ra,0x0
 236:	130080e7          	jalr	304(ra) # 362 <strcmp>
 23a:	d929                	beqz	a0,18c <exec_find+0x10e>
 23c:	85de                	mv	a1,s7
 23e:	f6a40513          	addi	a0,s0,-150
 242:	00000097          	auipc	ra,0x0
 246:	120080e7          	jalr	288(ra) # 362 <strcmp>
 24a:	d129                	beqz	a0,18c <exec_find+0x10e>
 24c:	85e2                	mv	a1,s8
 24e:	f6a40513          	addi	a0,s0,-150
 252:	00000097          	auipc	ra,0x0
 256:	110080e7          	jalr	272(ra) # 362 <strcmp>
 25a:	d90d                	beqz	a0,18c <exec_find+0x10e>
                    if((fd1 = open(buf,0))< 0)
 25c:	4581                	li	a1,0
 25e:	f7840513          	addi	a0,s0,-136
 262:	00000097          	auipc	ra,0x0
 266:	39a080e7          	jalr	922(ra) # 5fc <open>
 26a:	84aa                	mv	s1,a0
 26c:	f00541e3          	bltz	a0,16e <exec_find+0xf0>
                        if(fstat(fd1,&st1) < 0)
 270:	f3840593          	addi	a1,s0,-200
 274:	00000097          	auipc	ra,0x0
 278:	3a0080e7          	jalr	928(ra) # 614 <fstat>
                        switch(st1.type)
 27c:	f4041783          	lh	a5,-192(s0)
 280:	0007869b          	sext.w	a3,a5
 284:	4705                	li	a4,1
 286:	02e68963          	beq	a3,a4,2b8 <exec_find+0x23a>
 28a:	4709                	li	a4,2
 28c:	eee69be3          	bne	a3,a4,182 <exec_find+0x104>
                                if(0 == strcmp(de.name,findTar))
 290:	85d2                	mv	a1,s4
 292:	f6a40513          	addi	a0,s0,-150
 296:	00000097          	auipc	ra,0x0
 29a:	0cc080e7          	jalr	204(ra) # 362 <strcmp>
 29e:	ee0512e3          	bnez	a0,182 <exec_find+0x104>
                                    printf("%s/%s\n",path,findTar);
 2a2:	8652                	mv	a2,s4
 2a4:	85ce                	mv	a1,s3
 2a6:	00001517          	auipc	a0,0x1
 2aa:	8c250513          	addi	a0,a0,-1854 # b68 <malloc+0x166>
 2ae:	00000097          	auipc	ra,0x0
 2b2:	696080e7          	jalr	1686(ra) # 944 <printf>
 2b6:	b5f1                	j	182 <exec_find+0x104>
                                exec_find(buf,findTar);
 2b8:	85d2                	mv	a1,s4
 2ba:	f7840513          	addi	a0,s0,-136
 2be:	00000097          	auipc	ra,0x0
 2c2:	dc0080e7          	jalr	-576(ra) # 7e <exec_find>
                            }break;
 2c6:	bd75                	j	182 <exec_find+0x104>

00000000000002c8 <main>:
int main(int argc, char *argv[])
{
 2c8:	7179                	addi	sp,sp,-48
 2ca:	f406                	sd	ra,40(sp)
 2cc:	f022                	sd	s0,32(sp)
 2ce:	ec26                	sd	s1,24(sp)
 2d0:	e84a                	sd	s2,16(sp)
 2d2:	e44e                	sd	s3,8(sp)
 2d4:	e052                	sd	s4,0(sp)
 2d6:	1800                	addi	s0,sp,48
    int i = 0;
    if(argc < 2)
 2d8:	4785                	li	a5,1
 2da:	02a7db63          	bge	a5,a0,310 <main+0x48>
 2de:	89aa                	mv	s3,a0
 2e0:	8a2e                	mv	s4,a1
    {
        printf("error, lack of find target!\n");
        exit(0);
    }
    else if(argc == 2)
 2e2:	4789                	li	a5,2
 2e4:	01058913          	addi	s2,a1,16
        exec_find(".",argv[1]);
        exit(0);
    }
    else
    {
        for(i=2;i < argc;i++)
 2e8:	4489                	li	s1,2
    else if(argc == 2)
 2ea:	04f50063          	beq	a0,a5,32a <main+0x62>
        {
            exec_find(argv[1], argv[i]);
 2ee:	00093583          	ld	a1,0(s2)
 2f2:	008a3503          	ld	a0,8(s4)
 2f6:	00000097          	auipc	ra,0x0
 2fa:	d88080e7          	jalr	-632(ra) # 7e <exec_find>
        for(i=2;i < argc;i++)
 2fe:	2485                	addiw	s1,s1,1
 300:	0921                	addi	s2,s2,8
 302:	ff34c6e3          	blt	s1,s3,2ee <main+0x26>
        }
        exit(0);
 306:	4501                	li	a0,0
 308:	00000097          	auipc	ra,0x0
 30c:	2b4080e7          	jalr	692(ra) # 5bc <exit>
        printf("error, lack of find target!\n");
 310:	00001517          	auipc	a0,0x1
 314:	86050513          	addi	a0,a0,-1952 # b70 <malloc+0x16e>
 318:	00000097          	auipc	ra,0x0
 31c:	62c080e7          	jalr	1580(ra) # 944 <printf>
        exit(0);
 320:	4501                	li	a0,0
 322:	00000097          	auipc	ra,0x0
 326:	29a080e7          	jalr	666(ra) # 5bc <exit>
        exec_find(".",argv[1]);
 32a:	658c                	ld	a1,8(a1)
 32c:	00001517          	auipc	a0,0x1
 330:	82450513          	addi	a0,a0,-2012 # b50 <malloc+0x14e>
 334:	00000097          	auipc	ra,0x0
 338:	d4a080e7          	jalr	-694(ra) # 7e <exec_find>
        exit(0);
 33c:	4501                	li	a0,0
 33e:	00000097          	auipc	ra,0x0
 342:	27e080e7          	jalr	638(ra) # 5bc <exit>

0000000000000346 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 34c:	87aa                	mv	a5,a0
 34e:	0585                	addi	a1,a1,1
 350:	0785                	addi	a5,a5,1
 352:	fff5c703          	lbu	a4,-1(a1)
 356:	fee78fa3          	sb	a4,-1(a5)
 35a:	fb75                	bnez	a4,34e <strcpy+0x8>
    ;
  return os;
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 368:	00054783          	lbu	a5,0(a0)
 36c:	cb91                	beqz	a5,380 <strcmp+0x1e>
 36e:	0005c703          	lbu	a4,0(a1)
 372:	00f71763          	bne	a4,a5,380 <strcmp+0x1e>
    p++, q++;
 376:	0505                	addi	a0,a0,1
 378:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 37a:	00054783          	lbu	a5,0(a0)
 37e:	fbe5                	bnez	a5,36e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 380:	0005c503          	lbu	a0,0(a1)
}
 384:	40a7853b          	subw	a0,a5,a0
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret

000000000000038e <strlen>:

uint
strlen(const char *s)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 394:	00054783          	lbu	a5,0(a0)
 398:	cf91                	beqz	a5,3b4 <strlen+0x26>
 39a:	0505                	addi	a0,a0,1
 39c:	87aa                	mv	a5,a0
 39e:	4685                	li	a3,1
 3a0:	9e89                	subw	a3,a3,a0
 3a2:	00f6853b          	addw	a0,a3,a5
 3a6:	0785                	addi	a5,a5,1
 3a8:	fff7c703          	lbu	a4,-1(a5)
 3ac:	fb7d                	bnez	a4,3a2 <strlen+0x14>
    ;
  return n;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
  for(n = 0; s[n]; n++)
 3b4:	4501                	li	a0,0
 3b6:	bfe5                	j	3ae <strlen+0x20>

00000000000003b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e422                	sd	s0,8(sp)
 3bc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3be:	ce09                	beqz	a2,3d8 <memset+0x20>
 3c0:	87aa                	mv	a5,a0
 3c2:	fff6071b          	addiw	a4,a2,-1
 3c6:	1702                	slli	a4,a4,0x20
 3c8:	9301                	srli	a4,a4,0x20
 3ca:	0705                	addi	a4,a4,1
 3cc:	972a                	add	a4,a4,a0
    cdst[i] = c;
 3ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3d2:	0785                	addi	a5,a5,1
 3d4:	fee79de3          	bne	a5,a4,3ce <memset+0x16>
  }
  return dst;
}
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	addi	sp,sp,16
 3dc:	8082                	ret

00000000000003de <strchr>:

char*
strchr(const char *s, char c)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	cb99                	beqz	a5,3fe <strchr+0x20>
    if(*s == c)
 3ea:	00f58763          	beq	a1,a5,3f8 <strchr+0x1a>
  for(; *s; s++)
 3ee:	0505                	addi	a0,a0,1
 3f0:	00054783          	lbu	a5,0(a0)
 3f4:	fbfd                	bnez	a5,3ea <strchr+0xc>
      return (char*)s;
  return 0;
 3f6:	4501                	li	a0,0
}
 3f8:	6422                	ld	s0,8(sp)
 3fa:	0141                	addi	sp,sp,16
 3fc:	8082                	ret
  return 0;
 3fe:	4501                	li	a0,0
 400:	bfe5                	j	3f8 <strchr+0x1a>

0000000000000402 <gets>:

char*
gets(char *buf, int max)
{
 402:	711d                	addi	sp,sp,-96
 404:	ec86                	sd	ra,88(sp)
 406:	e8a2                	sd	s0,80(sp)
 408:	e4a6                	sd	s1,72(sp)
 40a:	e0ca                	sd	s2,64(sp)
 40c:	fc4e                	sd	s3,56(sp)
 40e:	f852                	sd	s4,48(sp)
 410:	f456                	sd	s5,40(sp)
 412:	f05a                	sd	s6,32(sp)
 414:	ec5e                	sd	s7,24(sp)
 416:	1080                	addi	s0,sp,96
 418:	8baa                	mv	s7,a0
 41a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41c:	892a                	mv	s2,a0
 41e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 420:	4aa9                	li	s5,10
 422:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 424:	89a6                	mv	s3,s1
 426:	2485                	addiw	s1,s1,1
 428:	0344d863          	bge	s1,s4,458 <gets+0x56>
    cc = read(0, &c, 1);
 42c:	4605                	li	a2,1
 42e:	faf40593          	addi	a1,s0,-81
 432:	4501                	li	a0,0
 434:	00000097          	auipc	ra,0x0
 438:	1a0080e7          	jalr	416(ra) # 5d4 <read>
    if(cc < 1)
 43c:	00a05e63          	blez	a0,458 <gets+0x56>
    buf[i++] = c;
 440:	faf44783          	lbu	a5,-81(s0)
 444:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 448:	01578763          	beq	a5,s5,456 <gets+0x54>
 44c:	0905                	addi	s2,s2,1
 44e:	fd679be3          	bne	a5,s6,424 <gets+0x22>
  for(i=0; i+1 < max; ){
 452:	89a6                	mv	s3,s1
 454:	a011                	j	458 <gets+0x56>
 456:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 458:	99de                	add	s3,s3,s7
 45a:	00098023          	sb	zero,0(s3)
  return buf;
}
 45e:	855e                	mv	a0,s7
 460:	60e6                	ld	ra,88(sp)
 462:	6446                	ld	s0,80(sp)
 464:	64a6                	ld	s1,72(sp)
 466:	6906                	ld	s2,64(sp)
 468:	79e2                	ld	s3,56(sp)
 46a:	7a42                	ld	s4,48(sp)
 46c:	7aa2                	ld	s5,40(sp)
 46e:	7b02                	ld	s6,32(sp)
 470:	6be2                	ld	s7,24(sp)
 472:	6125                	addi	sp,sp,96
 474:	8082                	ret

0000000000000476 <stat>:

int
stat(const char *n, struct stat *st)
{
 476:	1101                	addi	sp,sp,-32
 478:	ec06                	sd	ra,24(sp)
 47a:	e822                	sd	s0,16(sp)
 47c:	e426                	sd	s1,8(sp)
 47e:	e04a                	sd	s2,0(sp)
 480:	1000                	addi	s0,sp,32
 482:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 484:	4581                	li	a1,0
 486:	00000097          	auipc	ra,0x0
 48a:	176080e7          	jalr	374(ra) # 5fc <open>
  if(fd < 0)
 48e:	02054563          	bltz	a0,4b8 <stat+0x42>
 492:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 494:	85ca                	mv	a1,s2
 496:	00000097          	auipc	ra,0x0
 49a:	17e080e7          	jalr	382(ra) # 614 <fstat>
 49e:	892a                	mv	s2,a0
  close(fd);
 4a0:	8526                	mv	a0,s1
 4a2:	00000097          	auipc	ra,0x0
 4a6:	142080e7          	jalr	322(ra) # 5e4 <close>
  return r;
}
 4aa:	854a                	mv	a0,s2
 4ac:	60e2                	ld	ra,24(sp)
 4ae:	6442                	ld	s0,16(sp)
 4b0:	64a2                	ld	s1,8(sp)
 4b2:	6902                	ld	s2,0(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret
    return -1;
 4b8:	597d                	li	s2,-1
 4ba:	bfc5                	j	4aa <stat+0x34>

00000000000004bc <atoi>:

int
atoi(const char *s)
{
 4bc:	1141                	addi	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c2:	00054603          	lbu	a2,0(a0)
 4c6:	fd06079b          	addiw	a5,a2,-48
 4ca:	0ff7f793          	andi	a5,a5,255
 4ce:	4725                	li	a4,9
 4d0:	02f76963          	bltu	a4,a5,502 <atoi+0x46>
 4d4:	86aa                	mv	a3,a0
  n = 0;
 4d6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4d8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4da:	0685                	addi	a3,a3,1
 4dc:	0025179b          	slliw	a5,a0,0x2
 4e0:	9fa9                	addw	a5,a5,a0
 4e2:	0017979b          	slliw	a5,a5,0x1
 4e6:	9fb1                	addw	a5,a5,a2
 4e8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4ec:	0006c603          	lbu	a2,0(a3)
 4f0:	fd06071b          	addiw	a4,a2,-48
 4f4:	0ff77713          	andi	a4,a4,255
 4f8:	fee5f1e3          	bgeu	a1,a4,4da <atoi+0x1e>
  return n;
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret
  n = 0;
 502:	4501                	li	a0,0
 504:	bfe5                	j	4fc <atoi+0x40>

0000000000000506 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 506:	1141                	addi	sp,sp,-16
 508:	e422                	sd	s0,8(sp)
 50a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 50c:	02b57663          	bgeu	a0,a1,538 <memmove+0x32>
    while(n-- > 0)
 510:	02c05163          	blez	a2,532 <memmove+0x2c>
 514:	fff6079b          	addiw	a5,a2,-1
 518:	1782                	slli	a5,a5,0x20
 51a:	9381                	srli	a5,a5,0x20
 51c:	0785                	addi	a5,a5,1
 51e:	97aa                	add	a5,a5,a0
  dst = vdst;
 520:	872a                	mv	a4,a0
      *dst++ = *src++;
 522:	0585                	addi	a1,a1,1
 524:	0705                	addi	a4,a4,1
 526:	fff5c683          	lbu	a3,-1(a1)
 52a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 52e:	fee79ae3          	bne	a5,a4,522 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	addi	sp,sp,16
 536:	8082                	ret
    dst += n;
 538:	00c50733          	add	a4,a0,a2
    src += n;
 53c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 53e:	fec05ae3          	blez	a2,532 <memmove+0x2c>
 542:	fff6079b          	addiw	a5,a2,-1
 546:	1782                	slli	a5,a5,0x20
 548:	9381                	srli	a5,a5,0x20
 54a:	fff7c793          	not	a5,a5
 54e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 550:	15fd                	addi	a1,a1,-1
 552:	177d                	addi	a4,a4,-1
 554:	0005c683          	lbu	a3,0(a1)
 558:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 55c:	fee79ae3          	bne	a5,a4,550 <memmove+0x4a>
 560:	bfc9                	j	532 <memmove+0x2c>

0000000000000562 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 562:	1141                	addi	sp,sp,-16
 564:	e422                	sd	s0,8(sp)
 566:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 568:	ca05                	beqz	a2,598 <memcmp+0x36>
 56a:	fff6069b          	addiw	a3,a2,-1
 56e:	1682                	slli	a3,a3,0x20
 570:	9281                	srli	a3,a3,0x20
 572:	0685                	addi	a3,a3,1
 574:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 576:	00054783          	lbu	a5,0(a0)
 57a:	0005c703          	lbu	a4,0(a1)
 57e:	00e79863          	bne	a5,a4,58e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 582:	0505                	addi	a0,a0,1
    p2++;
 584:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 586:	fed518e3          	bne	a0,a3,576 <memcmp+0x14>
  }
  return 0;
 58a:	4501                	li	a0,0
 58c:	a019                	j	592 <memcmp+0x30>
      return *p1 - *p2;
 58e:	40e7853b          	subw	a0,a5,a4
}
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret
  return 0;
 598:	4501                	li	a0,0
 59a:	bfe5                	j	592 <memcmp+0x30>

000000000000059c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 59c:	1141                	addi	sp,sp,-16
 59e:	e406                	sd	ra,8(sp)
 5a0:	e022                	sd	s0,0(sp)
 5a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5a4:	00000097          	auipc	ra,0x0
 5a8:	f62080e7          	jalr	-158(ra) # 506 <memmove>
}
 5ac:	60a2                	ld	ra,8(sp)
 5ae:	6402                	ld	s0,0(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b4:	4885                	li	a7,1
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5bc:	4889                	li	a7,2
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c4:	488d                	li	a7,3
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5cc:	4891                	li	a7,4
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <read>:
.global read
read:
 li a7, SYS_read
 5d4:	4895                	li	a7,5
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <write>:
.global write
write:
 li a7, SYS_write
 5dc:	48c1                	li	a7,16
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <close>:
.global close
close:
 li a7, SYS_close
 5e4:	48d5                	li	a7,21
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ec:	4899                	li	a7,6
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f4:	489d                	li	a7,7
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <open>:
.global open
open:
 li a7, SYS_open
 5fc:	48bd                	li	a7,15
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 604:	48c5                	li	a7,17
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 60c:	48c9                	li	a7,18
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 614:	48a1                	li	a7,8
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <link>:
.global link
link:
 li a7, SYS_link
 61c:	48cd                	li	a7,19
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 624:	48d1                	li	a7,20
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 62c:	48a5                	li	a7,9
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <dup>:
.global dup
dup:
 li a7, SYS_dup
 634:	48a9                	li	a7,10
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 63c:	48ad                	li	a7,11
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 644:	48b1                	li	a7,12
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 64c:	48b5                	li	a7,13
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 654:	48b9                	li	a7,14
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <trace>:
.global trace
trace:
 li a7, SYS_trace
 65c:	48d9                	li	a7,22
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 664:	48dd                	li	a7,23
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 66c:	1101                	addi	sp,sp,-32
 66e:	ec06                	sd	ra,24(sp)
 670:	e822                	sd	s0,16(sp)
 672:	1000                	addi	s0,sp,32
 674:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 678:	4605                	li	a2,1
 67a:	fef40593          	addi	a1,s0,-17
 67e:	00000097          	auipc	ra,0x0
 682:	f5e080e7          	jalr	-162(ra) # 5dc <write>
}
 686:	60e2                	ld	ra,24(sp)
 688:	6442                	ld	s0,16(sp)
 68a:	6105                	addi	sp,sp,32
 68c:	8082                	ret

000000000000068e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 68e:	7139                	addi	sp,sp,-64
 690:	fc06                	sd	ra,56(sp)
 692:	f822                	sd	s0,48(sp)
 694:	f426                	sd	s1,40(sp)
 696:	f04a                	sd	s2,32(sp)
 698:	ec4e                	sd	s3,24(sp)
 69a:	0080                	addi	s0,sp,64
 69c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 69e:	c299                	beqz	a3,6a4 <printint+0x16>
 6a0:	0805c863          	bltz	a1,730 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6a4:	2581                	sext.w	a1,a1
  neg = 0;
 6a6:	4881                	li	a7,0
 6a8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6ac:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6ae:	2601                	sext.w	a2,a2
 6b0:	00000517          	auipc	a0,0x0
 6b4:	4e850513          	addi	a0,a0,1256 # b98 <digits>
 6b8:	883a                	mv	a6,a4
 6ba:	2705                	addiw	a4,a4,1
 6bc:	02c5f7bb          	remuw	a5,a1,a2
 6c0:	1782                	slli	a5,a5,0x20
 6c2:	9381                	srli	a5,a5,0x20
 6c4:	97aa                	add	a5,a5,a0
 6c6:	0007c783          	lbu	a5,0(a5)
 6ca:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ce:	0005879b          	sext.w	a5,a1
 6d2:	02c5d5bb          	divuw	a1,a1,a2
 6d6:	0685                	addi	a3,a3,1
 6d8:	fec7f0e3          	bgeu	a5,a2,6b8 <printint+0x2a>
  if(neg)
 6dc:	00088b63          	beqz	a7,6f2 <printint+0x64>
    buf[i++] = '-';
 6e0:	fd040793          	addi	a5,s0,-48
 6e4:	973e                	add	a4,a4,a5
 6e6:	02d00793          	li	a5,45
 6ea:	fef70823          	sb	a5,-16(a4)
 6ee:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6f2:	02e05863          	blez	a4,722 <printint+0x94>
 6f6:	fc040793          	addi	a5,s0,-64
 6fa:	00e78933          	add	s2,a5,a4
 6fe:	fff78993          	addi	s3,a5,-1
 702:	99ba                	add	s3,s3,a4
 704:	377d                	addiw	a4,a4,-1
 706:	1702                	slli	a4,a4,0x20
 708:	9301                	srli	a4,a4,0x20
 70a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 70e:	fff94583          	lbu	a1,-1(s2)
 712:	8526                	mv	a0,s1
 714:	00000097          	auipc	ra,0x0
 718:	f58080e7          	jalr	-168(ra) # 66c <putc>
  while(--i >= 0)
 71c:	197d                	addi	s2,s2,-1
 71e:	ff3918e3          	bne	s2,s3,70e <printint+0x80>
}
 722:	70e2                	ld	ra,56(sp)
 724:	7442                	ld	s0,48(sp)
 726:	74a2                	ld	s1,40(sp)
 728:	7902                	ld	s2,32(sp)
 72a:	69e2                	ld	s3,24(sp)
 72c:	6121                	addi	sp,sp,64
 72e:	8082                	ret
    x = -xx;
 730:	40b005bb          	negw	a1,a1
    neg = 1;
 734:	4885                	li	a7,1
    x = -xx;
 736:	bf8d                	j	6a8 <printint+0x1a>

0000000000000738 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 738:	7119                	addi	sp,sp,-128
 73a:	fc86                	sd	ra,120(sp)
 73c:	f8a2                	sd	s0,112(sp)
 73e:	f4a6                	sd	s1,104(sp)
 740:	f0ca                	sd	s2,96(sp)
 742:	ecce                	sd	s3,88(sp)
 744:	e8d2                	sd	s4,80(sp)
 746:	e4d6                	sd	s5,72(sp)
 748:	e0da                	sd	s6,64(sp)
 74a:	fc5e                	sd	s7,56(sp)
 74c:	f862                	sd	s8,48(sp)
 74e:	f466                	sd	s9,40(sp)
 750:	f06a                	sd	s10,32(sp)
 752:	ec6e                	sd	s11,24(sp)
 754:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 756:	0005c903          	lbu	s2,0(a1)
 75a:	18090f63          	beqz	s2,8f8 <vprintf+0x1c0>
 75e:	8aaa                	mv	s5,a0
 760:	8b32                	mv	s6,a2
 762:	00158493          	addi	s1,a1,1
  state = 0;
 766:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 768:	02500a13          	li	s4,37
      if(c == 'd'){
 76c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 770:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 774:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 778:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 77c:	00000b97          	auipc	s7,0x0
 780:	41cb8b93          	addi	s7,s7,1052 # b98 <digits>
 784:	a839                	j	7a2 <vprintf+0x6a>
        putc(fd, c);
 786:	85ca                	mv	a1,s2
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	ee2080e7          	jalr	-286(ra) # 66c <putc>
 792:	a019                	j	798 <vprintf+0x60>
    } else if(state == '%'){
 794:	01498f63          	beq	s3,s4,7b2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 798:	0485                	addi	s1,s1,1
 79a:	fff4c903          	lbu	s2,-1(s1)
 79e:	14090d63          	beqz	s2,8f8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7a6:	fe0997e3          	bnez	s3,794 <vprintf+0x5c>
      if(c == '%'){
 7aa:	fd479ee3          	bne	a5,s4,786 <vprintf+0x4e>
        state = '%';
 7ae:	89be                	mv	s3,a5
 7b0:	b7e5                	j	798 <vprintf+0x60>
      if(c == 'd'){
 7b2:	05878063          	beq	a5,s8,7f2 <vprintf+0xba>
      } else if(c == 'l') {
 7b6:	05978c63          	beq	a5,s9,80e <vprintf+0xd6>
      } else if(c == 'x') {
 7ba:	07a78863          	beq	a5,s10,82a <vprintf+0xf2>
      } else if(c == 'p') {
 7be:	09b78463          	beq	a5,s11,846 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7c2:	07300713          	li	a4,115
 7c6:	0ce78663          	beq	a5,a4,892 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ca:	06300713          	li	a4,99
 7ce:	0ee78e63          	beq	a5,a4,8ca <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7d2:	11478863          	beq	a5,s4,8e2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7d6:	85d2                	mv	a1,s4
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	e92080e7          	jalr	-366(ra) # 66c <putc>
        putc(fd, c);
 7e2:	85ca                	mv	a1,s2
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e86080e7          	jalr	-378(ra) # 66c <putc>
      }
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b765                	j	798 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7f2:	008b0913          	addi	s2,s6,8
 7f6:	4685                	li	a3,1
 7f8:	4629                	li	a2,10
 7fa:	000b2583          	lw	a1,0(s6)
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	e8e080e7          	jalr	-370(ra) # 68e <printint>
 808:	8b4a                	mv	s6,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b771                	j	798 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 80e:	008b0913          	addi	s2,s6,8
 812:	4681                	li	a3,0
 814:	4629                	li	a2,10
 816:	000b2583          	lw	a1,0(s6)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e72080e7          	jalr	-398(ra) # 68e <printint>
 824:	8b4a                	mv	s6,s2
      state = 0;
 826:	4981                	li	s3,0
 828:	bf85                	j	798 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 82a:	008b0913          	addi	s2,s6,8
 82e:	4681                	li	a3,0
 830:	4641                	li	a2,16
 832:	000b2583          	lw	a1,0(s6)
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	e56080e7          	jalr	-426(ra) # 68e <printint>
 840:	8b4a                	mv	s6,s2
      state = 0;
 842:	4981                	li	s3,0
 844:	bf91                	j	798 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 846:	008b0793          	addi	a5,s6,8
 84a:	f8f43423          	sd	a5,-120(s0)
 84e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 852:	03000593          	li	a1,48
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e14080e7          	jalr	-492(ra) # 66c <putc>
  putc(fd, 'x');
 860:	85ea                	mv	a1,s10
 862:	8556                	mv	a0,s5
 864:	00000097          	auipc	ra,0x0
 868:	e08080e7          	jalr	-504(ra) # 66c <putc>
 86c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86e:	03c9d793          	srli	a5,s3,0x3c
 872:	97de                	add	a5,a5,s7
 874:	0007c583          	lbu	a1,0(a5)
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	df2080e7          	jalr	-526(ra) # 66c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 882:	0992                	slli	s3,s3,0x4
 884:	397d                	addiw	s2,s2,-1
 886:	fe0914e3          	bnez	s2,86e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 88a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 88e:	4981                	li	s3,0
 890:	b721                	j	798 <vprintf+0x60>
        s = va_arg(ap, char*);
 892:	008b0993          	addi	s3,s6,8
 896:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 89a:	02090163          	beqz	s2,8bc <vprintf+0x184>
        while(*s != 0){
 89e:	00094583          	lbu	a1,0(s2)
 8a2:	c9a1                	beqz	a1,8f2 <vprintf+0x1ba>
          putc(fd, *s);
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	dc6080e7          	jalr	-570(ra) # 66c <putc>
          s++;
 8ae:	0905                	addi	s2,s2,1
        while(*s != 0){
 8b0:	00094583          	lbu	a1,0(s2)
 8b4:	f9e5                	bnez	a1,8a4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8b6:	8b4e                	mv	s6,s3
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	bdf9                	j	798 <vprintf+0x60>
          s = "(null)";
 8bc:	00000917          	auipc	s2,0x0
 8c0:	2d490913          	addi	s2,s2,724 # b90 <malloc+0x18e>
        while(*s != 0){
 8c4:	02800593          	li	a1,40
 8c8:	bff1                	j	8a4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8ca:	008b0913          	addi	s2,s6,8
 8ce:	000b4583          	lbu	a1,0(s6)
 8d2:	8556                	mv	a0,s5
 8d4:	00000097          	auipc	ra,0x0
 8d8:	d98080e7          	jalr	-616(ra) # 66c <putc>
 8dc:	8b4a                	mv	s6,s2
      state = 0;
 8de:	4981                	li	s3,0
 8e0:	bd65                	j	798 <vprintf+0x60>
        putc(fd, c);
 8e2:	85d2                	mv	a1,s4
 8e4:	8556                	mv	a0,s5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	d86080e7          	jalr	-634(ra) # 66c <putc>
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	b565                	j	798 <vprintf+0x60>
        s = va_arg(ap, char*);
 8f2:	8b4e                	mv	s6,s3
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b54d                	j	798 <vprintf+0x60>
    }
  }
}
 8f8:	70e6                	ld	ra,120(sp)
 8fa:	7446                	ld	s0,112(sp)
 8fc:	74a6                	ld	s1,104(sp)
 8fe:	7906                	ld	s2,96(sp)
 900:	69e6                	ld	s3,88(sp)
 902:	6a46                	ld	s4,80(sp)
 904:	6aa6                	ld	s5,72(sp)
 906:	6b06                	ld	s6,64(sp)
 908:	7be2                	ld	s7,56(sp)
 90a:	7c42                	ld	s8,48(sp)
 90c:	7ca2                	ld	s9,40(sp)
 90e:	7d02                	ld	s10,32(sp)
 910:	6de2                	ld	s11,24(sp)
 912:	6109                	addi	sp,sp,128
 914:	8082                	ret

0000000000000916 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 916:	715d                	addi	sp,sp,-80
 918:	ec06                	sd	ra,24(sp)
 91a:	e822                	sd	s0,16(sp)
 91c:	1000                	addi	s0,sp,32
 91e:	e010                	sd	a2,0(s0)
 920:	e414                	sd	a3,8(s0)
 922:	e818                	sd	a4,16(s0)
 924:	ec1c                	sd	a5,24(s0)
 926:	03043023          	sd	a6,32(s0)
 92a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 92e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 932:	8622                	mv	a2,s0
 934:	00000097          	auipc	ra,0x0
 938:	e04080e7          	jalr	-508(ra) # 738 <vprintf>
}
 93c:	60e2                	ld	ra,24(sp)
 93e:	6442                	ld	s0,16(sp)
 940:	6161                	addi	sp,sp,80
 942:	8082                	ret

0000000000000944 <printf>:

void
printf(const char *fmt, ...)
{
 944:	711d                	addi	sp,sp,-96
 946:	ec06                	sd	ra,24(sp)
 948:	e822                	sd	s0,16(sp)
 94a:	1000                	addi	s0,sp,32
 94c:	e40c                	sd	a1,8(s0)
 94e:	e810                	sd	a2,16(s0)
 950:	ec14                	sd	a3,24(s0)
 952:	f018                	sd	a4,32(s0)
 954:	f41c                	sd	a5,40(s0)
 956:	03043823          	sd	a6,48(s0)
 95a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 95e:	00840613          	addi	a2,s0,8
 962:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 966:	85aa                	mv	a1,a0
 968:	4505                	li	a0,1
 96a:	00000097          	auipc	ra,0x0
 96e:	dce080e7          	jalr	-562(ra) # 738 <vprintf>
}
 972:	60e2                	ld	ra,24(sp)
 974:	6442                	ld	s0,16(sp)
 976:	6125                	addi	sp,sp,96
 978:	8082                	ret

000000000000097a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 97a:	1141                	addi	sp,sp,-16
 97c:	e422                	sd	s0,8(sp)
 97e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 980:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	00000797          	auipc	a5,0x0
 988:	22c7b783          	ld	a5,556(a5) # bb0 <freep>
 98c:	a805                	j	9bc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 98e:	4618                	lw	a4,8(a2)
 990:	9db9                	addw	a1,a1,a4
 992:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	6398                	ld	a4,0(a5)
 998:	6318                	ld	a4,0(a4)
 99a:	fee53823          	sd	a4,-16(a0)
 99e:	a091                	j	9e2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a0:	ff852703          	lw	a4,-8(a0)
 9a4:	9e39                	addw	a2,a2,a4
 9a6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9a8:	ff053703          	ld	a4,-16(a0)
 9ac:	e398                	sd	a4,0(a5)
 9ae:	a099                	j	9f4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b0:	6398                	ld	a4,0(a5)
 9b2:	00e7e463          	bltu	a5,a4,9ba <free+0x40>
 9b6:	00e6ea63          	bltu	a3,a4,9ca <free+0x50>
{
 9ba:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9bc:	fed7fae3          	bgeu	a5,a3,9b0 <free+0x36>
 9c0:	6398                	ld	a4,0(a5)
 9c2:	00e6e463          	bltu	a3,a4,9ca <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c6:	fee7eae3          	bltu	a5,a4,9ba <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9ca:	ff852583          	lw	a1,-8(a0)
 9ce:	6390                	ld	a2,0(a5)
 9d0:	02059713          	slli	a4,a1,0x20
 9d4:	9301                	srli	a4,a4,0x20
 9d6:	0712                	slli	a4,a4,0x4
 9d8:	9736                	add	a4,a4,a3
 9da:	fae60ae3          	beq	a2,a4,98e <free+0x14>
    bp->s.ptr = p->s.ptr;
 9de:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e2:	4790                	lw	a2,8(a5)
 9e4:	02061713          	slli	a4,a2,0x20
 9e8:	9301                	srli	a4,a4,0x20
 9ea:	0712                	slli	a4,a4,0x4
 9ec:	973e                	add	a4,a4,a5
 9ee:	fae689e3          	beq	a3,a4,9a0 <free+0x26>
  } else
    p->s.ptr = bp;
 9f2:	e394                	sd	a3,0(a5)
  freep = p;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	1af73e23          	sd	a5,444(a4) # bb0 <freep>
}
 9fc:	6422                	ld	s0,8(sp)
 9fe:	0141                	addi	sp,sp,16
 a00:	8082                	ret

0000000000000a02 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a02:	7139                	addi	sp,sp,-64
 a04:	fc06                	sd	ra,56(sp)
 a06:	f822                	sd	s0,48(sp)
 a08:	f426                	sd	s1,40(sp)
 a0a:	f04a                	sd	s2,32(sp)
 a0c:	ec4e                	sd	s3,24(sp)
 a0e:	e852                	sd	s4,16(sp)
 a10:	e456                	sd	s5,8(sp)
 a12:	e05a                	sd	s6,0(sp)
 a14:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a16:	02051493          	slli	s1,a0,0x20
 a1a:	9081                	srli	s1,s1,0x20
 a1c:	04bd                	addi	s1,s1,15
 a1e:	8091                	srli	s1,s1,0x4
 a20:	0014899b          	addiw	s3,s1,1
 a24:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a26:	00000517          	auipc	a0,0x0
 a2a:	18a53503          	ld	a0,394(a0) # bb0 <freep>
 a2e:	c515                	beqz	a0,a5a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a30:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a32:	4798                	lw	a4,8(a5)
 a34:	02977f63          	bgeu	a4,s1,a72 <malloc+0x70>
 a38:	8a4e                	mv	s4,s3
 a3a:	0009871b          	sext.w	a4,s3
 a3e:	6685                	lui	a3,0x1
 a40:	00d77363          	bgeu	a4,a3,a46 <malloc+0x44>
 a44:	6a05                	lui	s4,0x1
 a46:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a4a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a4e:	00000917          	auipc	s2,0x0
 a52:	16290913          	addi	s2,s2,354 # bb0 <freep>
  if(p == (char*)-1)
 a56:	5afd                	li	s5,-1
 a58:	a88d                	j	aca <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 a5a:	00000797          	auipc	a5,0x0
 a5e:	16e78793          	addi	a5,a5,366 # bc8 <base>
 a62:	00000717          	auipc	a4,0x0
 a66:	14f73723          	sd	a5,334(a4) # bb0 <freep>
 a6a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a6c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a70:	b7e1                	j	a38 <malloc+0x36>
      if(p->s.size == nunits)
 a72:	02e48b63          	beq	s1,a4,aa8 <malloc+0xa6>
        p->s.size -= nunits;
 a76:	4137073b          	subw	a4,a4,s3
 a7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7c:	1702                	slli	a4,a4,0x20
 a7e:	9301                	srli	a4,a4,0x20
 a80:	0712                	slli	a4,a4,0x4
 a82:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a84:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a88:	00000717          	auipc	a4,0x0
 a8c:	12a73423          	sd	a0,296(a4) # bb0 <freep>
      return (void*)(p + 1);
 a90:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a94:	70e2                	ld	ra,56(sp)
 a96:	7442                	ld	s0,48(sp)
 a98:	74a2                	ld	s1,40(sp)
 a9a:	7902                	ld	s2,32(sp)
 a9c:	69e2                	ld	s3,24(sp)
 a9e:	6a42                	ld	s4,16(sp)
 aa0:	6aa2                	ld	s5,8(sp)
 aa2:	6b02                	ld	s6,0(sp)
 aa4:	6121                	addi	sp,sp,64
 aa6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aa8:	6398                	ld	a4,0(a5)
 aaa:	e118                	sd	a4,0(a0)
 aac:	bff1                	j	a88 <malloc+0x86>
  hp->s.size = nu;
 aae:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ab2:	0541                	addi	a0,a0,16
 ab4:	00000097          	auipc	ra,0x0
 ab8:	ec6080e7          	jalr	-314(ra) # 97a <free>
  return freep;
 abc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ac0:	d971                	beqz	a0,a94 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac4:	4798                	lw	a4,8(a5)
 ac6:	fa9776e3          	bgeu	a4,s1,a72 <malloc+0x70>
    if(p == freep)
 aca:	00093703          	ld	a4,0(s2)
 ace:	853e                	mv	a0,a5
 ad0:	fef719e3          	bne	a4,a5,ac2 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 ad4:	8552                	mv	a0,s4
 ad6:	00000097          	auipc	ra,0x0
 ada:	b6e080e7          	jalr	-1170(ra) # 644 <sbrk>
  if(p == (char*)-1)
 ade:	fd5518e3          	bne	a0,s5,aae <malloc+0xac>
        return 0;
 ae2:	4501                	li	a0,0
 ae4:	bf45                	j	a94 <malloc+0x92>
