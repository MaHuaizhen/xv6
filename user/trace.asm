
user/_trace：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <trace_atoi>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

uint64 trace_atoi(const char *s)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  uint64 n;

  n = 0;
  while('0' <= *s && *s <= '9')
   6:	00054603          	lbu	a2,0(a0)
   a:	fd06079b          	addiw	a5,a2,-48
   e:	0ff7f793          	andi	a5,a5,255
  12:	4725                	li	a4,9
  14:	02f76863          	bltu	a4,a5,44 <trace_atoi+0x44>
  18:	86aa                	mv	a3,a0
  n = 0;
  1a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
  1c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
  1e:	0685                	addi	a3,a3,1
  20:	00251793          	slli	a5,a0,0x2
  24:	97aa                	add	a5,a5,a0
  26:	0786                	slli	a5,a5,0x1
  28:	97b2                	add	a5,a5,a2
  2a:	fd078513          	addi	a0,a5,-48
  while('0' <= *s && *s <= '9')
  2e:	0006c603          	lbu	a2,0(a3)
  32:	fd06071b          	addiw	a4,a2,-48
  36:	0ff77713          	andi	a4,a4,255
  3a:	fee5f2e3          	bgeu	a1,a4,1e <trace_atoi+0x1e>
  return n;
}
  3e:	6422                	ld	s0,8(sp)
  40:	0141                	addi	sp,sp,16
  42:	8082                	ret
  n = 0;
  44:	4501                	li	a0,0
  return n;
  46:	bfe5                	j	3e <trace_atoi+0x3e>

0000000000000048 <main>:
int main(int argc,char*argv[])
{
  48:	1101                	addi	sp,sp,-32
  4a:	ec06                	sd	ra,24(sp)
  4c:	e822                	sd	s0,16(sp)
  4e:	e426                	sd	s1,8(sp)
  50:	1000                	addi	s0,sp,32
  52:	84ae                	mv	s1,a1
    printf("enter trace main\n");
  54:	00000517          	auipc	a0,0x0
  58:	7ec50513          	addi	a0,a0,2028 # 840 <malloc+0xe4>
  5c:	00000097          	auipc	ra,0x0
  60:	642080e7          	jalr	1602(ra) # 69e <printf>
    uint64 TraceId;
    TraceId = trace_atoi(argv[1]);
  64:	6488                	ld	a0,8(s1)
  66:	00000097          	auipc	ra,0x0
  6a:	f9a080e7          	jalr	-102(ra) # 0 <trace_atoi>

    //printf("exec trace\n");
    (void)trace(TraceId);
  6e:	2501                	sext.w	a0,a0
  70:	00000097          	auipc	ra,0x0
  74:	346080e7          	jalr	838(ra) # 3b6 <trace>

    exec(argv[2],&argv[2]);
  78:	01048593          	addi	a1,s1,16
  7c:	6888                	ld	a0,16(s1)
  7e:	00000097          	auipc	ra,0x0
  82:	2d0080e7          	jalr	720(ra) # 34e <exec>
    printf("trace exec fail\n");
  86:	00000517          	auipc	a0,0x0
  8a:	7d250513          	addi	a0,a0,2002 # 858 <malloc+0xfc>
  8e:	00000097          	auipc	ra,0x0
  92:	610080e7          	jalr	1552(ra) # 69e <printf>
    exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	27e080e7          	jalr	638(ra) # 316 <exit>

00000000000000a0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a6:	87aa                	mv	a5,a0
  a8:	0585                	addi	a1,a1,1
  aa:	0785                	addi	a5,a5,1
  ac:	fff5c703          	lbu	a4,-1(a1)
  b0:	fee78fa3          	sb	a4,-1(a5)
  b4:	fb75                	bnez	a4,a8 <strcpy+0x8>
    ;
  return os;
}
  b6:	6422                	ld	s0,8(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e422                	sd	s0,8(sp)
  c0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	cb91                	beqz	a5,da <strcmp+0x1e>
  c8:	0005c703          	lbu	a4,0(a1)
  cc:	00f71763          	bne	a4,a5,da <strcmp+0x1e>
    p++, q++;
  d0:	0505                	addi	a0,a0,1
  d2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	fbe5                	bnez	a5,c8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  da:	0005c503          	lbu	a0,0(a1)
}
  de:	40a7853b          	subw	a0,a5,a0
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strlen>:

uint
strlen(const char *s)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cf91                	beqz	a5,10e <strlen+0x26>
  f4:	0505                	addi	a0,a0,1
  f6:	87aa                	mv	a5,a0
  f8:	4685                	li	a3,1
  fa:	9e89                	subw	a3,a3,a0
  fc:	00f6853b          	addw	a0,a3,a5
 100:	0785                	addi	a5,a5,1
 102:	fff7c703          	lbu	a4,-1(a5)
 106:	fb7d                	bnez	a4,fc <strlen+0x14>
    ;
  return n;
}
 108:	6422                	ld	s0,8(sp)
 10a:	0141                	addi	sp,sp,16
 10c:	8082                	ret
  for(n = 0; s[n]; n++)
 10e:	4501                	li	a0,0
 110:	bfe5                	j	108 <strlen+0x20>

0000000000000112 <memset>:

void*
memset(void *dst, int c, uint n)
{
 112:	1141                	addi	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 118:	ce09                	beqz	a2,132 <memset+0x20>
 11a:	87aa                	mv	a5,a0
 11c:	fff6071b          	addiw	a4,a2,-1
 120:	1702                	slli	a4,a4,0x20
 122:	9301                	srli	a4,a4,0x20
 124:	0705                	addi	a4,a4,1
 126:	972a                	add	a4,a4,a0
    cdst[i] = c;
 128:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12c:	0785                	addi	a5,a5,1
 12e:	fee79de3          	bne	a5,a4,128 <memset+0x16>
  }
  return dst;
}
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <strchr>:

char*
strchr(const char *s, char c)
{
 138:	1141                	addi	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cb99                	beqz	a5,158 <strchr+0x20>
    if(*s == c)
 144:	00f58763          	beq	a1,a5,152 <strchr+0x1a>
  for(; *s; s++)
 148:	0505                	addi	a0,a0,1
 14a:	00054783          	lbu	a5,0(a0)
 14e:	fbfd                	bnez	a5,144 <strchr+0xc>
      return (char*)s;
  return 0;
 150:	4501                	li	a0,0
}
 152:	6422                	ld	s0,8(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret
  return 0;
 158:	4501                	li	a0,0
 15a:	bfe5                	j	152 <strchr+0x1a>

000000000000015c <gets>:

char*
gets(char *buf, int max)
{
 15c:	711d                	addi	sp,sp,-96
 15e:	ec86                	sd	ra,88(sp)
 160:	e8a2                	sd	s0,80(sp)
 162:	e4a6                	sd	s1,72(sp)
 164:	e0ca                	sd	s2,64(sp)
 166:	fc4e                	sd	s3,56(sp)
 168:	f852                	sd	s4,48(sp)
 16a:	f456                	sd	s5,40(sp)
 16c:	f05a                	sd	s6,32(sp)
 16e:	ec5e                	sd	s7,24(sp)
 170:	1080                	addi	s0,sp,96
 172:	8baa                	mv	s7,a0
 174:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	892a                	mv	s2,a0
 178:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 17a:	4aa9                	li	s5,10
 17c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 17e:	89a6                	mv	s3,s1
 180:	2485                	addiw	s1,s1,1
 182:	0344d863          	bge	s1,s4,1b2 <gets+0x56>
    cc = read(0, &c, 1);
 186:	4605                	li	a2,1
 188:	faf40593          	addi	a1,s0,-81
 18c:	4501                	li	a0,0
 18e:	00000097          	auipc	ra,0x0
 192:	1a0080e7          	jalr	416(ra) # 32e <read>
    if(cc < 1)
 196:	00a05e63          	blez	a0,1b2 <gets+0x56>
    buf[i++] = c;
 19a:	faf44783          	lbu	a5,-81(s0)
 19e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a2:	01578763          	beq	a5,s5,1b0 <gets+0x54>
 1a6:	0905                	addi	s2,s2,1
 1a8:	fd679be3          	bne	a5,s6,17e <gets+0x22>
  for(i=0; i+1 < max; ){
 1ac:	89a6                	mv	s3,s1
 1ae:	a011                	j	1b2 <gets+0x56>
 1b0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b2:	99de                	add	s3,s3,s7
 1b4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b8:	855e                	mv	a0,s7
 1ba:	60e6                	ld	ra,88(sp)
 1bc:	6446                	ld	s0,80(sp)
 1be:	64a6                	ld	s1,72(sp)
 1c0:	6906                	ld	s2,64(sp)
 1c2:	79e2                	ld	s3,56(sp)
 1c4:	7a42                	ld	s4,48(sp)
 1c6:	7aa2                	ld	s5,40(sp)
 1c8:	7b02                	ld	s6,32(sp)
 1ca:	6be2                	ld	s7,24(sp)
 1cc:	6125                	addi	sp,sp,96
 1ce:	8082                	ret

00000000000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	1101                	addi	sp,sp,-32
 1d2:	ec06                	sd	ra,24(sp)
 1d4:	e822                	sd	s0,16(sp)
 1d6:	e426                	sd	s1,8(sp)
 1d8:	e04a                	sd	s2,0(sp)
 1da:	1000                	addi	s0,sp,32
 1dc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1de:	4581                	li	a1,0
 1e0:	00000097          	auipc	ra,0x0
 1e4:	176080e7          	jalr	374(ra) # 356 <open>
  if(fd < 0)
 1e8:	02054563          	bltz	a0,212 <stat+0x42>
 1ec:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ee:	85ca                	mv	a1,s2
 1f0:	00000097          	auipc	ra,0x0
 1f4:	17e080e7          	jalr	382(ra) # 36e <fstat>
 1f8:	892a                	mv	s2,a0
  close(fd);
 1fa:	8526                	mv	a0,s1
 1fc:	00000097          	auipc	ra,0x0
 200:	142080e7          	jalr	322(ra) # 33e <close>
  return r;
}
 204:	854a                	mv	a0,s2
 206:	60e2                	ld	ra,24(sp)
 208:	6442                	ld	s0,16(sp)
 20a:	64a2                	ld	s1,8(sp)
 20c:	6902                	ld	s2,0(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
    return -1;
 212:	597d                	li	s2,-1
 214:	bfc5                	j	204 <stat+0x34>

0000000000000216 <atoi>:

int
atoi(const char *s)
{
 216:	1141                	addi	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21c:	00054603          	lbu	a2,0(a0)
 220:	fd06079b          	addiw	a5,a2,-48
 224:	0ff7f793          	andi	a5,a5,255
 228:	4725                	li	a4,9
 22a:	02f76963          	bltu	a4,a5,25c <atoi+0x46>
 22e:	86aa                	mv	a3,a0
  n = 0;
 230:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 232:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 234:	0685                	addi	a3,a3,1
 236:	0025179b          	slliw	a5,a0,0x2
 23a:	9fa9                	addw	a5,a5,a0
 23c:	0017979b          	slliw	a5,a5,0x1
 240:	9fb1                	addw	a5,a5,a2
 242:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 246:	0006c603          	lbu	a2,0(a3)
 24a:	fd06071b          	addiw	a4,a2,-48
 24e:	0ff77713          	andi	a4,a4,255
 252:	fee5f1e3          	bgeu	a1,a4,234 <atoi+0x1e>
  return n;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  n = 0;
 25c:	4501                	li	a0,0
 25e:	bfe5                	j	256 <atoi+0x40>

0000000000000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 266:	02b57663          	bgeu	a0,a1,292 <memmove+0x32>
    while(n-- > 0)
 26a:	02c05163          	blez	a2,28c <memmove+0x2c>
 26e:	fff6079b          	addiw	a5,a2,-1
 272:	1782                	slli	a5,a5,0x20
 274:	9381                	srli	a5,a5,0x20
 276:	0785                	addi	a5,a5,1
 278:	97aa                	add	a5,a5,a0
  dst = vdst;
 27a:	872a                	mv	a4,a0
      *dst++ = *src++;
 27c:	0585                	addi	a1,a1,1
 27e:	0705                	addi	a4,a4,1
 280:	fff5c683          	lbu	a3,-1(a1)
 284:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
    dst += n;
 292:	00c50733          	add	a4,a0,a2
    src += n;
 296:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 298:	fec05ae3          	blez	a2,28c <memmove+0x2c>
 29c:	fff6079b          	addiw	a5,a2,-1
 2a0:	1782                	slli	a5,a5,0x20
 2a2:	9381                	srli	a5,a5,0x20
 2a4:	fff7c793          	not	a5,a5
 2a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2aa:	15fd                	addi	a1,a1,-1
 2ac:	177d                	addi	a4,a4,-1
 2ae:	0005c683          	lbu	a3,0(a1)
 2b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b6:	fee79ae3          	bne	a5,a4,2aa <memmove+0x4a>
 2ba:	bfc9                	j	28c <memmove+0x2c>

00000000000002bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c2:	ca05                	beqz	a2,2f2 <memcmp+0x36>
 2c4:	fff6069b          	addiw	a3,a2,-1
 2c8:	1682                	slli	a3,a3,0x20
 2ca:	9281                	srli	a3,a3,0x20
 2cc:	0685                	addi	a3,a3,1
 2ce:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	0005c703          	lbu	a4,0(a1)
 2d8:	00e79863          	bne	a5,a4,2e8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2dc:	0505                	addi	a0,a0,1
    p2++;
 2de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e0:	fed518e3          	bne	a0,a3,2d0 <memcmp+0x14>
  }
  return 0;
 2e4:	4501                	li	a0,0
 2e6:	a019                	j	2ec <memcmp+0x30>
      return *p1 - *p2;
 2e8:	40e7853b          	subw	a0,a5,a4
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret
  return 0;
 2f2:	4501                	li	a0,0
 2f4:	bfe5                	j	2ec <memcmp+0x30>

00000000000002f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2fe:	00000097          	auipc	ra,0x0
 302:	f62080e7          	jalr	-158(ra) # 260 <memmove>
}
 306:	60a2                	ld	ra,8(sp)
 308:	6402                	ld	s0,0(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 30e:	4885                	li	a7,1
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <exit>:
.global exit
exit:
 li a7, SYS_exit
 316:	4889                	li	a7,2
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <wait>:
.global wait
wait:
 li a7, SYS_wait
 31e:	488d                	li	a7,3
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 326:	4891                	li	a7,4
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <read>:
.global read
read:
 li a7, SYS_read
 32e:	4895                	li	a7,5
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <write>:
.global write
write:
 li a7, SYS_write
 336:	48c1                	li	a7,16
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <close>:
.global close
close:
 li a7, SYS_close
 33e:	48d5                	li	a7,21
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <kill>:
.global kill
kill:
 li a7, SYS_kill
 346:	4899                	li	a7,6
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <exec>:
.global exec
exec:
 li a7, SYS_exec
 34e:	489d                	li	a7,7
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <open>:
.global open
open:
 li a7, SYS_open
 356:	48bd                	li	a7,15
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 35e:	48c5                	li	a7,17
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 366:	48c9                	li	a7,18
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 36e:	48a1                	li	a7,8
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <link>:
.global link
link:
 li a7, SYS_link
 376:	48cd                	li	a7,19
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 37e:	48d1                	li	a7,20
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 386:	48a5                	li	a7,9
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <dup>:
.global dup
dup:
 li a7, SYS_dup
 38e:	48a9                	li	a7,10
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 396:	48ad                	li	a7,11
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 39e:	48b1                	li	a7,12
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a6:	48b5                	li	a7,13
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ae:	48b9                	li	a7,14
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3b6:	48d9                	li	a7,22
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3be:	48dd                	li	a7,23
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c6:	1101                	addi	sp,sp,-32
 3c8:	ec06                	sd	ra,24(sp)
 3ca:	e822                	sd	s0,16(sp)
 3cc:	1000                	addi	s0,sp,32
 3ce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d2:	4605                	li	a2,1
 3d4:	fef40593          	addi	a1,s0,-17
 3d8:	00000097          	auipc	ra,0x0
 3dc:	f5e080e7          	jalr	-162(ra) # 336 <write>
}
 3e0:	60e2                	ld	ra,24(sp)
 3e2:	6442                	ld	s0,16(sp)
 3e4:	6105                	addi	sp,sp,32
 3e6:	8082                	ret

00000000000003e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e8:	7139                	addi	sp,sp,-64
 3ea:	fc06                	sd	ra,56(sp)
 3ec:	f822                	sd	s0,48(sp)
 3ee:	f426                	sd	s1,40(sp)
 3f0:	f04a                	sd	s2,32(sp)
 3f2:	ec4e                	sd	s3,24(sp)
 3f4:	0080                	addi	s0,sp,64
 3f6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f8:	c299                	beqz	a3,3fe <printint+0x16>
 3fa:	0805c863          	bltz	a1,48a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3fe:	2581                	sext.w	a1,a1
  neg = 0;
 400:	4881                	li	a7,0
 402:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 406:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 408:	2601                	sext.w	a2,a2
 40a:	00000517          	auipc	a0,0x0
 40e:	46e50513          	addi	a0,a0,1134 # 878 <digits>
 412:	883a                	mv	a6,a4
 414:	2705                	addiw	a4,a4,1
 416:	02c5f7bb          	remuw	a5,a1,a2
 41a:	1782                	slli	a5,a5,0x20
 41c:	9381                	srli	a5,a5,0x20
 41e:	97aa                	add	a5,a5,a0
 420:	0007c783          	lbu	a5,0(a5)
 424:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 428:	0005879b          	sext.w	a5,a1
 42c:	02c5d5bb          	divuw	a1,a1,a2
 430:	0685                	addi	a3,a3,1
 432:	fec7f0e3          	bgeu	a5,a2,412 <printint+0x2a>
  if(neg)
 436:	00088b63          	beqz	a7,44c <printint+0x64>
    buf[i++] = '-';
 43a:	fd040793          	addi	a5,s0,-48
 43e:	973e                	add	a4,a4,a5
 440:	02d00793          	li	a5,45
 444:	fef70823          	sb	a5,-16(a4)
 448:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 44c:	02e05863          	blez	a4,47c <printint+0x94>
 450:	fc040793          	addi	a5,s0,-64
 454:	00e78933          	add	s2,a5,a4
 458:	fff78993          	addi	s3,a5,-1
 45c:	99ba                	add	s3,s3,a4
 45e:	377d                	addiw	a4,a4,-1
 460:	1702                	slli	a4,a4,0x20
 462:	9301                	srli	a4,a4,0x20
 464:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 468:	fff94583          	lbu	a1,-1(s2)
 46c:	8526                	mv	a0,s1
 46e:	00000097          	auipc	ra,0x0
 472:	f58080e7          	jalr	-168(ra) # 3c6 <putc>
  while(--i >= 0)
 476:	197d                	addi	s2,s2,-1
 478:	ff3918e3          	bne	s2,s3,468 <printint+0x80>
}
 47c:	70e2                	ld	ra,56(sp)
 47e:	7442                	ld	s0,48(sp)
 480:	74a2                	ld	s1,40(sp)
 482:	7902                	ld	s2,32(sp)
 484:	69e2                	ld	s3,24(sp)
 486:	6121                	addi	sp,sp,64
 488:	8082                	ret
    x = -xx;
 48a:	40b005bb          	negw	a1,a1
    neg = 1;
 48e:	4885                	li	a7,1
    x = -xx;
 490:	bf8d                	j	402 <printint+0x1a>

0000000000000492 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 492:	7119                	addi	sp,sp,-128
 494:	fc86                	sd	ra,120(sp)
 496:	f8a2                	sd	s0,112(sp)
 498:	f4a6                	sd	s1,104(sp)
 49a:	f0ca                	sd	s2,96(sp)
 49c:	ecce                	sd	s3,88(sp)
 49e:	e8d2                	sd	s4,80(sp)
 4a0:	e4d6                	sd	s5,72(sp)
 4a2:	e0da                	sd	s6,64(sp)
 4a4:	fc5e                	sd	s7,56(sp)
 4a6:	f862                	sd	s8,48(sp)
 4a8:	f466                	sd	s9,40(sp)
 4aa:	f06a                	sd	s10,32(sp)
 4ac:	ec6e                	sd	s11,24(sp)
 4ae:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b0:	0005c903          	lbu	s2,0(a1)
 4b4:	18090f63          	beqz	s2,652 <vprintf+0x1c0>
 4b8:	8aaa                	mv	s5,a0
 4ba:	8b32                	mv	s6,a2
 4bc:	00158493          	addi	s1,a1,1
  state = 0;
 4c0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c2:	02500a13          	li	s4,37
      if(c == 'd'){
 4c6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4ca:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4ce:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4d2:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4d6:	00000b97          	auipc	s7,0x0
 4da:	3a2b8b93          	addi	s7,s7,930 # 878 <digits>
 4de:	a839                	j	4fc <vprintf+0x6a>
        putc(fd, c);
 4e0:	85ca                	mv	a1,s2
 4e2:	8556                	mv	a0,s5
 4e4:	00000097          	auipc	ra,0x0
 4e8:	ee2080e7          	jalr	-286(ra) # 3c6 <putc>
 4ec:	a019                	j	4f2 <vprintf+0x60>
    } else if(state == '%'){
 4ee:	01498f63          	beq	s3,s4,50c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4f2:	0485                	addi	s1,s1,1
 4f4:	fff4c903          	lbu	s2,-1(s1)
 4f8:	14090d63          	beqz	s2,652 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4fc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 500:	fe0997e3          	bnez	s3,4ee <vprintf+0x5c>
      if(c == '%'){
 504:	fd479ee3          	bne	a5,s4,4e0 <vprintf+0x4e>
        state = '%';
 508:	89be                	mv	s3,a5
 50a:	b7e5                	j	4f2 <vprintf+0x60>
      if(c == 'd'){
 50c:	05878063          	beq	a5,s8,54c <vprintf+0xba>
      } else if(c == 'l') {
 510:	05978c63          	beq	a5,s9,568 <vprintf+0xd6>
      } else if(c == 'x') {
 514:	07a78863          	beq	a5,s10,584 <vprintf+0xf2>
      } else if(c == 'p') {
 518:	09b78463          	beq	a5,s11,5a0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 51c:	07300713          	li	a4,115
 520:	0ce78663          	beq	a5,a4,5ec <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 524:	06300713          	li	a4,99
 528:	0ee78e63          	beq	a5,a4,624 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 52c:	11478863          	beq	a5,s4,63c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 530:	85d2                	mv	a1,s4
 532:	8556                	mv	a0,s5
 534:	00000097          	auipc	ra,0x0
 538:	e92080e7          	jalr	-366(ra) # 3c6 <putc>
        putc(fd, c);
 53c:	85ca                	mv	a1,s2
 53e:	8556                	mv	a0,s5
 540:	00000097          	auipc	ra,0x0
 544:	e86080e7          	jalr	-378(ra) # 3c6 <putc>
      }
      state = 0;
 548:	4981                	li	s3,0
 54a:	b765                	j	4f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 54c:	008b0913          	addi	s2,s6,8
 550:	4685                	li	a3,1
 552:	4629                	li	a2,10
 554:	000b2583          	lw	a1,0(s6)
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	e8e080e7          	jalr	-370(ra) # 3e8 <printint>
 562:	8b4a                	mv	s6,s2
      state = 0;
 564:	4981                	li	s3,0
 566:	b771                	j	4f2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 568:	008b0913          	addi	s2,s6,8
 56c:	4681                	li	a3,0
 56e:	4629                	li	a2,10
 570:	000b2583          	lw	a1,0(s6)
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	e72080e7          	jalr	-398(ra) # 3e8 <printint>
 57e:	8b4a                	mv	s6,s2
      state = 0;
 580:	4981                	li	s3,0
 582:	bf85                	j	4f2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 584:	008b0913          	addi	s2,s6,8
 588:	4681                	li	a3,0
 58a:	4641                	li	a2,16
 58c:	000b2583          	lw	a1,0(s6)
 590:	8556                	mv	a0,s5
 592:	00000097          	auipc	ra,0x0
 596:	e56080e7          	jalr	-426(ra) # 3e8 <printint>
 59a:	8b4a                	mv	s6,s2
      state = 0;
 59c:	4981                	li	s3,0
 59e:	bf91                	j	4f2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5a0:	008b0793          	addi	a5,s6,8
 5a4:	f8f43423          	sd	a5,-120(s0)
 5a8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5ac:	03000593          	li	a1,48
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e14080e7          	jalr	-492(ra) # 3c6 <putc>
  putc(fd, 'x');
 5ba:	85ea                	mv	a1,s10
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	e08080e7          	jalr	-504(ra) # 3c6 <putc>
 5c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5c8:	03c9d793          	srli	a5,s3,0x3c
 5cc:	97de                	add	a5,a5,s7
 5ce:	0007c583          	lbu	a1,0(a5)
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	df2080e7          	jalr	-526(ra) # 3c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5dc:	0992                	slli	s3,s3,0x4
 5de:	397d                	addiw	s2,s2,-1
 5e0:	fe0914e3          	bnez	s2,5c8 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5e4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b721                	j	4f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 5ec:	008b0993          	addi	s3,s6,8
 5f0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5f4:	02090163          	beqz	s2,616 <vprintf+0x184>
        while(*s != 0){
 5f8:	00094583          	lbu	a1,0(s2)
 5fc:	c9a1                	beqz	a1,64c <vprintf+0x1ba>
          putc(fd, *s);
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	dc6080e7          	jalr	-570(ra) # 3c6 <putc>
          s++;
 608:	0905                	addi	s2,s2,1
        while(*s != 0){
 60a:	00094583          	lbu	a1,0(s2)
 60e:	f9e5                	bnez	a1,5fe <vprintf+0x16c>
        s = va_arg(ap, char*);
 610:	8b4e                	mv	s6,s3
      state = 0;
 612:	4981                	li	s3,0
 614:	bdf9                	j	4f2 <vprintf+0x60>
          s = "(null)";
 616:	00000917          	auipc	s2,0x0
 61a:	25a90913          	addi	s2,s2,602 # 870 <malloc+0x114>
        while(*s != 0){
 61e:	02800593          	li	a1,40
 622:	bff1                	j	5fe <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 624:	008b0913          	addi	s2,s6,8
 628:	000b4583          	lbu	a1,0(s6)
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	d98080e7          	jalr	-616(ra) # 3c6 <putc>
 636:	8b4a                	mv	s6,s2
      state = 0;
 638:	4981                	li	s3,0
 63a:	bd65                	j	4f2 <vprintf+0x60>
        putc(fd, c);
 63c:	85d2                	mv	a1,s4
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	d86080e7          	jalr	-634(ra) # 3c6 <putc>
      state = 0;
 648:	4981                	li	s3,0
 64a:	b565                	j	4f2 <vprintf+0x60>
        s = va_arg(ap, char*);
 64c:	8b4e                	mv	s6,s3
      state = 0;
 64e:	4981                	li	s3,0
 650:	b54d                	j	4f2 <vprintf+0x60>
    }
  }
}
 652:	70e6                	ld	ra,120(sp)
 654:	7446                	ld	s0,112(sp)
 656:	74a6                	ld	s1,104(sp)
 658:	7906                	ld	s2,96(sp)
 65a:	69e6                	ld	s3,88(sp)
 65c:	6a46                	ld	s4,80(sp)
 65e:	6aa6                	ld	s5,72(sp)
 660:	6b06                	ld	s6,64(sp)
 662:	7be2                	ld	s7,56(sp)
 664:	7c42                	ld	s8,48(sp)
 666:	7ca2                	ld	s9,40(sp)
 668:	7d02                	ld	s10,32(sp)
 66a:	6de2                	ld	s11,24(sp)
 66c:	6109                	addi	sp,sp,128
 66e:	8082                	ret

0000000000000670 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 670:	715d                	addi	sp,sp,-80
 672:	ec06                	sd	ra,24(sp)
 674:	e822                	sd	s0,16(sp)
 676:	1000                	addi	s0,sp,32
 678:	e010                	sd	a2,0(s0)
 67a:	e414                	sd	a3,8(s0)
 67c:	e818                	sd	a4,16(s0)
 67e:	ec1c                	sd	a5,24(s0)
 680:	03043023          	sd	a6,32(s0)
 684:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 688:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 68c:	8622                	mv	a2,s0
 68e:	00000097          	auipc	ra,0x0
 692:	e04080e7          	jalr	-508(ra) # 492 <vprintf>
}
 696:	60e2                	ld	ra,24(sp)
 698:	6442                	ld	s0,16(sp)
 69a:	6161                	addi	sp,sp,80
 69c:	8082                	ret

000000000000069e <printf>:

void
printf(const char *fmt, ...)
{
 69e:	711d                	addi	sp,sp,-96
 6a0:	ec06                	sd	ra,24(sp)
 6a2:	e822                	sd	s0,16(sp)
 6a4:	1000                	addi	s0,sp,32
 6a6:	e40c                	sd	a1,8(s0)
 6a8:	e810                	sd	a2,16(s0)
 6aa:	ec14                	sd	a3,24(s0)
 6ac:	f018                	sd	a4,32(s0)
 6ae:	f41c                	sd	a5,40(s0)
 6b0:	03043823          	sd	a6,48(s0)
 6b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6b8:	00840613          	addi	a2,s0,8
 6bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6c0:	85aa                	mv	a1,a0
 6c2:	4505                	li	a0,1
 6c4:	00000097          	auipc	ra,0x0
 6c8:	dce080e7          	jalr	-562(ra) # 492 <vprintf>
}
 6cc:	60e2                	ld	ra,24(sp)
 6ce:	6442                	ld	s0,16(sp)
 6d0:	6125                	addi	sp,sp,96
 6d2:	8082                	ret

00000000000006d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d4:	1141                	addi	sp,sp,-16
 6d6:	e422                	sd	s0,8(sp)
 6d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6de:	00000797          	auipc	a5,0x0
 6e2:	1b27b783          	ld	a5,434(a5) # 890 <freep>
 6e6:	a805                	j	716 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6e8:	4618                	lw	a4,8(a2)
 6ea:	9db9                	addw	a1,a1,a4
 6ec:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f0:	6398                	ld	a4,0(a5)
 6f2:	6318                	ld	a4,0(a4)
 6f4:	fee53823          	sd	a4,-16(a0)
 6f8:	a091                	j	73c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6fa:	ff852703          	lw	a4,-8(a0)
 6fe:	9e39                	addw	a2,a2,a4
 700:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 702:	ff053703          	ld	a4,-16(a0)
 706:	e398                	sd	a4,0(a5)
 708:	a099                	j	74e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70a:	6398                	ld	a4,0(a5)
 70c:	00e7e463          	bltu	a5,a4,714 <free+0x40>
 710:	00e6ea63          	bltu	a3,a4,724 <free+0x50>
{
 714:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 716:	fed7fae3          	bgeu	a5,a3,70a <free+0x36>
 71a:	6398                	ld	a4,0(a5)
 71c:	00e6e463          	bltu	a3,a4,724 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	fee7eae3          	bltu	a5,a4,714 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 724:	ff852583          	lw	a1,-8(a0)
 728:	6390                	ld	a2,0(a5)
 72a:	02059713          	slli	a4,a1,0x20
 72e:	9301                	srli	a4,a4,0x20
 730:	0712                	slli	a4,a4,0x4
 732:	9736                	add	a4,a4,a3
 734:	fae60ae3          	beq	a2,a4,6e8 <free+0x14>
    bp->s.ptr = p->s.ptr;
 738:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 73c:	4790                	lw	a2,8(a5)
 73e:	02061713          	slli	a4,a2,0x20
 742:	9301                	srli	a4,a4,0x20
 744:	0712                	slli	a4,a4,0x4
 746:	973e                	add	a4,a4,a5
 748:	fae689e3          	beq	a3,a4,6fa <free+0x26>
  } else
    p->s.ptr = bp;
 74c:	e394                	sd	a3,0(a5)
  freep = p;
 74e:	00000717          	auipc	a4,0x0
 752:	14f73123          	sd	a5,322(a4) # 890 <freep>
}
 756:	6422                	ld	s0,8(sp)
 758:	0141                	addi	sp,sp,16
 75a:	8082                	ret

000000000000075c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 75c:	7139                	addi	sp,sp,-64
 75e:	fc06                	sd	ra,56(sp)
 760:	f822                	sd	s0,48(sp)
 762:	f426                	sd	s1,40(sp)
 764:	f04a                	sd	s2,32(sp)
 766:	ec4e                	sd	s3,24(sp)
 768:	e852                	sd	s4,16(sp)
 76a:	e456                	sd	s5,8(sp)
 76c:	e05a                	sd	s6,0(sp)
 76e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 770:	02051493          	slli	s1,a0,0x20
 774:	9081                	srli	s1,s1,0x20
 776:	04bd                	addi	s1,s1,15
 778:	8091                	srli	s1,s1,0x4
 77a:	0014899b          	addiw	s3,s1,1
 77e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 780:	00000517          	auipc	a0,0x0
 784:	11053503          	ld	a0,272(a0) # 890 <freep>
 788:	c515                	beqz	a0,7b4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 78c:	4798                	lw	a4,8(a5)
 78e:	02977f63          	bgeu	a4,s1,7cc <malloc+0x70>
 792:	8a4e                	mv	s4,s3
 794:	0009871b          	sext.w	a4,s3
 798:	6685                	lui	a3,0x1
 79a:	00d77363          	bgeu	a4,a3,7a0 <malloc+0x44>
 79e:	6a05                	lui	s4,0x1
 7a0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7a4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a8:	00000917          	auipc	s2,0x0
 7ac:	0e890913          	addi	s2,s2,232 # 890 <freep>
  if(p == (char*)-1)
 7b0:	5afd                	li	s5,-1
 7b2:	a88d                	j	824 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7b4:	00000797          	auipc	a5,0x0
 7b8:	0e478793          	addi	a5,a5,228 # 898 <base>
 7bc:	00000717          	auipc	a4,0x0
 7c0:	0cf73a23          	sd	a5,212(a4) # 890 <freep>
 7c4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ca:	b7e1                	j	792 <malloc+0x36>
      if(p->s.size == nunits)
 7cc:	02e48b63          	beq	s1,a4,802 <malloc+0xa6>
        p->s.size -= nunits;
 7d0:	4137073b          	subw	a4,a4,s3
 7d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d6:	1702                	slli	a4,a4,0x20
 7d8:	9301                	srli	a4,a4,0x20
 7da:	0712                	slli	a4,a4,0x4
 7dc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7de:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7e2:	00000717          	auipc	a4,0x0
 7e6:	0aa73723          	sd	a0,174(a4) # 890 <freep>
      return (void*)(p + 1);
 7ea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7ee:	70e2                	ld	ra,56(sp)
 7f0:	7442                	ld	s0,48(sp)
 7f2:	74a2                	ld	s1,40(sp)
 7f4:	7902                	ld	s2,32(sp)
 7f6:	69e2                	ld	s3,24(sp)
 7f8:	6a42                	ld	s4,16(sp)
 7fa:	6aa2                	ld	s5,8(sp)
 7fc:	6b02                	ld	s6,0(sp)
 7fe:	6121                	addi	sp,sp,64
 800:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 802:	6398                	ld	a4,0(a5)
 804:	e118                	sd	a4,0(a0)
 806:	bff1                	j	7e2 <malloc+0x86>
  hp->s.size = nu;
 808:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 80c:	0541                	addi	a0,a0,16
 80e:	00000097          	auipc	ra,0x0
 812:	ec6080e7          	jalr	-314(ra) # 6d4 <free>
  return freep;
 816:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 81a:	d971                	beqz	a0,7ee <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 81e:	4798                	lw	a4,8(a5)
 820:	fa9776e3          	bgeu	a4,s1,7cc <malloc+0x70>
    if(p == freep)
 824:	00093703          	ld	a4,0(s2)
 828:	853e                	mv	a0,a5
 82a:	fef719e3          	bne	a4,a5,81c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 82e:	8552                	mv	a0,s4
 830:	00000097          	auipc	ra,0x0
 834:	b6e080e7          	jalr	-1170(ra) # 39e <sbrk>
  if(p == (char*)-1)
 838:	fd5518e3          	bne	a0,s5,808 <malloc+0xac>
        return 0;
 83c:	4501                	li	a0,0
 83e:	bf45                	j	7ee <malloc+0x92>
