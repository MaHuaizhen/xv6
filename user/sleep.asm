
user/_sleep：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sleep_atoi>:
#include "kernel/stat.h"
#include "user/user.h"


int sleep_atoi(const char *s)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
   6:	00054603          	lbu	a2,0(a0)
   a:	fd06079b          	addiw	a5,a2,-48
   e:	0ff7f793          	andi	a5,a5,255
  12:	4725                	li	a4,9
  14:	02f76963          	bltu	a4,a5,46 <sleep_atoi+0x46>
  18:	86aa                	mv	a3,a0
  n = 0;
  1a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
  1c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
  1e:	0685                	addi	a3,a3,1
  20:	0025179b          	slliw	a5,a0,0x2
  24:	9fa9                	addw	a5,a5,a0
  26:	0017979b          	slliw	a5,a5,0x1
  2a:	9fb1                	addw	a5,a5,a2
  2c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
  30:	0006c603          	lbu	a2,0(a3)
  34:	fd06071b          	addiw	a4,a2,-48
  38:	0ff77713          	andi	a4,a4,255
  3c:	fee5f1e3          	bgeu	a1,a4,1e <sleep_atoi+0x1e>
  return n;
}
  40:	6422                	ld	s0,8(sp)
  42:	0141                	addi	sp,sp,16
  44:	8082                	ret
  n = 0;
  46:	4501                	li	a0,0
  48:	bfe5                	j	40 <sleep_atoi+0x40>

000000000000004a <main>:
int main(int argc, char*argv[])
{
  4a:	7179                	addi	sp,sp,-48
  4c:	f406                	sd	ra,40(sp)
  4e:	f022                	sd	s0,32(sp)
  50:	ec26                	sd	s1,24(sp)
  52:	e84a                	sd	s2,16(sp)
  54:	e44e                	sd	s3,8(sp)
  56:	e052                	sd	s4,0(sp)
  58:	1800                	addi	s0,sp,48
  5a:	89aa                	mv	s3,a0
  5c:	8a2e                	mv	s4,a1
	int sleep_num = 0;
	int argv_cov;
	printf("running sleep program!,argc:%d\n",argc);// argc means arrary's number
  5e:	85aa                	mv	a1,a0
  60:	00001517          	auipc	a0,0x1
  64:	83050513          	addi	a0,a0,-2000 # 890 <malloc+0xe8>
  68:	00000097          	auipc	ra,0x0
  6c:	682080e7          	jalr	1666(ra) # 6ea <printf>
	for (int i = 0; i < argc ; i ++)
  70:	05305e63          	blez	s3,cc <main+0x82>
  74:	8952                	mv	s2,s4
  76:	39fd                	addiw	s3,s3,-1
  78:	1982                	slli	s3,s3,0x20
  7a:	0209d993          	srli	s3,s3,0x20
  7e:	098e                	slli	s3,s3,0x3
  80:	0a21                	addi	s4,s4,8
  82:	99d2                	add	s3,s3,s4
	int sleep_num = 0;
  84:	4481                	li	s1,0
	{
		argv_cov = sleep_atoi(argv[i]);
  86:	00093503          	ld	a0,0(s2)
  8a:	00000097          	auipc	ra,0x0
  8e:	f76080e7          	jalr	-138(ra) # 0 <sleep_atoi>
		sleep_num += sleep_num*10 + argv_cov;
  92:	0024979b          	slliw	a5,s1,0x2
  96:	9fa5                	addw	a5,a5,s1
  98:	0017979b          	slliw	a5,a5,0x1
  9c:	9fa9                	addw	a5,a5,a0
  9e:	9cbd                	addw	s1,s1,a5
	for (int i = 0; i < argc ; i ++)
  a0:	0921                	addi	s2,s2,8
  a2:	ff3912e3          	bne	s2,s3,86 <main+0x3c>
	}
	printf("sleep time:%d \n",sleep_num);
  a6:	85a6                	mv	a1,s1
  a8:	00001517          	auipc	a0,0x1
  ac:	80850513          	addi	a0,a0,-2040 # 8b0 <malloc+0x108>
  b0:	00000097          	auipc	ra,0x0
  b4:	63a080e7          	jalr	1594(ra) # 6ea <printf>
	if(sleep_num < 10000)
  b8:	6789                	lui	a5,0x2
  ba:	70f78793          	addi	a5,a5,1807 # 270f <__global_pointer$+0x1636>
  be:	0297d163          	bge	a5,s1,e0 <main+0x96>
	{
		sleep(sleep_num);
	}
	exit(0);
  c2:	4501                	li	a0,0
  c4:	00000097          	auipc	ra,0x0
  c8:	29e080e7          	jalr	670(ra) # 362 <exit>
	printf("sleep time:%d \n",sleep_num);
  cc:	4581                	li	a1,0
  ce:	00000517          	auipc	a0,0x0
  d2:	7e250513          	addi	a0,a0,2018 # 8b0 <malloc+0x108>
  d6:	00000097          	auipc	ra,0x0
  da:	614080e7          	jalr	1556(ra) # 6ea <printf>
	int sleep_num = 0;
  de:	4481                	li	s1,0
		sleep(sleep_num);
  e0:	8526                	mv	a0,s1
  e2:	00000097          	auipc	ra,0x0
  e6:	310080e7          	jalr	784(ra) # 3f2 <sleep>
  ea:	bfe1                	j	c2 <main+0x78>

00000000000000ec <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f2:	87aa                	mv	a5,a0
  f4:	0585                	addi	a1,a1,1
  f6:	0785                	addi	a5,a5,1
  f8:	fff5c703          	lbu	a4,-1(a1)
  fc:	fee78fa3          	sb	a4,-1(a5)
 100:	fb75                	bnez	a4,f4 <strcpy+0x8>
    ;
  return os;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret

0000000000000108 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb91                	beqz	a5,126 <strcmp+0x1e>
 114:	0005c703          	lbu	a4,0(a1)
 118:	00f71763          	bne	a4,a5,126 <strcmp+0x1e>
    p++, q++;
 11c:	0505                	addi	a0,a0,1
 11e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	fbe5                	bnez	a5,114 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 126:	0005c503          	lbu	a0,0(a1)
}
 12a:	40a7853b          	subw	a0,a5,a0
 12e:	6422                	ld	s0,8(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strlen>:

uint
strlen(const char *s)
{
 134:	1141                	addi	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cf91                	beqz	a5,15a <strlen+0x26>
 140:	0505                	addi	a0,a0,1
 142:	87aa                	mv	a5,a0
 144:	4685                	li	a3,1
 146:	9e89                	subw	a3,a3,a0
 148:	00f6853b          	addw	a0,a3,a5
 14c:	0785                	addi	a5,a5,1
 14e:	fff7c703          	lbu	a4,-1(a5)
 152:	fb7d                	bnez	a4,148 <strlen+0x14>
    ;
  return n;
}
 154:	6422                	ld	s0,8(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret
  for(n = 0; s[n]; n++)
 15a:	4501                	li	a0,0
 15c:	bfe5                	j	154 <strlen+0x20>

000000000000015e <memset>:

void*
memset(void *dst, int c, uint n)
{
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 164:	ce09                	beqz	a2,17e <memset+0x20>
 166:	87aa                	mv	a5,a0
 168:	fff6071b          	addiw	a4,a2,-1
 16c:	1702                	slli	a4,a4,0x20
 16e:	9301                	srli	a4,a4,0x20
 170:	0705                	addi	a4,a4,1
 172:	972a                	add	a4,a4,a0
    cdst[i] = c;
 174:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 178:	0785                	addi	a5,a5,1
 17a:	fee79de3          	bne	a5,a4,174 <memset+0x16>
  }
  return dst;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	addi	sp,sp,16
 182:	8082                	ret

0000000000000184 <strchr>:

char*
strchr(const char *s, char c)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  for(; *s; s++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cb99                	beqz	a5,1a4 <strchr+0x20>
    if(*s == c)
 190:	00f58763          	beq	a1,a5,19e <strchr+0x1a>
  for(; *s; s++)
 194:	0505                	addi	a0,a0,1
 196:	00054783          	lbu	a5,0(a0)
 19a:	fbfd                	bnez	a5,190 <strchr+0xc>
      return (char*)s;
  return 0;
 19c:	4501                	li	a0,0
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret
  return 0;
 1a4:	4501                	li	a0,0
 1a6:	bfe5                	j	19e <strchr+0x1a>

00000000000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	711d                	addi	sp,sp,-96
 1aa:	ec86                	sd	ra,88(sp)
 1ac:	e8a2                	sd	s0,80(sp)
 1ae:	e4a6                	sd	s1,72(sp)
 1b0:	e0ca                	sd	s2,64(sp)
 1b2:	fc4e                	sd	s3,56(sp)
 1b4:	f852                	sd	s4,48(sp)
 1b6:	f456                	sd	s5,40(sp)
 1b8:	f05a                	sd	s6,32(sp)
 1ba:	ec5e                	sd	s7,24(sp)
 1bc:	1080                	addi	s0,sp,96
 1be:	8baa                	mv	s7,a0
 1c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c2:	892a                	mv	s2,a0
 1c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c6:	4aa9                	li	s5,10
 1c8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ca:	89a6                	mv	s3,s1
 1cc:	2485                	addiw	s1,s1,1
 1ce:	0344d863          	bge	s1,s4,1fe <gets+0x56>
    cc = read(0, &c, 1);
 1d2:	4605                	li	a2,1
 1d4:	faf40593          	addi	a1,s0,-81
 1d8:	4501                	li	a0,0
 1da:	00000097          	auipc	ra,0x0
 1de:	1a0080e7          	jalr	416(ra) # 37a <read>
    if(cc < 1)
 1e2:	00a05e63          	blez	a0,1fe <gets+0x56>
    buf[i++] = c;
 1e6:	faf44783          	lbu	a5,-81(s0)
 1ea:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ee:	01578763          	beq	a5,s5,1fc <gets+0x54>
 1f2:	0905                	addi	s2,s2,1
 1f4:	fd679be3          	bne	a5,s6,1ca <gets+0x22>
  for(i=0; i+1 < max; ){
 1f8:	89a6                	mv	s3,s1
 1fa:	a011                	j	1fe <gets+0x56>
 1fc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1fe:	99de                	add	s3,s3,s7
 200:	00098023          	sb	zero,0(s3)
  return buf;
}
 204:	855e                	mv	a0,s7
 206:	60e6                	ld	ra,88(sp)
 208:	6446                	ld	s0,80(sp)
 20a:	64a6                	ld	s1,72(sp)
 20c:	6906                	ld	s2,64(sp)
 20e:	79e2                	ld	s3,56(sp)
 210:	7a42                	ld	s4,48(sp)
 212:	7aa2                	ld	s5,40(sp)
 214:	7b02                	ld	s6,32(sp)
 216:	6be2                	ld	s7,24(sp)
 218:	6125                	addi	sp,sp,96
 21a:	8082                	ret

000000000000021c <stat>:

int
stat(const char *n, struct stat *st)
{
 21c:	1101                	addi	sp,sp,-32
 21e:	ec06                	sd	ra,24(sp)
 220:	e822                	sd	s0,16(sp)
 222:	e426                	sd	s1,8(sp)
 224:	e04a                	sd	s2,0(sp)
 226:	1000                	addi	s0,sp,32
 228:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22a:	4581                	li	a1,0
 22c:	00000097          	auipc	ra,0x0
 230:	176080e7          	jalr	374(ra) # 3a2 <open>
  if(fd < 0)
 234:	02054563          	bltz	a0,25e <stat+0x42>
 238:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23a:	85ca                	mv	a1,s2
 23c:	00000097          	auipc	ra,0x0
 240:	17e080e7          	jalr	382(ra) # 3ba <fstat>
 244:	892a                	mv	s2,a0
  close(fd);
 246:	8526                	mv	a0,s1
 248:	00000097          	auipc	ra,0x0
 24c:	142080e7          	jalr	322(ra) # 38a <close>
  return r;
}
 250:	854a                	mv	a0,s2
 252:	60e2                	ld	ra,24(sp)
 254:	6442                	ld	s0,16(sp)
 256:	64a2                	ld	s1,8(sp)
 258:	6902                	ld	s2,0(sp)
 25a:	6105                	addi	sp,sp,32
 25c:	8082                	ret
    return -1;
 25e:	597d                	li	s2,-1
 260:	bfc5                	j	250 <stat+0x34>

0000000000000262 <atoi>:

int
atoi(const char *s)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 268:	00054603          	lbu	a2,0(a0)
 26c:	fd06079b          	addiw	a5,a2,-48
 270:	0ff7f793          	andi	a5,a5,255
 274:	4725                	li	a4,9
 276:	02f76963          	bltu	a4,a5,2a8 <atoi+0x46>
 27a:	86aa                	mv	a3,a0
  n = 0;
 27c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 27e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 280:	0685                	addi	a3,a3,1
 282:	0025179b          	slliw	a5,a0,0x2
 286:	9fa9                	addw	a5,a5,a0
 288:	0017979b          	slliw	a5,a5,0x1
 28c:	9fb1                	addw	a5,a5,a2
 28e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 292:	0006c603          	lbu	a2,0(a3)
 296:	fd06071b          	addiw	a4,a2,-48
 29a:	0ff77713          	andi	a4,a4,255
 29e:	fee5f1e3          	bgeu	a1,a4,280 <atoi+0x1e>
  return n;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  n = 0;
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <atoi+0x40>

00000000000002ac <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b2:	02b57663          	bgeu	a0,a1,2de <memmove+0x32>
    while(n-- > 0)
 2b6:	02c05163          	blez	a2,2d8 <memmove+0x2c>
 2ba:	fff6079b          	addiw	a5,a2,-1
 2be:	1782                	slli	a5,a5,0x20
 2c0:	9381                	srli	a5,a5,0x20
 2c2:	0785                	addi	a5,a5,1
 2c4:	97aa                	add	a5,a5,a0
  dst = vdst;
 2c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c8:	0585                	addi	a1,a1,1
 2ca:	0705                	addi	a4,a4,1
 2cc:	fff5c683          	lbu	a3,-1(a1)
 2d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d4:	fee79ae3          	bne	a5,a4,2c8 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
    dst += n;
 2de:	00c50733          	add	a4,a0,a2
    src += n;
 2e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e4:	fec05ae3          	blez	a2,2d8 <memmove+0x2c>
 2e8:	fff6079b          	addiw	a5,a2,-1
 2ec:	1782                	slli	a5,a5,0x20
 2ee:	9381                	srli	a5,a5,0x20
 2f0:	fff7c793          	not	a5,a5
 2f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f6:	15fd                	addi	a1,a1,-1
 2f8:	177d                	addi	a4,a4,-1
 2fa:	0005c683          	lbu	a3,0(a1)
 2fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 302:	fee79ae3          	bne	a5,a4,2f6 <memmove+0x4a>
 306:	bfc9                	j	2d8 <memmove+0x2c>

0000000000000308 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30e:	ca05                	beqz	a2,33e <memcmp+0x36>
 310:	fff6069b          	addiw	a3,a2,-1
 314:	1682                	slli	a3,a3,0x20
 316:	9281                	srli	a3,a3,0x20
 318:	0685                	addi	a3,a3,1
 31a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 31c:	00054783          	lbu	a5,0(a0)
 320:	0005c703          	lbu	a4,0(a1)
 324:	00e79863          	bne	a5,a4,334 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 328:	0505                	addi	a0,a0,1
    p2++;
 32a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 32c:	fed518e3          	bne	a0,a3,31c <memcmp+0x14>
  }
  return 0;
 330:	4501                	li	a0,0
 332:	a019                	j	338 <memcmp+0x30>
      return *p1 - *p2;
 334:	40e7853b          	subw	a0,a5,a4
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
  return 0;
 33e:	4501                	li	a0,0
 340:	bfe5                	j	338 <memcmp+0x30>

0000000000000342 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 342:	1141                	addi	sp,sp,-16
 344:	e406                	sd	ra,8(sp)
 346:	e022                	sd	s0,0(sp)
 348:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 34a:	00000097          	auipc	ra,0x0
 34e:	f62080e7          	jalr	-158(ra) # 2ac <memmove>
}
 352:	60a2                	ld	ra,8(sp)
 354:	6402                	ld	s0,0(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret

000000000000035a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 35a:	4885                	li	a7,1
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <exit>:
.global exit
exit:
 li a7, SYS_exit
 362:	4889                	li	a7,2
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <wait>:
.global wait
wait:
 li a7, SYS_wait
 36a:	488d                	li	a7,3
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 372:	4891                	li	a7,4
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <read>:
.global read
read:
 li a7, SYS_read
 37a:	4895                	li	a7,5
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <write>:
.global write
write:
 li a7, SYS_write
 382:	48c1                	li	a7,16
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <close>:
.global close
close:
 li a7, SYS_close
 38a:	48d5                	li	a7,21
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <kill>:
.global kill
kill:
 li a7, SYS_kill
 392:	4899                	li	a7,6
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <exec>:
.global exec
exec:
 li a7, SYS_exec
 39a:	489d                	li	a7,7
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <open>:
.global open
open:
 li a7, SYS_open
 3a2:	48bd                	li	a7,15
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3aa:	48c5                	li	a7,17
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b2:	48c9                	li	a7,18
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ba:	48a1                	li	a7,8
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <link>:
.global link
link:
 li a7, SYS_link
 3c2:	48cd                	li	a7,19
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ca:	48d1                	li	a7,20
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d2:	48a5                	li	a7,9
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <dup>:
.global dup
dup:
 li a7, SYS_dup
 3da:	48a9                	li	a7,10
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e2:	48ad                	li	a7,11
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ea:	48b1                	li	a7,12
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f2:	48b5                	li	a7,13
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3fa:	48b9                	li	a7,14
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <trace>:
.global trace
trace:
 li a7, SYS_trace
 402:	48d9                	li	a7,22
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 40a:	48dd                	li	a7,23
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 412:	1101                	addi	sp,sp,-32
 414:	ec06                	sd	ra,24(sp)
 416:	e822                	sd	s0,16(sp)
 418:	1000                	addi	s0,sp,32
 41a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 41e:	4605                	li	a2,1
 420:	fef40593          	addi	a1,s0,-17
 424:	00000097          	auipc	ra,0x0
 428:	f5e080e7          	jalr	-162(ra) # 382 <write>
}
 42c:	60e2                	ld	ra,24(sp)
 42e:	6442                	ld	s0,16(sp)
 430:	6105                	addi	sp,sp,32
 432:	8082                	ret

0000000000000434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 434:	7139                	addi	sp,sp,-64
 436:	fc06                	sd	ra,56(sp)
 438:	f822                	sd	s0,48(sp)
 43a:	f426                	sd	s1,40(sp)
 43c:	f04a                	sd	s2,32(sp)
 43e:	ec4e                	sd	s3,24(sp)
 440:	0080                	addi	s0,sp,64
 442:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 444:	c299                	beqz	a3,44a <printint+0x16>
 446:	0805c863          	bltz	a1,4d6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 44a:	2581                	sext.w	a1,a1
  neg = 0;
 44c:	4881                	li	a7,0
 44e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 452:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 454:	2601                	sext.w	a2,a2
 456:	00000517          	auipc	a0,0x0
 45a:	47250513          	addi	a0,a0,1138 # 8c8 <digits>
 45e:	883a                	mv	a6,a4
 460:	2705                	addiw	a4,a4,1
 462:	02c5f7bb          	remuw	a5,a1,a2
 466:	1782                	slli	a5,a5,0x20
 468:	9381                	srli	a5,a5,0x20
 46a:	97aa                	add	a5,a5,a0
 46c:	0007c783          	lbu	a5,0(a5)
 470:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 474:	0005879b          	sext.w	a5,a1
 478:	02c5d5bb          	divuw	a1,a1,a2
 47c:	0685                	addi	a3,a3,1
 47e:	fec7f0e3          	bgeu	a5,a2,45e <printint+0x2a>
  if(neg)
 482:	00088b63          	beqz	a7,498 <printint+0x64>
    buf[i++] = '-';
 486:	fd040793          	addi	a5,s0,-48
 48a:	973e                	add	a4,a4,a5
 48c:	02d00793          	li	a5,45
 490:	fef70823          	sb	a5,-16(a4)
 494:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 498:	02e05863          	blez	a4,4c8 <printint+0x94>
 49c:	fc040793          	addi	a5,s0,-64
 4a0:	00e78933          	add	s2,a5,a4
 4a4:	fff78993          	addi	s3,a5,-1
 4a8:	99ba                	add	s3,s3,a4
 4aa:	377d                	addiw	a4,a4,-1
 4ac:	1702                	slli	a4,a4,0x20
 4ae:	9301                	srli	a4,a4,0x20
 4b0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4b4:	fff94583          	lbu	a1,-1(s2)
 4b8:	8526                	mv	a0,s1
 4ba:	00000097          	auipc	ra,0x0
 4be:	f58080e7          	jalr	-168(ra) # 412 <putc>
  while(--i >= 0)
 4c2:	197d                	addi	s2,s2,-1
 4c4:	ff3918e3          	bne	s2,s3,4b4 <printint+0x80>
}
 4c8:	70e2                	ld	ra,56(sp)
 4ca:	7442                	ld	s0,48(sp)
 4cc:	74a2                	ld	s1,40(sp)
 4ce:	7902                	ld	s2,32(sp)
 4d0:	69e2                	ld	s3,24(sp)
 4d2:	6121                	addi	sp,sp,64
 4d4:	8082                	ret
    x = -xx;
 4d6:	40b005bb          	negw	a1,a1
    neg = 1;
 4da:	4885                	li	a7,1
    x = -xx;
 4dc:	bf8d                	j	44e <printint+0x1a>

00000000000004de <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4de:	7119                	addi	sp,sp,-128
 4e0:	fc86                	sd	ra,120(sp)
 4e2:	f8a2                	sd	s0,112(sp)
 4e4:	f4a6                	sd	s1,104(sp)
 4e6:	f0ca                	sd	s2,96(sp)
 4e8:	ecce                	sd	s3,88(sp)
 4ea:	e8d2                	sd	s4,80(sp)
 4ec:	e4d6                	sd	s5,72(sp)
 4ee:	e0da                	sd	s6,64(sp)
 4f0:	fc5e                	sd	s7,56(sp)
 4f2:	f862                	sd	s8,48(sp)
 4f4:	f466                	sd	s9,40(sp)
 4f6:	f06a                	sd	s10,32(sp)
 4f8:	ec6e                	sd	s11,24(sp)
 4fa:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4fc:	0005c903          	lbu	s2,0(a1)
 500:	18090f63          	beqz	s2,69e <vprintf+0x1c0>
 504:	8aaa                	mv	s5,a0
 506:	8b32                	mv	s6,a2
 508:	00158493          	addi	s1,a1,1
  state = 0;
 50c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50e:	02500a13          	li	s4,37
      if(c == 'd'){
 512:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 516:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 51a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 51e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 522:	00000b97          	auipc	s7,0x0
 526:	3a6b8b93          	addi	s7,s7,934 # 8c8 <digits>
 52a:	a839                	j	548 <vprintf+0x6a>
        putc(fd, c);
 52c:	85ca                	mv	a1,s2
 52e:	8556                	mv	a0,s5
 530:	00000097          	auipc	ra,0x0
 534:	ee2080e7          	jalr	-286(ra) # 412 <putc>
 538:	a019                	j	53e <vprintf+0x60>
    } else if(state == '%'){
 53a:	01498f63          	beq	s3,s4,558 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 53e:	0485                	addi	s1,s1,1
 540:	fff4c903          	lbu	s2,-1(s1)
 544:	14090d63          	beqz	s2,69e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 548:	0009079b          	sext.w	a5,s2
    if(state == 0){
 54c:	fe0997e3          	bnez	s3,53a <vprintf+0x5c>
      if(c == '%'){
 550:	fd479ee3          	bne	a5,s4,52c <vprintf+0x4e>
        state = '%';
 554:	89be                	mv	s3,a5
 556:	b7e5                	j	53e <vprintf+0x60>
      if(c == 'd'){
 558:	05878063          	beq	a5,s8,598 <vprintf+0xba>
      } else if(c == 'l') {
 55c:	05978c63          	beq	a5,s9,5b4 <vprintf+0xd6>
      } else if(c == 'x') {
 560:	07a78863          	beq	a5,s10,5d0 <vprintf+0xf2>
      } else if(c == 'p') {
 564:	09b78463          	beq	a5,s11,5ec <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 568:	07300713          	li	a4,115
 56c:	0ce78663          	beq	a5,a4,638 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 570:	06300713          	li	a4,99
 574:	0ee78e63          	beq	a5,a4,670 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 578:	11478863          	beq	a5,s4,688 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57c:	85d2                	mv	a1,s4
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e92080e7          	jalr	-366(ra) # 412 <putc>
        putc(fd, c);
 588:	85ca                	mv	a1,s2
 58a:	8556                	mv	a0,s5
 58c:	00000097          	auipc	ra,0x0
 590:	e86080e7          	jalr	-378(ra) # 412 <putc>
      }
      state = 0;
 594:	4981                	li	s3,0
 596:	b765                	j	53e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 598:	008b0913          	addi	s2,s6,8
 59c:	4685                	li	a3,1
 59e:	4629                	li	a2,10
 5a0:	000b2583          	lw	a1,0(s6)
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e8e080e7          	jalr	-370(ra) # 434 <printint>
 5ae:	8b4a                	mv	s6,s2
      state = 0;
 5b0:	4981                	li	s3,0
 5b2:	b771                	j	53e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b4:	008b0913          	addi	s2,s6,8
 5b8:	4681                	li	a3,0
 5ba:	4629                	li	a2,10
 5bc:	000b2583          	lw	a1,0(s6)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	e72080e7          	jalr	-398(ra) # 434 <printint>
 5ca:	8b4a                	mv	s6,s2
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	bf85                	j	53e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5d0:	008b0913          	addi	s2,s6,8
 5d4:	4681                	li	a3,0
 5d6:	4641                	li	a2,16
 5d8:	000b2583          	lw	a1,0(s6)
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	e56080e7          	jalr	-426(ra) # 434 <printint>
 5e6:	8b4a                	mv	s6,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	bf91                	j	53e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5ec:	008b0793          	addi	a5,s6,8
 5f0:	f8f43423          	sd	a5,-120(s0)
 5f4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5f8:	03000593          	li	a1,48
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	e14080e7          	jalr	-492(ra) # 412 <putc>
  putc(fd, 'x');
 606:	85ea                	mv	a1,s10
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	e08080e7          	jalr	-504(ra) # 412 <putc>
 612:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 614:	03c9d793          	srli	a5,s3,0x3c
 618:	97de                	add	a5,a5,s7
 61a:	0007c583          	lbu	a1,0(a5)
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	df2080e7          	jalr	-526(ra) # 412 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 628:	0992                	slli	s3,s3,0x4
 62a:	397d                	addiw	s2,s2,-1
 62c:	fe0914e3          	bnez	s2,614 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 630:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 634:	4981                	li	s3,0
 636:	b721                	j	53e <vprintf+0x60>
        s = va_arg(ap, char*);
 638:	008b0993          	addi	s3,s6,8
 63c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 640:	02090163          	beqz	s2,662 <vprintf+0x184>
        while(*s != 0){
 644:	00094583          	lbu	a1,0(s2)
 648:	c9a1                	beqz	a1,698 <vprintf+0x1ba>
          putc(fd, *s);
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	dc6080e7          	jalr	-570(ra) # 412 <putc>
          s++;
 654:	0905                	addi	s2,s2,1
        while(*s != 0){
 656:	00094583          	lbu	a1,0(s2)
 65a:	f9e5                	bnez	a1,64a <vprintf+0x16c>
        s = va_arg(ap, char*);
 65c:	8b4e                	mv	s6,s3
      state = 0;
 65e:	4981                	li	s3,0
 660:	bdf9                	j	53e <vprintf+0x60>
          s = "(null)";
 662:	00000917          	auipc	s2,0x0
 666:	25e90913          	addi	s2,s2,606 # 8c0 <malloc+0x118>
        while(*s != 0){
 66a:	02800593          	li	a1,40
 66e:	bff1                	j	64a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 670:	008b0913          	addi	s2,s6,8
 674:	000b4583          	lbu	a1,0(s6)
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	d98080e7          	jalr	-616(ra) # 412 <putc>
 682:	8b4a                	mv	s6,s2
      state = 0;
 684:	4981                	li	s3,0
 686:	bd65                	j	53e <vprintf+0x60>
        putc(fd, c);
 688:	85d2                	mv	a1,s4
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	d86080e7          	jalr	-634(ra) # 412 <putc>
      state = 0;
 694:	4981                	li	s3,0
 696:	b565                	j	53e <vprintf+0x60>
        s = va_arg(ap, char*);
 698:	8b4e                	mv	s6,s3
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b54d                	j	53e <vprintf+0x60>
    }
  }
}
 69e:	70e6                	ld	ra,120(sp)
 6a0:	7446                	ld	s0,112(sp)
 6a2:	74a6                	ld	s1,104(sp)
 6a4:	7906                	ld	s2,96(sp)
 6a6:	69e6                	ld	s3,88(sp)
 6a8:	6a46                	ld	s4,80(sp)
 6aa:	6aa6                	ld	s5,72(sp)
 6ac:	6b06                	ld	s6,64(sp)
 6ae:	7be2                	ld	s7,56(sp)
 6b0:	7c42                	ld	s8,48(sp)
 6b2:	7ca2                	ld	s9,40(sp)
 6b4:	7d02                	ld	s10,32(sp)
 6b6:	6de2                	ld	s11,24(sp)
 6b8:	6109                	addi	sp,sp,128
 6ba:	8082                	ret

00000000000006bc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6bc:	715d                	addi	sp,sp,-80
 6be:	ec06                	sd	ra,24(sp)
 6c0:	e822                	sd	s0,16(sp)
 6c2:	1000                	addi	s0,sp,32
 6c4:	e010                	sd	a2,0(s0)
 6c6:	e414                	sd	a3,8(s0)
 6c8:	e818                	sd	a4,16(s0)
 6ca:	ec1c                	sd	a5,24(s0)
 6cc:	03043023          	sd	a6,32(s0)
 6d0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6d8:	8622                	mv	a2,s0
 6da:	00000097          	auipc	ra,0x0
 6de:	e04080e7          	jalr	-508(ra) # 4de <vprintf>
}
 6e2:	60e2                	ld	ra,24(sp)
 6e4:	6442                	ld	s0,16(sp)
 6e6:	6161                	addi	sp,sp,80
 6e8:	8082                	ret

00000000000006ea <printf>:

void
printf(const char *fmt, ...)
{
 6ea:	711d                	addi	sp,sp,-96
 6ec:	ec06                	sd	ra,24(sp)
 6ee:	e822                	sd	s0,16(sp)
 6f0:	1000                	addi	s0,sp,32
 6f2:	e40c                	sd	a1,8(s0)
 6f4:	e810                	sd	a2,16(s0)
 6f6:	ec14                	sd	a3,24(s0)
 6f8:	f018                	sd	a4,32(s0)
 6fa:	f41c                	sd	a5,40(s0)
 6fc:	03043823          	sd	a6,48(s0)
 700:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 704:	00840613          	addi	a2,s0,8
 708:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 70c:	85aa                	mv	a1,a0
 70e:	4505                	li	a0,1
 710:	00000097          	auipc	ra,0x0
 714:	dce080e7          	jalr	-562(ra) # 4de <vprintf>
}
 718:	60e2                	ld	ra,24(sp)
 71a:	6442                	ld	s0,16(sp)
 71c:	6125                	addi	sp,sp,96
 71e:	8082                	ret

0000000000000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	1141                	addi	sp,sp,-16
 722:	e422                	sd	s0,8(sp)
 724:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 726:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72a:	00000797          	auipc	a5,0x0
 72e:	1b67b783          	ld	a5,438(a5) # 8e0 <freep>
 732:	a805                	j	762 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 734:	4618                	lw	a4,8(a2)
 736:	9db9                	addw	a1,a1,a4
 738:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 73c:	6398                	ld	a4,0(a5)
 73e:	6318                	ld	a4,0(a4)
 740:	fee53823          	sd	a4,-16(a0)
 744:	a091                	j	788 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 746:	ff852703          	lw	a4,-8(a0)
 74a:	9e39                	addw	a2,a2,a4
 74c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 74e:	ff053703          	ld	a4,-16(a0)
 752:	e398                	sd	a4,0(a5)
 754:	a099                	j	79a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 756:	6398                	ld	a4,0(a5)
 758:	00e7e463          	bltu	a5,a4,760 <free+0x40>
 75c:	00e6ea63          	bltu	a3,a4,770 <free+0x50>
{
 760:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 762:	fed7fae3          	bgeu	a5,a3,756 <free+0x36>
 766:	6398                	ld	a4,0(a5)
 768:	00e6e463          	bltu	a3,a4,770 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	fee7eae3          	bltu	a5,a4,760 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 770:	ff852583          	lw	a1,-8(a0)
 774:	6390                	ld	a2,0(a5)
 776:	02059713          	slli	a4,a1,0x20
 77a:	9301                	srli	a4,a4,0x20
 77c:	0712                	slli	a4,a4,0x4
 77e:	9736                	add	a4,a4,a3
 780:	fae60ae3          	beq	a2,a4,734 <free+0x14>
    bp->s.ptr = p->s.ptr;
 784:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 788:	4790                	lw	a2,8(a5)
 78a:	02061713          	slli	a4,a2,0x20
 78e:	9301                	srli	a4,a4,0x20
 790:	0712                	slli	a4,a4,0x4
 792:	973e                	add	a4,a4,a5
 794:	fae689e3          	beq	a3,a4,746 <free+0x26>
  } else
    p->s.ptr = bp;
 798:	e394                	sd	a3,0(a5)
  freep = p;
 79a:	00000717          	auipc	a4,0x0
 79e:	14f73323          	sd	a5,326(a4) # 8e0 <freep>
}
 7a2:	6422                	ld	s0,8(sp)
 7a4:	0141                	addi	sp,sp,16
 7a6:	8082                	ret

00000000000007a8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a8:	7139                	addi	sp,sp,-64
 7aa:	fc06                	sd	ra,56(sp)
 7ac:	f822                	sd	s0,48(sp)
 7ae:	f426                	sd	s1,40(sp)
 7b0:	f04a                	sd	s2,32(sp)
 7b2:	ec4e                	sd	s3,24(sp)
 7b4:	e852                	sd	s4,16(sp)
 7b6:	e456                	sd	s5,8(sp)
 7b8:	e05a                	sd	s6,0(sp)
 7ba:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7bc:	02051493          	slli	s1,a0,0x20
 7c0:	9081                	srli	s1,s1,0x20
 7c2:	04bd                	addi	s1,s1,15
 7c4:	8091                	srli	s1,s1,0x4
 7c6:	0014899b          	addiw	s3,s1,1
 7ca:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7cc:	00000517          	auipc	a0,0x0
 7d0:	11453503          	ld	a0,276(a0) # 8e0 <freep>
 7d4:	c515                	beqz	a0,800 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d8:	4798                	lw	a4,8(a5)
 7da:	02977f63          	bgeu	a4,s1,818 <malloc+0x70>
 7de:	8a4e                	mv	s4,s3
 7e0:	0009871b          	sext.w	a4,s3
 7e4:	6685                	lui	a3,0x1
 7e6:	00d77363          	bgeu	a4,a3,7ec <malloc+0x44>
 7ea:	6a05                	lui	s4,0x1
 7ec:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7f0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f4:	00000917          	auipc	s2,0x0
 7f8:	0ec90913          	addi	s2,s2,236 # 8e0 <freep>
  if(p == (char*)-1)
 7fc:	5afd                	li	s5,-1
 7fe:	a88d                	j	870 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 800:	00000797          	auipc	a5,0x0
 804:	0e878793          	addi	a5,a5,232 # 8e8 <base>
 808:	00000717          	auipc	a4,0x0
 80c:	0cf73c23          	sd	a5,216(a4) # 8e0 <freep>
 810:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 812:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 816:	b7e1                	j	7de <malloc+0x36>
      if(p->s.size == nunits)
 818:	02e48b63          	beq	s1,a4,84e <malloc+0xa6>
        p->s.size -= nunits;
 81c:	4137073b          	subw	a4,a4,s3
 820:	c798                	sw	a4,8(a5)
        p += p->s.size;
 822:	1702                	slli	a4,a4,0x20
 824:	9301                	srli	a4,a4,0x20
 826:	0712                	slli	a4,a4,0x4
 828:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 82a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 82e:	00000717          	auipc	a4,0x0
 832:	0aa73923          	sd	a0,178(a4) # 8e0 <freep>
      return (void*)(p + 1);
 836:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 83a:	70e2                	ld	ra,56(sp)
 83c:	7442                	ld	s0,48(sp)
 83e:	74a2                	ld	s1,40(sp)
 840:	7902                	ld	s2,32(sp)
 842:	69e2                	ld	s3,24(sp)
 844:	6a42                	ld	s4,16(sp)
 846:	6aa2                	ld	s5,8(sp)
 848:	6b02                	ld	s6,0(sp)
 84a:	6121                	addi	sp,sp,64
 84c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 84e:	6398                	ld	a4,0(a5)
 850:	e118                	sd	a4,0(a0)
 852:	bff1                	j	82e <malloc+0x86>
  hp->s.size = nu;
 854:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 858:	0541                	addi	a0,a0,16
 85a:	00000097          	auipc	ra,0x0
 85e:	ec6080e7          	jalr	-314(ra) # 720 <free>
  return freep;
 862:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 866:	d971                	beqz	a0,83a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86a:	4798                	lw	a4,8(a5)
 86c:	fa9776e3          	bgeu	a4,s1,818 <malloc+0x70>
    if(p == freep)
 870:	00093703          	ld	a4,0(s2)
 874:	853e                	mv	a0,a5
 876:	fef719e3          	bne	a4,a5,868 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 87a:	8552                	mv	a0,s4
 87c:	00000097          	auipc	ra,0x0
 880:	b6e080e7          	jalr	-1170(ra) # 3ea <sbrk>
  if(p == (char*)-1)
 884:	fd5518e3          	bne	a0,s5,854 <malloc+0xac>
        return 0;
 888:	4501                	li	a0,0
 88a:	bf45                	j	83a <malloc+0x92>
