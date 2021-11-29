
user/_primes：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <ProcessSendRec>:
#include "kernel/stat.h"
#include "user/user.h"


void ProcessSendRec(int *buf_input)
{
   0:	712d                	addi	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	1200                	addi	s0,sp,288
    int p[2] = {0};
   a:	fc043c23          	sd	zero,-40(s0)
    //int buf[100] = {0};
    int buf1[30] = {0};
   e:	f6043023          	sd	zero,-160(s0)
  12:	f6043423          	sd	zero,-152(s0)
  16:	f6043823          	sd	zero,-144(s0)
  1a:	f6043c23          	sd	zero,-136(s0)
  1e:	f8043023          	sd	zero,-128(s0)
  22:	f8043423          	sd	zero,-120(s0)
  26:	f8043823          	sd	zero,-112(s0)
  2a:	f8043c23          	sd	zero,-104(s0)
  2e:	fa043023          	sd	zero,-96(s0)
  32:	fa043423          	sd	zero,-88(s0)
  36:	fa043823          	sd	zero,-80(s0)
  3a:	fa043c23          	sd	zero,-72(s0)
  3e:	fc043023          	sd	zero,-64(s0)
  42:	fc043423          	sd	zero,-56(s0)
  46:	fc043823          	sd	zero,-48(s0)
    int buf2[30] = {0};
  4a:	ee043423          	sd	zero,-280(s0)
  4e:	ee043823          	sd	zero,-272(s0)
  52:	ee043c23          	sd	zero,-264(s0)
  56:	f0043023          	sd	zero,-256(s0)
  5a:	f0043423          	sd	zero,-248(s0)
  5e:	f0043823          	sd	zero,-240(s0)
  62:	f0043c23          	sd	zero,-232(s0)
  66:	f2043023          	sd	zero,-224(s0)
  6a:	f2043423          	sd	zero,-216(s0)
  6e:	f2043823          	sd	zero,-208(s0)
  72:	f2043c23          	sd	zero,-200(s0)
  76:	f4043023          	sd	zero,-192(s0)
  7a:	f4043423          	sd	zero,-184(s0)
  7e:	f4043823          	sd	zero,-176(s0)
  82:	f4043c23          	sd	zero,-168(s0)
    int lop1 = 0;
    int lop = 0;
    int i = 0;
    if(buf_input[0] != 0)
  86:	411c                	lw	a5,0(a0)
  88:	e791                	bnez	a5,94 <ProcessSendRec+0x94>
            wait(0);
            close(p[1]);    
        }
    }
   
}
  8a:	60f2                	ld	ra,280(sp)
  8c:	6452                	ld	s0,272(sp)
  8e:	64b2                	ld	s1,264(sp)
  90:	6115                	addi	sp,sp,288
  92:	8082                	ret
  94:	84aa                	mv	s1,a0
        pipe(p);
  96:	fd840513          	addi	a0,s0,-40
  9a:	00000097          	auipc	ra,0x0
  9e:	3ae080e7          	jalr	942(ra) # 448 <pipe>
        if(fork()==0)
  a2:	00000097          	auipc	ra,0x0
  a6:	38e080e7          	jalr	910(ra) # 430 <fork>
  aa:	ed39                	bnez	a0,108 <ProcessSendRec+0x108>
            close(p[1]);
  ac:	fdc42503          	lw	a0,-36(s0)
  b0:	00000097          	auipc	ra,0x0
  b4:	3b0080e7          	jalr	944(ra) # 460 <close>
            if(read(p[0],buf2,sizeof(buf2)) != 0)
  b8:	07800613          	li	a2,120
  bc:	ee840593          	addi	a1,s0,-280
  c0:	fd842503          	lw	a0,-40(s0)
  c4:	00000097          	auipc	ra,0x0
  c8:	38c080e7          	jalr	908(ra) # 450 <read>
  cc:	c51d                	beqz	a0,fa <ProcessSendRec+0xfa>
                while(buf2[lop1] != 0)
  ce:	ee842783          	lw	a5,-280(s0)
  d2:	c799                	beqz	a5,e0 <ProcessSendRec+0xe0>
  d4:	eec40793          	addi	a5,s0,-276
  d8:	0791                	addi	a5,a5,4
  da:	ffc7a703          	lw	a4,-4(a5)
  de:	ff6d                	bnez	a4,d8 <ProcessSendRec+0xd8>
                close(p[0]);
  e0:	fd842503          	lw	a0,-40(s0)
  e4:	00000097          	auipc	ra,0x0
  e8:	37c080e7          	jalr	892(ra) # 460 <close>
                    ProcessSendRec(buf2);
  ec:	ee840513          	addi	a0,s0,-280
  f0:	00000097          	auipc	ra,0x0
  f4:	f10080e7          	jalr	-240(ra) # 0 <ProcessSendRec>
  f8:	bf49                	j	8a <ProcessSendRec+0x8a>
                close(p[0]);
  fa:	fd842503          	lw	a0,-40(s0)
  fe:	00000097          	auipc	ra,0x0
 102:	362080e7          	jalr	866(ra) # 460 <close>
 106:	b751                	j	8a <ProcessSendRec+0x8a>
            close(p[0]);
 108:	fd842503          	lw	a0,-40(s0)
 10c:	00000097          	auipc	ra,0x0
 110:	354080e7          	jalr	852(ra) # 460 <close>
            if(buf_input[0]!=0)
 114:	408c                	lw	a1,0(s1)
 116:	ed89                	bnez	a1,130 <ProcessSendRec+0x130>
            wait(0);
 118:	4501                	li	a0,0
 11a:	00000097          	auipc	ra,0x0
 11e:	326080e7          	jalr	806(ra) # 440 <wait>
            close(p[1]);    
 122:	fdc42503          	lw	a0,-36(s0)
 126:	00000097          	auipc	ra,0x0
 12a:	33a080e7          	jalr	826(ra) # 460 <close>
}
 12e:	bfb1                	j	8a <ProcessSendRec+0x8a>
                printf("prime %d\n",buf_input[0]);
 130:	00001517          	auipc	a0,0x1
 134:	83850513          	addi	a0,a0,-1992 # 968 <malloc+0xea>
 138:	00000097          	auipc	ra,0x0
 13c:	688080e7          	jalr	1672(ra) # 7c0 <printf>
                while(buf_input[i]!=0)
 140:	4090                	lw	a2,0(s1)
 142:	c21d                	beqz	a2,168 <ProcessSendRec+0x168>
 144:	0491                	addi	s1,s1,4
    int lop = 0;
 146:	4681                	li	a3,0
 148:	a011                	j	14c <ProcessSendRec+0x14c>
 14a:	0491                	addi	s1,s1,4
                while(buf_input[i]!=0)
 14c:	409c                	lw	a5,0(s1)
 14e:	cf89                	beqz	a5,168 <ProcessSendRec+0x168>
                    if(buf_input[i] % buf_input[0]!=0)
 150:	02c7e73b          	remw	a4,a5,a2
 154:	db7d                	beqz	a4,14a <ProcessSendRec+0x14a>
                        buf1[lop]=buf_input[i];
 156:	00269713          	slli	a4,a3,0x2
 15a:	fe040593          	addi	a1,s0,-32
 15e:	972e                	add	a4,a4,a1
 160:	f8f72023          	sw	a5,-128(a4)
                        lop ++;
 164:	2685                	addiw	a3,a3,1
 166:	b7d5                	j	14a <ProcessSendRec+0x14a>
                write(p[1],buf1,sizeof(buf1));
 168:	07800613          	li	a2,120
 16c:	f6040593          	addi	a1,s0,-160
 170:	fdc42503          	lw	a0,-36(s0)
 174:	00000097          	auipc	ra,0x0
 178:	2e4080e7          	jalr	740(ra) # 458 <write>
 17c:	bf71                	j	118 <ProcessSendRec+0x118>

000000000000017e <main>:
int main()
{
 17e:	7135                	addi	sp,sp,-160
 180:	ed06                	sd	ra,152(sp)
 182:	e922                	sd	s0,144(sp)
 184:	1100                	addi	s0,sp,160
    //int p[2] = {0};
    int buf[35] = {0};
 186:	08c00613          	li	a2,140
 18a:	4581                	li	a1,0
 18c:	f6040513          	addi	a0,s0,-160
 190:	00000097          	auipc	ra,0x0
 194:	0a4080e7          	jalr	164(ra) # 234 <memset>
    // int buf1[100] = {0};
    // int buf2[100] = {0};
    // int lop1 = 0;
    // int lop = 0;
    // int i = 0;
    for(int k = 0;k <=33;k ++)
 198:	f6040793          	addi	a5,s0,-160
 19c:	fe840693          	addi	a3,s0,-24
    int buf[35] = {0};
 1a0:	4709                	li	a4,2
    {
        buf[k]= k+2;
 1a2:	c398                	sw	a4,0(a5)
    for(int k = 0;k <=33;k ++)
 1a4:	2705                	addiw	a4,a4,1
 1a6:	0791                	addi	a5,a5,4
 1a8:	fed79de3          	bne	a5,a3,1a2 <main+0x24>
        //printf("line15:%d\n",buf[k]);
    }
    ProcessSendRec(buf);
 1ac:	f6040513          	addi	a0,s0,-160
 1b0:	00000097          	auipc	ra,0x0
 1b4:	e50080e7          	jalr	-432(ra) # 0 <ProcessSendRec>
    //         write(p[1],buf1,sizeof(buf1));
    //     }
    //     wait(0);
    //     close(p[1]);    
    // }
    exit(0);
 1b8:	4501                	li	a0,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	27e080e7          	jalr	638(ra) # 438 <exit>

00000000000001c2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c8:	87aa                	mv	a5,a0
 1ca:	0585                	addi	a1,a1,1
 1cc:	0785                	addi	a5,a5,1
 1ce:	fff5c703          	lbu	a4,-1(a1)
 1d2:	fee78fa3          	sb	a4,-1(a5)
 1d6:	fb75                	bnez	a4,1ca <strcpy+0x8>
    ;
  return os;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cb91                	beqz	a5,1fc <strcmp+0x1e>
 1ea:	0005c703          	lbu	a4,0(a1)
 1ee:	00f71763          	bne	a4,a5,1fc <strcmp+0x1e>
    p++, q++;
 1f2:	0505                	addi	a0,a0,1
 1f4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	fbe5                	bnez	a5,1ea <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1fc:	0005c503          	lbu	a0,0(a1)
}
 200:	40a7853b          	subw	a0,a5,a0
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <strlen>:

uint
strlen(const char *s)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 210:	00054783          	lbu	a5,0(a0)
 214:	cf91                	beqz	a5,230 <strlen+0x26>
 216:	0505                	addi	a0,a0,1
 218:	87aa                	mv	a5,a0
 21a:	4685                	li	a3,1
 21c:	9e89                	subw	a3,a3,a0
 21e:	00f6853b          	addw	a0,a3,a5
 222:	0785                	addi	a5,a5,1
 224:	fff7c703          	lbu	a4,-1(a5)
 228:	fb7d                	bnez	a4,21e <strlen+0x14>
    ;
  return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  for(n = 0; s[n]; n++)
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <strlen+0x20>

0000000000000234 <memset>:

void*
memset(void *dst, int c, uint n)
{
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 23a:	ce09                	beqz	a2,254 <memset+0x20>
 23c:	87aa                	mv	a5,a0
 23e:	fff6071b          	addiw	a4,a2,-1
 242:	1702                	slli	a4,a4,0x20
 244:	9301                	srli	a4,a4,0x20
 246:	0705                	addi	a4,a4,1
 248:	972a                	add	a4,a4,a0
    cdst[i] = c;
 24a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 24e:	0785                	addi	a5,a5,1
 250:	fee79de3          	bne	a5,a4,24a <memset+0x16>
  }
  return dst;
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <strchr>:

char*
strchr(const char *s, char c)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 260:	00054783          	lbu	a5,0(a0)
 264:	cb99                	beqz	a5,27a <strchr+0x20>
    if(*s == c)
 266:	00f58763          	beq	a1,a5,274 <strchr+0x1a>
  for(; *s; s++)
 26a:	0505                	addi	a0,a0,1
 26c:	00054783          	lbu	a5,0(a0)
 270:	fbfd                	bnez	a5,266 <strchr+0xc>
      return (char*)s;
  return 0;
 272:	4501                	li	a0,0
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
  return 0;
 27a:	4501                	li	a0,0
 27c:	bfe5                	j	274 <strchr+0x1a>

000000000000027e <gets>:

char*
gets(char *buf, int max)
{
 27e:	711d                	addi	sp,sp,-96
 280:	ec86                	sd	ra,88(sp)
 282:	e8a2                	sd	s0,80(sp)
 284:	e4a6                	sd	s1,72(sp)
 286:	e0ca                	sd	s2,64(sp)
 288:	fc4e                	sd	s3,56(sp)
 28a:	f852                	sd	s4,48(sp)
 28c:	f456                	sd	s5,40(sp)
 28e:	f05a                	sd	s6,32(sp)
 290:	ec5e                	sd	s7,24(sp)
 292:	1080                	addi	s0,sp,96
 294:	8baa                	mv	s7,a0
 296:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 298:	892a                	mv	s2,a0
 29a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 29c:	4aa9                	li	s5,10
 29e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2a0:	89a6                	mv	s3,s1
 2a2:	2485                	addiw	s1,s1,1
 2a4:	0344d863          	bge	s1,s4,2d4 <gets+0x56>
    cc = read(0, &c, 1);
 2a8:	4605                	li	a2,1
 2aa:	faf40593          	addi	a1,s0,-81
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	1a0080e7          	jalr	416(ra) # 450 <read>
    if(cc < 1)
 2b8:	00a05e63          	blez	a0,2d4 <gets+0x56>
    buf[i++] = c;
 2bc:	faf44783          	lbu	a5,-81(s0)
 2c0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2c4:	01578763          	beq	a5,s5,2d2 <gets+0x54>
 2c8:	0905                	addi	s2,s2,1
 2ca:	fd679be3          	bne	a5,s6,2a0 <gets+0x22>
  for(i=0; i+1 < max; ){
 2ce:	89a6                	mv	s3,s1
 2d0:	a011                	j	2d4 <gets+0x56>
 2d2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2d4:	99de                	add	s3,s3,s7
 2d6:	00098023          	sb	zero,0(s3)
  return buf;
}
 2da:	855e                	mv	a0,s7
 2dc:	60e6                	ld	ra,88(sp)
 2de:	6446                	ld	s0,80(sp)
 2e0:	64a6                	ld	s1,72(sp)
 2e2:	6906                	ld	s2,64(sp)
 2e4:	79e2                	ld	s3,56(sp)
 2e6:	7a42                	ld	s4,48(sp)
 2e8:	7aa2                	ld	s5,40(sp)
 2ea:	7b02                	ld	s6,32(sp)
 2ec:	6be2                	ld	s7,24(sp)
 2ee:	6125                	addi	sp,sp,96
 2f0:	8082                	ret

00000000000002f2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f2:	1101                	addi	sp,sp,-32
 2f4:	ec06                	sd	ra,24(sp)
 2f6:	e822                	sd	s0,16(sp)
 2f8:	e426                	sd	s1,8(sp)
 2fa:	e04a                	sd	s2,0(sp)
 2fc:	1000                	addi	s0,sp,32
 2fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 300:	4581                	li	a1,0
 302:	00000097          	auipc	ra,0x0
 306:	176080e7          	jalr	374(ra) # 478 <open>
  if(fd < 0)
 30a:	02054563          	bltz	a0,334 <stat+0x42>
 30e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 310:	85ca                	mv	a1,s2
 312:	00000097          	auipc	ra,0x0
 316:	17e080e7          	jalr	382(ra) # 490 <fstat>
 31a:	892a                	mv	s2,a0
  close(fd);
 31c:	8526                	mv	a0,s1
 31e:	00000097          	auipc	ra,0x0
 322:	142080e7          	jalr	322(ra) # 460 <close>
  return r;
}
 326:	854a                	mv	a0,s2
 328:	60e2                	ld	ra,24(sp)
 32a:	6442                	ld	s0,16(sp)
 32c:	64a2                	ld	s1,8(sp)
 32e:	6902                	ld	s2,0(sp)
 330:	6105                	addi	sp,sp,32
 332:	8082                	ret
    return -1;
 334:	597d                	li	s2,-1
 336:	bfc5                	j	326 <stat+0x34>

0000000000000338 <atoi>:

int
atoi(const char *s)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 33e:	00054603          	lbu	a2,0(a0)
 342:	fd06079b          	addiw	a5,a2,-48
 346:	0ff7f793          	andi	a5,a5,255
 34a:	4725                	li	a4,9
 34c:	02f76963          	bltu	a4,a5,37e <atoi+0x46>
 350:	86aa                	mv	a3,a0
  n = 0;
 352:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 354:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 356:	0685                	addi	a3,a3,1
 358:	0025179b          	slliw	a5,a0,0x2
 35c:	9fa9                	addw	a5,a5,a0
 35e:	0017979b          	slliw	a5,a5,0x1
 362:	9fb1                	addw	a5,a5,a2
 364:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 368:	0006c603          	lbu	a2,0(a3)
 36c:	fd06071b          	addiw	a4,a2,-48
 370:	0ff77713          	andi	a4,a4,255
 374:	fee5f1e3          	bgeu	a1,a4,356 <atoi+0x1e>
  return n;
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret
  n = 0;
 37e:	4501                	li	a0,0
 380:	bfe5                	j	378 <atoi+0x40>

0000000000000382 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 388:	02b57663          	bgeu	a0,a1,3b4 <memmove+0x32>
    while(n-- > 0)
 38c:	02c05163          	blez	a2,3ae <memmove+0x2c>
 390:	fff6079b          	addiw	a5,a2,-1
 394:	1782                	slli	a5,a5,0x20
 396:	9381                	srli	a5,a5,0x20
 398:	0785                	addi	a5,a5,1
 39a:	97aa                	add	a5,a5,a0
  dst = vdst;
 39c:	872a                	mv	a4,a0
      *dst++ = *src++;
 39e:	0585                	addi	a1,a1,1
 3a0:	0705                	addi	a4,a4,1
 3a2:	fff5c683          	lbu	a3,-1(a1)
 3a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3aa:	fee79ae3          	bne	a5,a4,39e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ae:	6422                	ld	s0,8(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
    dst += n;
 3b4:	00c50733          	add	a4,a0,a2
    src += n;
 3b8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ba:	fec05ae3          	blez	a2,3ae <memmove+0x2c>
 3be:	fff6079b          	addiw	a5,a2,-1
 3c2:	1782                	slli	a5,a5,0x20
 3c4:	9381                	srli	a5,a5,0x20
 3c6:	fff7c793          	not	a5,a5
 3ca:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3cc:	15fd                	addi	a1,a1,-1
 3ce:	177d                	addi	a4,a4,-1
 3d0:	0005c683          	lbu	a3,0(a1)
 3d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3d8:	fee79ae3          	bne	a5,a4,3cc <memmove+0x4a>
 3dc:	bfc9                	j	3ae <memmove+0x2c>

00000000000003de <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3e4:	ca05                	beqz	a2,414 <memcmp+0x36>
 3e6:	fff6069b          	addiw	a3,a2,-1
 3ea:	1682                	slli	a3,a3,0x20
 3ec:	9281                	srli	a3,a3,0x20
 3ee:	0685                	addi	a3,a3,1
 3f0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3f2:	00054783          	lbu	a5,0(a0)
 3f6:	0005c703          	lbu	a4,0(a1)
 3fa:	00e79863          	bne	a5,a4,40a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3fe:	0505                	addi	a0,a0,1
    p2++;
 400:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 402:	fed518e3          	bne	a0,a3,3f2 <memcmp+0x14>
  }
  return 0;
 406:	4501                	li	a0,0
 408:	a019                	j	40e <memcmp+0x30>
      return *p1 - *p2;
 40a:	40e7853b          	subw	a0,a5,a4
}
 40e:	6422                	ld	s0,8(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret
  return 0;
 414:	4501                	li	a0,0
 416:	bfe5                	j	40e <memcmp+0x30>

0000000000000418 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 418:	1141                	addi	sp,sp,-16
 41a:	e406                	sd	ra,8(sp)
 41c:	e022                	sd	s0,0(sp)
 41e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 420:	00000097          	auipc	ra,0x0
 424:	f62080e7          	jalr	-158(ra) # 382 <memmove>
}
 428:	60a2                	ld	ra,8(sp)
 42a:	6402                	ld	s0,0(sp)
 42c:	0141                	addi	sp,sp,16
 42e:	8082                	ret

0000000000000430 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 430:	4885                	li	a7,1
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <exit>:
.global exit
exit:
 li a7, SYS_exit
 438:	4889                	li	a7,2
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <wait>:
.global wait
wait:
 li a7, SYS_wait
 440:	488d                	li	a7,3
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 448:	4891                	li	a7,4
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <read>:
.global read
read:
 li a7, SYS_read
 450:	4895                	li	a7,5
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <write>:
.global write
write:
 li a7, SYS_write
 458:	48c1                	li	a7,16
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <close>:
.global close
close:
 li a7, SYS_close
 460:	48d5                	li	a7,21
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <kill>:
.global kill
kill:
 li a7, SYS_kill
 468:	4899                	li	a7,6
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <exec>:
.global exec
exec:
 li a7, SYS_exec
 470:	489d                	li	a7,7
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <open>:
.global open
open:
 li a7, SYS_open
 478:	48bd                	li	a7,15
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 480:	48c5                	li	a7,17
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 488:	48c9                	li	a7,18
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 490:	48a1                	li	a7,8
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <link>:
.global link
link:
 li a7, SYS_link
 498:	48cd                	li	a7,19
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4a0:	48d1                	li	a7,20
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4a8:	48a5                	li	a7,9
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4b0:	48a9                	li	a7,10
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4b8:	48ad                	li	a7,11
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4c0:	48b1                	li	a7,12
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4c8:	48b5                	li	a7,13
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4d0:	48b9                	li	a7,14
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4d8:	48d9                	li	a7,22
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4e0:	48dd                	li	a7,23
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e8:	1101                	addi	sp,sp,-32
 4ea:	ec06                	sd	ra,24(sp)
 4ec:	e822                	sd	s0,16(sp)
 4ee:	1000                	addi	s0,sp,32
 4f0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4f4:	4605                	li	a2,1
 4f6:	fef40593          	addi	a1,s0,-17
 4fa:	00000097          	auipc	ra,0x0
 4fe:	f5e080e7          	jalr	-162(ra) # 458 <write>
}
 502:	60e2                	ld	ra,24(sp)
 504:	6442                	ld	s0,16(sp)
 506:	6105                	addi	sp,sp,32
 508:	8082                	ret

000000000000050a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50a:	7139                	addi	sp,sp,-64
 50c:	fc06                	sd	ra,56(sp)
 50e:	f822                	sd	s0,48(sp)
 510:	f426                	sd	s1,40(sp)
 512:	f04a                	sd	s2,32(sp)
 514:	ec4e                	sd	s3,24(sp)
 516:	0080                	addi	s0,sp,64
 518:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 51a:	c299                	beqz	a3,520 <printint+0x16>
 51c:	0805c863          	bltz	a1,5ac <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 520:	2581                	sext.w	a1,a1
  neg = 0;
 522:	4881                	li	a7,0
 524:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 528:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 52a:	2601                	sext.w	a2,a2
 52c:	00000517          	auipc	a0,0x0
 530:	45450513          	addi	a0,a0,1108 # 980 <digits>
 534:	883a                	mv	a6,a4
 536:	2705                	addiw	a4,a4,1
 538:	02c5f7bb          	remuw	a5,a1,a2
 53c:	1782                	slli	a5,a5,0x20
 53e:	9381                	srli	a5,a5,0x20
 540:	97aa                	add	a5,a5,a0
 542:	0007c783          	lbu	a5,0(a5)
 546:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 54a:	0005879b          	sext.w	a5,a1
 54e:	02c5d5bb          	divuw	a1,a1,a2
 552:	0685                	addi	a3,a3,1
 554:	fec7f0e3          	bgeu	a5,a2,534 <printint+0x2a>
  if(neg)
 558:	00088b63          	beqz	a7,56e <printint+0x64>
    buf[i++] = '-';
 55c:	fd040793          	addi	a5,s0,-48
 560:	973e                	add	a4,a4,a5
 562:	02d00793          	li	a5,45
 566:	fef70823          	sb	a5,-16(a4)
 56a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 56e:	02e05863          	blez	a4,59e <printint+0x94>
 572:	fc040793          	addi	a5,s0,-64
 576:	00e78933          	add	s2,a5,a4
 57a:	fff78993          	addi	s3,a5,-1
 57e:	99ba                	add	s3,s3,a4
 580:	377d                	addiw	a4,a4,-1
 582:	1702                	slli	a4,a4,0x20
 584:	9301                	srli	a4,a4,0x20
 586:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 58a:	fff94583          	lbu	a1,-1(s2)
 58e:	8526                	mv	a0,s1
 590:	00000097          	auipc	ra,0x0
 594:	f58080e7          	jalr	-168(ra) # 4e8 <putc>
  while(--i >= 0)
 598:	197d                	addi	s2,s2,-1
 59a:	ff3918e3          	bne	s2,s3,58a <printint+0x80>
}
 59e:	70e2                	ld	ra,56(sp)
 5a0:	7442                	ld	s0,48(sp)
 5a2:	74a2                	ld	s1,40(sp)
 5a4:	7902                	ld	s2,32(sp)
 5a6:	69e2                	ld	s3,24(sp)
 5a8:	6121                	addi	sp,sp,64
 5aa:	8082                	ret
    x = -xx;
 5ac:	40b005bb          	negw	a1,a1
    neg = 1;
 5b0:	4885                	li	a7,1
    x = -xx;
 5b2:	bf8d                	j	524 <printint+0x1a>

00000000000005b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b4:	7119                	addi	sp,sp,-128
 5b6:	fc86                	sd	ra,120(sp)
 5b8:	f8a2                	sd	s0,112(sp)
 5ba:	f4a6                	sd	s1,104(sp)
 5bc:	f0ca                	sd	s2,96(sp)
 5be:	ecce                	sd	s3,88(sp)
 5c0:	e8d2                	sd	s4,80(sp)
 5c2:	e4d6                	sd	s5,72(sp)
 5c4:	e0da                	sd	s6,64(sp)
 5c6:	fc5e                	sd	s7,56(sp)
 5c8:	f862                	sd	s8,48(sp)
 5ca:	f466                	sd	s9,40(sp)
 5cc:	f06a                	sd	s10,32(sp)
 5ce:	ec6e                	sd	s11,24(sp)
 5d0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5d2:	0005c903          	lbu	s2,0(a1)
 5d6:	18090f63          	beqz	s2,774 <vprintf+0x1c0>
 5da:	8aaa                	mv	s5,a0
 5dc:	8b32                	mv	s6,a2
 5de:	00158493          	addi	s1,a1,1
  state = 0;
 5e2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5e4:	02500a13          	li	s4,37
      if(c == 'd'){
 5e8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5ec:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5f0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5f4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5f8:	00000b97          	auipc	s7,0x0
 5fc:	388b8b93          	addi	s7,s7,904 # 980 <digits>
 600:	a839                	j	61e <vprintf+0x6a>
        putc(fd, c);
 602:	85ca                	mv	a1,s2
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	ee2080e7          	jalr	-286(ra) # 4e8 <putc>
 60e:	a019                	j	614 <vprintf+0x60>
    } else if(state == '%'){
 610:	01498f63          	beq	s3,s4,62e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 614:	0485                	addi	s1,s1,1
 616:	fff4c903          	lbu	s2,-1(s1)
 61a:	14090d63          	beqz	s2,774 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 61e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 622:	fe0997e3          	bnez	s3,610 <vprintf+0x5c>
      if(c == '%'){
 626:	fd479ee3          	bne	a5,s4,602 <vprintf+0x4e>
        state = '%';
 62a:	89be                	mv	s3,a5
 62c:	b7e5                	j	614 <vprintf+0x60>
      if(c == 'd'){
 62e:	05878063          	beq	a5,s8,66e <vprintf+0xba>
      } else if(c == 'l') {
 632:	05978c63          	beq	a5,s9,68a <vprintf+0xd6>
      } else if(c == 'x') {
 636:	07a78863          	beq	a5,s10,6a6 <vprintf+0xf2>
      } else if(c == 'p') {
 63a:	09b78463          	beq	a5,s11,6c2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 63e:	07300713          	li	a4,115
 642:	0ce78663          	beq	a5,a4,70e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 646:	06300713          	li	a4,99
 64a:	0ee78e63          	beq	a5,a4,746 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 64e:	11478863          	beq	a5,s4,75e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 652:	85d2                	mv	a1,s4
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	e92080e7          	jalr	-366(ra) # 4e8 <putc>
        putc(fd, c);
 65e:	85ca                	mv	a1,s2
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e86080e7          	jalr	-378(ra) # 4e8 <putc>
      }
      state = 0;
 66a:	4981                	li	s3,0
 66c:	b765                	j	614 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 66e:	008b0913          	addi	s2,s6,8
 672:	4685                	li	a3,1
 674:	4629                	li	a2,10
 676:	000b2583          	lw	a1,0(s6)
 67a:	8556                	mv	a0,s5
 67c:	00000097          	auipc	ra,0x0
 680:	e8e080e7          	jalr	-370(ra) # 50a <printint>
 684:	8b4a                	mv	s6,s2
      state = 0;
 686:	4981                	li	s3,0
 688:	b771                	j	614 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68a:	008b0913          	addi	s2,s6,8
 68e:	4681                	li	a3,0
 690:	4629                	li	a2,10
 692:	000b2583          	lw	a1,0(s6)
 696:	8556                	mv	a0,s5
 698:	00000097          	auipc	ra,0x0
 69c:	e72080e7          	jalr	-398(ra) # 50a <printint>
 6a0:	8b4a                	mv	s6,s2
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	bf85                	j	614 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6a6:	008b0913          	addi	s2,s6,8
 6aa:	4681                	li	a3,0
 6ac:	4641                	li	a2,16
 6ae:	000b2583          	lw	a1,0(s6)
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	e56080e7          	jalr	-426(ra) # 50a <printint>
 6bc:	8b4a                	mv	s6,s2
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	bf91                	j	614 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6c2:	008b0793          	addi	a5,s6,8
 6c6:	f8f43423          	sd	a5,-120(s0)
 6ca:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6ce:	03000593          	li	a1,48
 6d2:	8556                	mv	a0,s5
 6d4:	00000097          	auipc	ra,0x0
 6d8:	e14080e7          	jalr	-492(ra) # 4e8 <putc>
  putc(fd, 'x');
 6dc:	85ea                	mv	a1,s10
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e08080e7          	jalr	-504(ra) # 4e8 <putc>
 6e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ea:	03c9d793          	srli	a5,s3,0x3c
 6ee:	97de                	add	a5,a5,s7
 6f0:	0007c583          	lbu	a1,0(a5)
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	df2080e7          	jalr	-526(ra) # 4e8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6fe:	0992                	slli	s3,s3,0x4
 700:	397d                	addiw	s2,s2,-1
 702:	fe0914e3          	bnez	s2,6ea <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 706:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 70a:	4981                	li	s3,0
 70c:	b721                	j	614 <vprintf+0x60>
        s = va_arg(ap, char*);
 70e:	008b0993          	addi	s3,s6,8
 712:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 716:	02090163          	beqz	s2,738 <vprintf+0x184>
        while(*s != 0){
 71a:	00094583          	lbu	a1,0(s2)
 71e:	c9a1                	beqz	a1,76e <vprintf+0x1ba>
          putc(fd, *s);
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	dc6080e7          	jalr	-570(ra) # 4e8 <putc>
          s++;
 72a:	0905                	addi	s2,s2,1
        while(*s != 0){
 72c:	00094583          	lbu	a1,0(s2)
 730:	f9e5                	bnez	a1,720 <vprintf+0x16c>
        s = va_arg(ap, char*);
 732:	8b4e                	mv	s6,s3
      state = 0;
 734:	4981                	li	s3,0
 736:	bdf9                	j	614 <vprintf+0x60>
          s = "(null)";
 738:	00000917          	auipc	s2,0x0
 73c:	24090913          	addi	s2,s2,576 # 978 <malloc+0xfa>
        while(*s != 0){
 740:	02800593          	li	a1,40
 744:	bff1                	j	720 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 746:	008b0913          	addi	s2,s6,8
 74a:	000b4583          	lbu	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	d98080e7          	jalr	-616(ra) # 4e8 <putc>
 758:	8b4a                	mv	s6,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bd65                	j	614 <vprintf+0x60>
        putc(fd, c);
 75e:	85d2                	mv	a1,s4
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	d86080e7          	jalr	-634(ra) # 4e8 <putc>
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b565                	j	614 <vprintf+0x60>
        s = va_arg(ap, char*);
 76e:	8b4e                	mv	s6,s3
      state = 0;
 770:	4981                	li	s3,0
 772:	b54d                	j	614 <vprintf+0x60>
    }
  }
}
 774:	70e6                	ld	ra,120(sp)
 776:	7446                	ld	s0,112(sp)
 778:	74a6                	ld	s1,104(sp)
 77a:	7906                	ld	s2,96(sp)
 77c:	69e6                	ld	s3,88(sp)
 77e:	6a46                	ld	s4,80(sp)
 780:	6aa6                	ld	s5,72(sp)
 782:	6b06                	ld	s6,64(sp)
 784:	7be2                	ld	s7,56(sp)
 786:	7c42                	ld	s8,48(sp)
 788:	7ca2                	ld	s9,40(sp)
 78a:	7d02                	ld	s10,32(sp)
 78c:	6de2                	ld	s11,24(sp)
 78e:	6109                	addi	sp,sp,128
 790:	8082                	ret

0000000000000792 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 792:	715d                	addi	sp,sp,-80
 794:	ec06                	sd	ra,24(sp)
 796:	e822                	sd	s0,16(sp)
 798:	1000                	addi	s0,sp,32
 79a:	e010                	sd	a2,0(s0)
 79c:	e414                	sd	a3,8(s0)
 79e:	e818                	sd	a4,16(s0)
 7a0:	ec1c                	sd	a5,24(s0)
 7a2:	03043023          	sd	a6,32(s0)
 7a6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ae:	8622                	mv	a2,s0
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e04080e7          	jalr	-508(ra) # 5b4 <vprintf>
}
 7b8:	60e2                	ld	ra,24(sp)
 7ba:	6442                	ld	s0,16(sp)
 7bc:	6161                	addi	sp,sp,80
 7be:	8082                	ret

00000000000007c0 <printf>:

void
printf(const char *fmt, ...)
{
 7c0:	711d                	addi	sp,sp,-96
 7c2:	ec06                	sd	ra,24(sp)
 7c4:	e822                	sd	s0,16(sp)
 7c6:	1000                	addi	s0,sp,32
 7c8:	e40c                	sd	a1,8(s0)
 7ca:	e810                	sd	a2,16(s0)
 7cc:	ec14                	sd	a3,24(s0)
 7ce:	f018                	sd	a4,32(s0)
 7d0:	f41c                	sd	a5,40(s0)
 7d2:	03043823          	sd	a6,48(s0)
 7d6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7da:	00840613          	addi	a2,s0,8
 7de:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e2:	85aa                	mv	a1,a0
 7e4:	4505                	li	a0,1
 7e6:	00000097          	auipc	ra,0x0
 7ea:	dce080e7          	jalr	-562(ra) # 5b4 <vprintf>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6125                	addi	sp,sp,96
 7f4:	8082                	ret

00000000000007f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f6:	1141                	addi	sp,sp,-16
 7f8:	e422                	sd	s0,8(sp)
 7fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 800:	00000797          	auipc	a5,0x0
 804:	1987b783          	ld	a5,408(a5) # 998 <freep>
 808:	a805                	j	838 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 80a:	4618                	lw	a4,8(a2)
 80c:	9db9                	addw	a1,a1,a4
 80e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 812:	6398                	ld	a4,0(a5)
 814:	6318                	ld	a4,0(a4)
 816:	fee53823          	sd	a4,-16(a0)
 81a:	a091                	j	85e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 81c:	ff852703          	lw	a4,-8(a0)
 820:	9e39                	addw	a2,a2,a4
 822:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 824:	ff053703          	ld	a4,-16(a0)
 828:	e398                	sd	a4,0(a5)
 82a:	a099                	j	870 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82c:	6398                	ld	a4,0(a5)
 82e:	00e7e463          	bltu	a5,a4,836 <free+0x40>
 832:	00e6ea63          	bltu	a3,a4,846 <free+0x50>
{
 836:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 838:	fed7fae3          	bgeu	a5,a3,82c <free+0x36>
 83c:	6398                	ld	a4,0(a5)
 83e:	00e6e463          	bltu	a3,a4,846 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 842:	fee7eae3          	bltu	a5,a4,836 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 846:	ff852583          	lw	a1,-8(a0)
 84a:	6390                	ld	a2,0(a5)
 84c:	02059713          	slli	a4,a1,0x20
 850:	9301                	srli	a4,a4,0x20
 852:	0712                	slli	a4,a4,0x4
 854:	9736                	add	a4,a4,a3
 856:	fae60ae3          	beq	a2,a4,80a <free+0x14>
    bp->s.ptr = p->s.ptr;
 85a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 85e:	4790                	lw	a2,8(a5)
 860:	02061713          	slli	a4,a2,0x20
 864:	9301                	srli	a4,a4,0x20
 866:	0712                	slli	a4,a4,0x4
 868:	973e                	add	a4,a4,a5
 86a:	fae689e3          	beq	a3,a4,81c <free+0x26>
  } else
    p->s.ptr = bp;
 86e:	e394                	sd	a3,0(a5)
  freep = p;
 870:	00000717          	auipc	a4,0x0
 874:	12f73423          	sd	a5,296(a4) # 998 <freep>
}
 878:	6422                	ld	s0,8(sp)
 87a:	0141                	addi	sp,sp,16
 87c:	8082                	ret

000000000000087e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 87e:	7139                	addi	sp,sp,-64
 880:	fc06                	sd	ra,56(sp)
 882:	f822                	sd	s0,48(sp)
 884:	f426                	sd	s1,40(sp)
 886:	f04a                	sd	s2,32(sp)
 888:	ec4e                	sd	s3,24(sp)
 88a:	e852                	sd	s4,16(sp)
 88c:	e456                	sd	s5,8(sp)
 88e:	e05a                	sd	s6,0(sp)
 890:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 892:	02051493          	slli	s1,a0,0x20
 896:	9081                	srli	s1,s1,0x20
 898:	04bd                	addi	s1,s1,15
 89a:	8091                	srli	s1,s1,0x4
 89c:	0014899b          	addiw	s3,s1,1
 8a0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8a2:	00000517          	auipc	a0,0x0
 8a6:	0f653503          	ld	a0,246(a0) # 998 <freep>
 8aa:	c515                	beqz	a0,8d6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ae:	4798                	lw	a4,8(a5)
 8b0:	02977f63          	bgeu	a4,s1,8ee <malloc+0x70>
 8b4:	8a4e                	mv	s4,s3
 8b6:	0009871b          	sext.w	a4,s3
 8ba:	6685                	lui	a3,0x1
 8bc:	00d77363          	bgeu	a4,a3,8c2 <malloc+0x44>
 8c0:	6a05                	lui	s4,0x1
 8c2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ca:	00000917          	auipc	s2,0x0
 8ce:	0ce90913          	addi	s2,s2,206 # 998 <freep>
  if(p == (char*)-1)
 8d2:	5afd                	li	s5,-1
 8d4:	a88d                	j	946 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 8d6:	00000797          	auipc	a5,0x0
 8da:	0ca78793          	addi	a5,a5,202 # 9a0 <base>
 8de:	00000717          	auipc	a4,0x0
 8e2:	0af73d23          	sd	a5,186(a4) # 998 <freep>
 8e6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8e8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ec:	b7e1                	j	8b4 <malloc+0x36>
      if(p->s.size == nunits)
 8ee:	02e48b63          	beq	s1,a4,924 <malloc+0xa6>
        p->s.size -= nunits;
 8f2:	4137073b          	subw	a4,a4,s3
 8f6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f8:	1702                	slli	a4,a4,0x20
 8fa:	9301                	srli	a4,a4,0x20
 8fc:	0712                	slli	a4,a4,0x4
 8fe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 900:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 904:	00000717          	auipc	a4,0x0
 908:	08a73a23          	sd	a0,148(a4) # 998 <freep>
      return (void*)(p + 1);
 90c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 910:	70e2                	ld	ra,56(sp)
 912:	7442                	ld	s0,48(sp)
 914:	74a2                	ld	s1,40(sp)
 916:	7902                	ld	s2,32(sp)
 918:	69e2                	ld	s3,24(sp)
 91a:	6a42                	ld	s4,16(sp)
 91c:	6aa2                	ld	s5,8(sp)
 91e:	6b02                	ld	s6,0(sp)
 920:	6121                	addi	sp,sp,64
 922:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 924:	6398                	ld	a4,0(a5)
 926:	e118                	sd	a4,0(a0)
 928:	bff1                	j	904 <malloc+0x86>
  hp->s.size = nu;
 92a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 92e:	0541                	addi	a0,a0,16
 930:	00000097          	auipc	ra,0x0
 934:	ec6080e7          	jalr	-314(ra) # 7f6 <free>
  return freep;
 938:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 93c:	d971                	beqz	a0,910 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 940:	4798                	lw	a4,8(a5)
 942:	fa9776e3          	bgeu	a4,s1,8ee <malloc+0x70>
    if(p == freep)
 946:	00093703          	ld	a4,0(s2)
 94a:	853e                	mv	a0,a5
 94c:	fef719e3          	bne	a4,a5,93e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 950:	8552                	mv	a0,s4
 952:	00000097          	auipc	ra,0x0
 956:	b6e080e7          	jalr	-1170(ra) # 4c0 <sbrk>
  if(p == (char*)-1)
 95a:	fd5518e3          	bne	a0,s5,92a <malloc+0xac>
        return 0;
 95e:	4501                	li	a0,0
 960:	bf45                	j	910 <malloc+0x92>
