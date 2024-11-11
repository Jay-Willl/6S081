
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <is_prime>:
#include "kernel/types.h"
#include "user/user.h"

int is_prime(int candidate)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
    for (int i = 2; i < candidate; i++)
   6:	4789                	li	a5,2
   8:	02a7d363          	bge	a5,a0,2e <is_prime+0x2e>
   c:	86aa                	mv	a3,a0
    {
        if (candidate % i == 0)
   e:	8905                	andi	a0,a0,1
  10:	cd01                	beqz	a0,28 <is_prime+0x28>
    for (int i = 2; i < candidate; i++)
  12:	4709                	li	a4,2
  14:	0017079b          	addiw	a5,a4,1
  18:	0007871b          	sext.w	a4,a5
  1c:	00e68663          	beq	a3,a4,28 <is_prime+0x28>
        if (candidate % i == 0)
  20:	02f6e7bb          	remw	a5,a3,a5
  24:	fbe5                	bnez	a5,14 <is_prime+0x14>
        {
            return 0;
  26:	853e                	mv	a0,a5
        }
    }
    return 1;
}
  28:	6422                	ld	s0,8(sp)
  2a:	0141                	addi	sp,sp,16
  2c:	8082                	ret
    return 1;
  2e:	4505                	li	a0,1
  30:	bfe5                	j	28 <is_prime+0x28>

0000000000000032 <main>:

int main(int argc, char *argv[])
{
  32:	7139                	addi	sp,sp,-64
  34:	fc06                	sd	ra,56(sp)
  36:	f822                	sd	s0,48(sp)
  38:	0080                	addi	s0,sp,64
    if (argc != 1)
  3a:	4785                	li	a5,1
  3c:	02f50c63          	beq	a0,a5,74 <main+0x42>
  40:	f426                	sd	s1,40(sp)
  42:	f04a                	sd	s2,32(sp)
    {
        write(1, "usage: primes", strlen("usage: primes"));
  44:	00001517          	auipc	a0,0x1
  48:	8fc50513          	addi	a0,a0,-1796 # 940 <malloc+0x100>
  4c:	00000097          	auipc	ra,0x0
  50:	1b0080e7          	jalr	432(ra) # 1fc <strlen>
  54:	0005061b          	sext.w	a2,a0
  58:	00001597          	auipc	a1,0x1
  5c:	8e858593          	addi	a1,a1,-1816 # 940 <malloc+0x100>
  60:	4505                	li	a0,1
  62:	00000097          	auipc	ra,0x0
  66:	3de080e7          	jalr	990(ra) # 440 <write>
        exit(1);
  6a:	4505                	li	a0,1
  6c:	00000097          	auipc	ra,0x0
  70:	3b4080e7          	jalr	948(ra) # 420 <exit>
    }

    char byte = 'X';
  74:	05800793          	li	a5,88
  78:	fcf40fa3          	sb	a5,-33(s0)
    int prime;
    int pipe1[2], pipe2[2];
    int pid;

    if (pipe(pipe1) == -1 || pipe(pipe2) == -1)
  7c:	fd040513          	addi	a0,s0,-48
  80:	00000097          	auipc	ra,0x0
  84:	3b0080e7          	jalr	944(ra) # 430 <pipe>
  88:	57fd                	li	a5,-1
  8a:	00f50b63          	beq	a0,a5,a0 <main+0x6e>
  8e:	fc840513          	addi	a0,s0,-56
  92:	00000097          	auipc	ra,0x0
  96:	39e080e7          	jalr	926(ra) # 430 <pipe>
  9a:	57fd                	li	a5,-1
  9c:	02f51c63          	bne	a0,a5,d4 <main+0xa2>
  a0:	f426                	sd	s1,40(sp)
  a2:	f04a                	sd	s2,32(sp)
    {
        write(1, "pipe error", strlen("pipe error"));
  a4:	00001517          	auipc	a0,0x1
  a8:	8b450513          	addi	a0,a0,-1868 # 958 <malloc+0x118>
  ac:	00000097          	auipc	ra,0x0
  b0:	150080e7          	jalr	336(ra) # 1fc <strlen>
  b4:	0005061b          	sext.w	a2,a0
  b8:	00001597          	auipc	a1,0x1
  bc:	8a058593          	addi	a1,a1,-1888 # 958 <malloc+0x118>
  c0:	4505                	li	a0,1
  c2:	00000097          	auipc	ra,0x0
  c6:	37e080e7          	jalr	894(ra) # 440 <write>
        exit(1);
  ca:	4505                	li	a0,1
  cc:	00000097          	auipc	ra,0x0
  d0:	354080e7          	jalr	852(ra) # 420 <exit>
    }

    pid = fork();
  d4:	00000097          	auipc	ra,0x0
  d8:	344080e7          	jalr	836(ra) # 418 <fork>
    if (pid == -1)
  dc:	57fd                	li	a5,-1
  de:	00f50a63          	beq	a0,a5,f2 <main+0xc0>
    {
        write(1, "fork error", strlen("fork error"));
        exit(1);
    }

    if (pid == 0)
  e2:	e131                	bnez	a0,126 <main+0xf4>
  e4:	f426                	sd	s1,40(sp)
  e6:	f04a                	sd	s2,32(sp)
    { // print process
        while (read(pipe1[0], &prime, 1) != 0) {
            printf("prime %d\n", prime);
  e8:	00001497          	auipc	s1,0x1
  ec:	89048493          	addi	s1,s1,-1904 # 978 <malloc+0x138>
  f0:	a08d                	j	152 <main+0x120>
  f2:	f426                	sd	s1,40(sp)
  f4:	f04a                	sd	s2,32(sp)
        write(1, "fork error", strlen("fork error"));
  f6:	00001517          	auipc	a0,0x1
  fa:	87250513          	addi	a0,a0,-1934 # 968 <malloc+0x128>
  fe:	00000097          	auipc	ra,0x0
 102:	0fe080e7          	jalr	254(ra) # 1fc <strlen>
 106:	0005061b          	sext.w	a2,a0
 10a:	00001597          	auipc	a1,0x1
 10e:	85e58593          	addi	a1,a1,-1954 # 968 <malloc+0x128>
 112:	4505                	li	a0,1
 114:	00000097          	auipc	ra,0x0
 118:	32c080e7          	jalr	812(ra) # 440 <write>
        exit(1);
 11c:	4505                	li	a0,1
 11e:	00000097          	auipc	ra,0x0
 122:	302080e7          	jalr	770(ra) # 420 <exit>
 126:	f426                	sd	s1,40(sp)
 128:	f04a                	sd	s2,32(sp)
        }
        exit(0);
    }
    else
    { // feed process
        for (int i = 2; i < 36; i++)
 12a:	4489                	li	s1,2
 12c:	02400913          	li	s2,36
 130:	a091                	j	174 <main+0x142>
            printf("prime %d\n", prime);
 132:	fd842583          	lw	a1,-40(s0)
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	650080e7          	jalr	1616(ra) # 788 <printf>
            write(pipe2[1], &byte, 1);
 140:	4605                	li	a2,1
 142:	fdf40593          	addi	a1,s0,-33
 146:	fcc42503          	lw	a0,-52(s0)
 14a:	00000097          	auipc	ra,0x0
 14e:	2f6080e7          	jalr	758(ra) # 440 <write>
        while (read(pipe1[0], &prime, 1) != 0) {
 152:	4605                	li	a2,1
 154:	fd840593          	addi	a1,s0,-40
 158:	fd042503          	lw	a0,-48(s0)
 15c:	00000097          	auipc	ra,0x0
 160:	2dc080e7          	jalr	732(ra) # 438 <read>
 164:	f579                	bnez	a0,132 <main+0x100>
        exit(0);
 166:	00000097          	auipc	ra,0x0
 16a:	2ba080e7          	jalr	698(ra) # 420 <exit>
        for (int i = 2; i < 36; i++)
 16e:	2485                	addiw	s1,s1,1
 170:	03248d63          	beq	s1,s2,1aa <main+0x178>
        {
            if (is_prime(i))
 174:	8526                	mv	a0,s1
 176:	00000097          	auipc	ra,0x0
 17a:	e8a080e7          	jalr	-374(ra) # 0 <is_prime>
 17e:	d965                	beqz	a0,16e <main+0x13c>
            {
                prime = i;
 180:	fc942c23          	sw	s1,-40(s0)
                write(pipe1[1], &prime, 1);
 184:	4605                	li	a2,1
 186:	fd840593          	addi	a1,s0,-40
 18a:	fd442503          	lw	a0,-44(s0)
 18e:	00000097          	auipc	ra,0x0
 192:	2b2080e7          	jalr	690(ra) # 440 <write>
                read(pipe2[0], &byte, 1);
 196:	4605                	li	a2,1
 198:	fdf40593          	addi	a1,s0,-33
 19c:	fc842503          	lw	a0,-56(s0)
 1a0:	00000097          	auipc	ra,0x0
 1a4:	298080e7          	jalr	664(ra) # 438 <read>
 1a8:	b7d9                	j	16e <main+0x13c>
            }
        }
        exit(0);
 1aa:	4501                	li	a0,0
 1ac:	00000097          	auipc	ra,0x0
 1b0:	274080e7          	jalr	628(ra) # 420 <exit>

00000000000001b4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ba:	87aa                	mv	a5,a0
 1bc:	0585                	addi	a1,a1,1
 1be:	0785                	addi	a5,a5,1
 1c0:	fff5c703          	lbu	a4,-1(a1)
 1c4:	fee78fa3          	sb	a4,-1(a5)
 1c8:	fb75                	bnez	a4,1bc <strcpy+0x8>
    ;
  return os;
}
 1ca:	6422                	ld	s0,8(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret

00000000000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	1141                	addi	sp,sp,-16
 1d2:	e422                	sd	s0,8(sp)
 1d4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1d6:	00054783          	lbu	a5,0(a0)
 1da:	cb91                	beqz	a5,1ee <strcmp+0x1e>
 1dc:	0005c703          	lbu	a4,0(a1)
 1e0:	00f71763          	bne	a4,a5,1ee <strcmp+0x1e>
    p++, q++;
 1e4:	0505                	addi	a0,a0,1
 1e6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	fbe5                	bnez	a5,1dc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1ee:	0005c503          	lbu	a0,0(a1)
}
 1f2:	40a7853b          	subw	a0,a5,a0
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <strlen>:

uint
strlen(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 202:	00054783          	lbu	a5,0(a0)
 206:	cf91                	beqz	a5,222 <strlen+0x26>
 208:	0505                	addi	a0,a0,1
 20a:	87aa                	mv	a5,a0
 20c:	86be                	mv	a3,a5
 20e:	0785                	addi	a5,a5,1
 210:	fff7c703          	lbu	a4,-1(a5)
 214:	ff65                	bnez	a4,20c <strlen+0x10>
 216:	40a6853b          	subw	a0,a3,a0
 21a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret
  for(n = 0; s[n]; n++)
 222:	4501                	li	a0,0
 224:	bfe5                	j	21c <strlen+0x20>

0000000000000226 <memset>:

void*
memset(void *dst, int c, uint n)
{
 226:	1141                	addi	sp,sp,-16
 228:	e422                	sd	s0,8(sp)
 22a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 22c:	ca19                	beqz	a2,242 <memset+0x1c>
 22e:	87aa                	mv	a5,a0
 230:	1602                	slli	a2,a2,0x20
 232:	9201                	srli	a2,a2,0x20
 234:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 238:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 23c:	0785                	addi	a5,a5,1
 23e:	fee79de3          	bne	a5,a4,238 <memset+0x12>
  }
  return dst;
}
 242:	6422                	ld	s0,8(sp)
 244:	0141                	addi	sp,sp,16
 246:	8082                	ret

0000000000000248 <strchr>:

char*
strchr(const char *s, char c)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 24e:	00054783          	lbu	a5,0(a0)
 252:	cb99                	beqz	a5,268 <strchr+0x20>
    if(*s == c)
 254:	00f58763          	beq	a1,a5,262 <strchr+0x1a>
  for(; *s; s++)
 258:	0505                	addi	a0,a0,1
 25a:	00054783          	lbu	a5,0(a0)
 25e:	fbfd                	bnez	a5,254 <strchr+0xc>
      return (char*)s;
  return 0;
 260:	4501                	li	a0,0
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret
  return 0;
 268:	4501                	li	a0,0
 26a:	bfe5                	j	262 <strchr+0x1a>

000000000000026c <gets>:

char*
gets(char *buf, int max)
{
 26c:	711d                	addi	sp,sp,-96
 26e:	ec86                	sd	ra,88(sp)
 270:	e8a2                	sd	s0,80(sp)
 272:	e4a6                	sd	s1,72(sp)
 274:	e0ca                	sd	s2,64(sp)
 276:	fc4e                	sd	s3,56(sp)
 278:	f852                	sd	s4,48(sp)
 27a:	f456                	sd	s5,40(sp)
 27c:	f05a                	sd	s6,32(sp)
 27e:	ec5e                	sd	s7,24(sp)
 280:	1080                	addi	s0,sp,96
 282:	8baa                	mv	s7,a0
 284:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	892a                	mv	s2,a0
 288:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 28a:	4aa9                	li	s5,10
 28c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 28e:	89a6                	mv	s3,s1
 290:	2485                	addiw	s1,s1,1
 292:	0344d863          	bge	s1,s4,2c2 <gets+0x56>
    cc = read(0, &c, 1);
 296:	4605                	li	a2,1
 298:	faf40593          	addi	a1,s0,-81
 29c:	4501                	li	a0,0
 29e:	00000097          	auipc	ra,0x0
 2a2:	19a080e7          	jalr	410(ra) # 438 <read>
    if(cc < 1)
 2a6:	00a05e63          	blez	a0,2c2 <gets+0x56>
    buf[i++] = c;
 2aa:	faf44783          	lbu	a5,-81(s0)
 2ae:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b2:	01578763          	beq	a5,s5,2c0 <gets+0x54>
 2b6:	0905                	addi	s2,s2,1
 2b8:	fd679be3          	bne	a5,s6,28e <gets+0x22>
    buf[i++] = c;
 2bc:	89a6                	mv	s3,s1
 2be:	a011                	j	2c2 <gets+0x56>
 2c0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2c2:	99de                	add	s3,s3,s7
 2c4:	00098023          	sb	zero,0(s3)
  return buf;
}
 2c8:	855e                	mv	a0,s7
 2ca:	60e6                	ld	ra,88(sp)
 2cc:	6446                	ld	s0,80(sp)
 2ce:	64a6                	ld	s1,72(sp)
 2d0:	6906                	ld	s2,64(sp)
 2d2:	79e2                	ld	s3,56(sp)
 2d4:	7a42                	ld	s4,48(sp)
 2d6:	7aa2                	ld	s5,40(sp)
 2d8:	7b02                	ld	s6,32(sp)
 2da:	6be2                	ld	s7,24(sp)
 2dc:	6125                	addi	sp,sp,96
 2de:	8082                	ret

00000000000002e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e0:	1101                	addi	sp,sp,-32
 2e2:	ec06                	sd	ra,24(sp)
 2e4:	e822                	sd	s0,16(sp)
 2e6:	e04a                	sd	s2,0(sp)
 2e8:	1000                	addi	s0,sp,32
 2ea:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ec:	4581                	li	a1,0
 2ee:	00000097          	auipc	ra,0x0
 2f2:	172080e7          	jalr	370(ra) # 460 <open>
  if(fd < 0)
 2f6:	02054663          	bltz	a0,322 <stat+0x42>
 2fa:	e426                	sd	s1,8(sp)
 2fc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2fe:	85ca                	mv	a1,s2
 300:	00000097          	auipc	ra,0x0
 304:	178080e7          	jalr	376(ra) # 478 <fstat>
 308:	892a                	mv	s2,a0
  close(fd);
 30a:	8526                	mv	a0,s1
 30c:	00000097          	auipc	ra,0x0
 310:	13c080e7          	jalr	316(ra) # 448 <close>
  return r;
 314:	64a2                	ld	s1,8(sp)
}
 316:	854a                	mv	a0,s2
 318:	60e2                	ld	ra,24(sp)
 31a:	6442                	ld	s0,16(sp)
 31c:	6902                	ld	s2,0(sp)
 31e:	6105                	addi	sp,sp,32
 320:	8082                	ret
    return -1;
 322:	597d                	li	s2,-1
 324:	bfcd                	j	316 <stat+0x36>

0000000000000326 <atoi>:

int
atoi(const char *s)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32c:	00054683          	lbu	a3,0(a0)
 330:	fd06879b          	addiw	a5,a3,-48
 334:	0ff7f793          	zext.b	a5,a5
 338:	4625                	li	a2,9
 33a:	02f66863          	bltu	a2,a5,36a <atoi+0x44>
 33e:	872a                	mv	a4,a0
  n = 0;
 340:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 342:	0705                	addi	a4,a4,1
 344:	0025179b          	slliw	a5,a0,0x2
 348:	9fa9                	addw	a5,a5,a0
 34a:	0017979b          	slliw	a5,a5,0x1
 34e:	9fb5                	addw	a5,a5,a3
 350:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 354:	00074683          	lbu	a3,0(a4)
 358:	fd06879b          	addiw	a5,a3,-48
 35c:	0ff7f793          	zext.b	a5,a5
 360:	fef671e3          	bgeu	a2,a5,342 <atoi+0x1c>
  return n;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret
  n = 0;
 36a:	4501                	li	a0,0
 36c:	bfe5                	j	364 <atoi+0x3e>

000000000000036e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 374:	02b57463          	bgeu	a0,a1,39c <memmove+0x2e>
    while(n-- > 0)
 378:	00c05f63          	blez	a2,396 <memmove+0x28>
 37c:	1602                	slli	a2,a2,0x20
 37e:	9201                	srli	a2,a2,0x20
 380:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 384:	872a                	mv	a4,a0
      *dst++ = *src++;
 386:	0585                	addi	a1,a1,1
 388:	0705                	addi	a4,a4,1
 38a:	fff5c683          	lbu	a3,-1(a1)
 38e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 392:	fef71ae3          	bne	a4,a5,386 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 396:	6422                	ld	s0,8(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret
    dst += n;
 39c:	00c50733          	add	a4,a0,a2
    src += n;
 3a0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a2:	fec05ae3          	blez	a2,396 <memmove+0x28>
 3a6:	fff6079b          	addiw	a5,a2,-1
 3aa:	1782                	slli	a5,a5,0x20
 3ac:	9381                	srli	a5,a5,0x20
 3ae:	fff7c793          	not	a5,a5
 3b2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b4:	15fd                	addi	a1,a1,-1
 3b6:	177d                	addi	a4,a4,-1
 3b8:	0005c683          	lbu	a3,0(a1)
 3bc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c0:	fee79ae3          	bne	a5,a4,3b4 <memmove+0x46>
 3c4:	bfc9                	j	396 <memmove+0x28>

00000000000003c6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3cc:	ca05                	beqz	a2,3fc <memcmp+0x36>
 3ce:	fff6069b          	addiw	a3,a2,-1
 3d2:	1682                	slli	a3,a3,0x20
 3d4:	9281                	srli	a3,a3,0x20
 3d6:	0685                	addi	a3,a3,1
 3d8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3da:	00054783          	lbu	a5,0(a0)
 3de:	0005c703          	lbu	a4,0(a1)
 3e2:	00e79863          	bne	a5,a4,3f2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3e6:	0505                	addi	a0,a0,1
    p2++;
 3e8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3ea:	fed518e3          	bne	a0,a3,3da <memcmp+0x14>
  }
  return 0;
 3ee:	4501                	li	a0,0
 3f0:	a019                	j	3f6 <memcmp+0x30>
      return *p1 - *p2;
 3f2:	40e7853b          	subw	a0,a5,a4
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
  return 0;
 3fc:	4501                	li	a0,0
 3fe:	bfe5                	j	3f6 <memcmp+0x30>

0000000000000400 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 400:	1141                	addi	sp,sp,-16
 402:	e406                	sd	ra,8(sp)
 404:	e022                	sd	s0,0(sp)
 406:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 408:	00000097          	auipc	ra,0x0
 40c:	f66080e7          	jalr	-154(ra) # 36e <memmove>
}
 410:	60a2                	ld	ra,8(sp)
 412:	6402                	ld	s0,0(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret

0000000000000418 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 418:	4885                	li	a7,1
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <exit>:
.global exit
exit:
 li a7, SYS_exit
 420:	4889                	li	a7,2
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <wait>:
.global wait
wait:
 li a7, SYS_wait
 428:	488d                	li	a7,3
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 430:	4891                	li	a7,4
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <read>:
.global read
read:
 li a7, SYS_read
 438:	4895                	li	a7,5
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <write>:
.global write
write:
 li a7, SYS_write
 440:	48c1                	li	a7,16
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <close>:
.global close
close:
 li a7, SYS_close
 448:	48d5                	li	a7,21
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <kill>:
.global kill
kill:
 li a7, SYS_kill
 450:	4899                	li	a7,6
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <exec>:
.global exec
exec:
 li a7, SYS_exec
 458:	489d                	li	a7,7
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <open>:
.global open
open:
 li a7, SYS_open
 460:	48bd                	li	a7,15
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 468:	48c5                	li	a7,17
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 470:	48c9                	li	a7,18
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 478:	48a1                	li	a7,8
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <link>:
.global link
link:
 li a7, SYS_link
 480:	48cd                	li	a7,19
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 488:	48d1                	li	a7,20
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 490:	48a5                	li	a7,9
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <dup>:
.global dup
dup:
 li a7, SYS_dup
 498:	48a9                	li	a7,10
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a0:	48ad                	li	a7,11
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4a8:	48b1                	li	a7,12
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4b0:	48b5                	li	a7,13
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b8:	48b9                	li	a7,14
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4c0:	1101                	addi	sp,sp,-32
 4c2:	ec06                	sd	ra,24(sp)
 4c4:	e822                	sd	s0,16(sp)
 4c6:	1000                	addi	s0,sp,32
 4c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4cc:	4605                	li	a2,1
 4ce:	fef40593          	addi	a1,s0,-17
 4d2:	00000097          	auipc	ra,0x0
 4d6:	f6e080e7          	jalr	-146(ra) # 440 <write>
}
 4da:	60e2                	ld	ra,24(sp)
 4dc:	6442                	ld	s0,16(sp)
 4de:	6105                	addi	sp,sp,32
 4e0:	8082                	ret

00000000000004e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e2:	7139                	addi	sp,sp,-64
 4e4:	fc06                	sd	ra,56(sp)
 4e6:	f822                	sd	s0,48(sp)
 4e8:	f426                	sd	s1,40(sp)
 4ea:	0080                	addi	s0,sp,64
 4ec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ee:	c299                	beqz	a3,4f4 <printint+0x12>
 4f0:	0805cb63          	bltz	a1,586 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f4:	2581                	sext.w	a1,a1
  neg = 0;
 4f6:	4881                	li	a7,0
 4f8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4fc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4fe:	2601                	sext.w	a2,a2
 500:	00000517          	auipc	a0,0x0
 504:	4e850513          	addi	a0,a0,1256 # 9e8 <digits>
 508:	883a                	mv	a6,a4
 50a:	2705                	addiw	a4,a4,1
 50c:	02c5f7bb          	remuw	a5,a1,a2
 510:	1782                	slli	a5,a5,0x20
 512:	9381                	srli	a5,a5,0x20
 514:	97aa                	add	a5,a5,a0
 516:	0007c783          	lbu	a5,0(a5)
 51a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 51e:	0005879b          	sext.w	a5,a1
 522:	02c5d5bb          	divuw	a1,a1,a2
 526:	0685                	addi	a3,a3,1
 528:	fec7f0e3          	bgeu	a5,a2,508 <printint+0x26>
  if(neg)
 52c:	00088c63          	beqz	a7,544 <printint+0x62>
    buf[i++] = '-';
 530:	fd070793          	addi	a5,a4,-48
 534:	00878733          	add	a4,a5,s0
 538:	02d00793          	li	a5,45
 53c:	fef70823          	sb	a5,-16(a4)
 540:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 544:	02e05c63          	blez	a4,57c <printint+0x9a>
 548:	f04a                	sd	s2,32(sp)
 54a:	ec4e                	sd	s3,24(sp)
 54c:	fc040793          	addi	a5,s0,-64
 550:	00e78933          	add	s2,a5,a4
 554:	fff78993          	addi	s3,a5,-1
 558:	99ba                	add	s3,s3,a4
 55a:	377d                	addiw	a4,a4,-1
 55c:	1702                	slli	a4,a4,0x20
 55e:	9301                	srli	a4,a4,0x20
 560:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 564:	fff94583          	lbu	a1,-1(s2)
 568:	8526                	mv	a0,s1
 56a:	00000097          	auipc	ra,0x0
 56e:	f56080e7          	jalr	-170(ra) # 4c0 <putc>
  while(--i >= 0)
 572:	197d                	addi	s2,s2,-1
 574:	ff3918e3          	bne	s2,s3,564 <printint+0x82>
 578:	7902                	ld	s2,32(sp)
 57a:	69e2                	ld	s3,24(sp)
}
 57c:	70e2                	ld	ra,56(sp)
 57e:	7442                	ld	s0,48(sp)
 580:	74a2                	ld	s1,40(sp)
 582:	6121                	addi	sp,sp,64
 584:	8082                	ret
    x = -xx;
 586:	40b005bb          	negw	a1,a1
    neg = 1;
 58a:	4885                	li	a7,1
    x = -xx;
 58c:	b7b5                	j	4f8 <printint+0x16>

000000000000058e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58e:	715d                	addi	sp,sp,-80
 590:	e486                	sd	ra,72(sp)
 592:	e0a2                	sd	s0,64(sp)
 594:	f84a                	sd	s2,48(sp)
 596:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 598:	0005c903          	lbu	s2,0(a1)
 59c:	1a090a63          	beqz	s2,750 <vprintf+0x1c2>
 5a0:	fc26                	sd	s1,56(sp)
 5a2:	f44e                	sd	s3,40(sp)
 5a4:	f052                	sd	s4,32(sp)
 5a6:	ec56                	sd	s5,24(sp)
 5a8:	e85a                	sd	s6,16(sp)
 5aa:	e45e                	sd	s7,8(sp)
 5ac:	8aaa                	mv	s5,a0
 5ae:	8bb2                	mv	s7,a2
 5b0:	00158493          	addi	s1,a1,1
  state = 0;
 5b4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b6:	02500a13          	li	s4,37
 5ba:	4b55                	li	s6,21
 5bc:	a839                	j	5da <vprintf+0x4c>
        putc(fd, c);
 5be:	85ca                	mv	a1,s2
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	efe080e7          	jalr	-258(ra) # 4c0 <putc>
 5ca:	a019                	j	5d0 <vprintf+0x42>
    } else if(state == '%'){
 5cc:	01498d63          	beq	s3,s4,5e6 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5d0:	0485                	addi	s1,s1,1
 5d2:	fff4c903          	lbu	s2,-1(s1)
 5d6:	16090763          	beqz	s2,744 <vprintf+0x1b6>
    if(state == 0){
 5da:	fe0999e3          	bnez	s3,5cc <vprintf+0x3e>
      if(c == '%'){
 5de:	ff4910e3          	bne	s2,s4,5be <vprintf+0x30>
        state = '%';
 5e2:	89d2                	mv	s3,s4
 5e4:	b7f5                	j	5d0 <vprintf+0x42>
      if(c == 'd'){
 5e6:	13490463          	beq	s2,s4,70e <vprintf+0x180>
 5ea:	f9d9079b          	addiw	a5,s2,-99
 5ee:	0ff7f793          	zext.b	a5,a5
 5f2:	12fb6763          	bltu	s6,a5,720 <vprintf+0x192>
 5f6:	f9d9079b          	addiw	a5,s2,-99
 5fa:	0ff7f713          	zext.b	a4,a5
 5fe:	12eb6163          	bltu	s6,a4,720 <vprintf+0x192>
 602:	00271793          	slli	a5,a4,0x2
 606:	00000717          	auipc	a4,0x0
 60a:	38a70713          	addi	a4,a4,906 # 990 <malloc+0x150>
 60e:	97ba                	add	a5,a5,a4
 610:	439c                	lw	a5,0(a5)
 612:	97ba                	add	a5,a5,a4
 614:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 616:	008b8913          	addi	s2,s7,8
 61a:	4685                	li	a3,1
 61c:	4629                	li	a2,10
 61e:	000ba583          	lw	a1,0(s7)
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	ebe080e7          	jalr	-322(ra) # 4e2 <printint>
 62c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62e:	4981                	li	s3,0
 630:	b745                	j	5d0 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 632:	008b8913          	addi	s2,s7,8
 636:	4681                	li	a3,0
 638:	4629                	li	a2,10
 63a:	000ba583          	lw	a1,0(s7)
 63e:	8556                	mv	a0,s5
 640:	00000097          	auipc	ra,0x0
 644:	ea2080e7          	jalr	-350(ra) # 4e2 <printint>
 648:	8bca                	mv	s7,s2
      state = 0;
 64a:	4981                	li	s3,0
 64c:	b751                	j	5d0 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 64e:	008b8913          	addi	s2,s7,8
 652:	4681                	li	a3,0
 654:	4641                	li	a2,16
 656:	000ba583          	lw	a1,0(s7)
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	e86080e7          	jalr	-378(ra) # 4e2 <printint>
 664:	8bca                	mv	s7,s2
      state = 0;
 666:	4981                	li	s3,0
 668:	b7a5                	j	5d0 <vprintf+0x42>
 66a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 66c:	008b8c13          	addi	s8,s7,8
 670:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 674:	03000593          	li	a1,48
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e46080e7          	jalr	-442(ra) # 4c0 <putc>
  putc(fd, 'x');
 682:	07800593          	li	a1,120
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	e38080e7          	jalr	-456(ra) # 4c0 <putc>
 690:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 692:	00000b97          	auipc	s7,0x0
 696:	356b8b93          	addi	s7,s7,854 # 9e8 <digits>
 69a:	03c9d793          	srli	a5,s3,0x3c
 69e:	97de                	add	a5,a5,s7
 6a0:	0007c583          	lbu	a1,0(a5)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e1a080e7          	jalr	-486(ra) # 4c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ae:	0992                	slli	s3,s3,0x4
 6b0:	397d                	addiw	s2,s2,-1
 6b2:	fe0914e3          	bnez	s2,69a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6b6:	8be2                	mv	s7,s8
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	6c02                	ld	s8,0(sp)
 6bc:	bf11                	j	5d0 <vprintf+0x42>
        s = va_arg(ap, char*);
 6be:	008b8993          	addi	s3,s7,8
 6c2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6c6:	02090163          	beqz	s2,6e8 <vprintf+0x15a>
        while(*s != 0){
 6ca:	00094583          	lbu	a1,0(s2)
 6ce:	c9a5                	beqz	a1,73e <vprintf+0x1b0>
          putc(fd, *s);
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	dee080e7          	jalr	-530(ra) # 4c0 <putc>
          s++;
 6da:	0905                	addi	s2,s2,1
        while(*s != 0){
 6dc:	00094583          	lbu	a1,0(s2)
 6e0:	f9e5                	bnez	a1,6d0 <vprintf+0x142>
        s = va_arg(ap, char*);
 6e2:	8bce                	mv	s7,s3
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	b5ed                	j	5d0 <vprintf+0x42>
          s = "(null)";
 6e8:	00000917          	auipc	s2,0x0
 6ec:	2a090913          	addi	s2,s2,672 # 988 <malloc+0x148>
        while(*s != 0){
 6f0:	02800593          	li	a1,40
 6f4:	bff1                	j	6d0 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6f6:	008b8913          	addi	s2,s7,8
 6fa:	000bc583          	lbu	a1,0(s7)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	dc0080e7          	jalr	-576(ra) # 4c0 <putc>
 708:	8bca                	mv	s7,s2
      state = 0;
 70a:	4981                	li	s3,0
 70c:	b5d1                	j	5d0 <vprintf+0x42>
        putc(fd, c);
 70e:	02500593          	li	a1,37
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	dac080e7          	jalr	-596(ra) # 4c0 <putc>
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bd4d                	j	5d0 <vprintf+0x42>
        putc(fd, '%');
 720:	02500593          	li	a1,37
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	d9a080e7          	jalr	-614(ra) # 4c0 <putc>
        putc(fd, c);
 72e:	85ca                	mv	a1,s2
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	d8e080e7          	jalr	-626(ra) # 4c0 <putc>
      state = 0;
 73a:	4981                	li	s3,0
 73c:	bd51                	j	5d0 <vprintf+0x42>
        s = va_arg(ap, char*);
 73e:	8bce                	mv	s7,s3
      state = 0;
 740:	4981                	li	s3,0
 742:	b579                	j	5d0 <vprintf+0x42>
 744:	74e2                	ld	s1,56(sp)
 746:	79a2                	ld	s3,40(sp)
 748:	7a02                	ld	s4,32(sp)
 74a:	6ae2                	ld	s5,24(sp)
 74c:	6b42                	ld	s6,16(sp)
 74e:	6ba2                	ld	s7,8(sp)
    }
  }
}
 750:	60a6                	ld	ra,72(sp)
 752:	6406                	ld	s0,64(sp)
 754:	7942                	ld	s2,48(sp)
 756:	6161                	addi	sp,sp,80
 758:	8082                	ret

000000000000075a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 75a:	715d                	addi	sp,sp,-80
 75c:	ec06                	sd	ra,24(sp)
 75e:	e822                	sd	s0,16(sp)
 760:	1000                	addi	s0,sp,32
 762:	e010                	sd	a2,0(s0)
 764:	e414                	sd	a3,8(s0)
 766:	e818                	sd	a4,16(s0)
 768:	ec1c                	sd	a5,24(s0)
 76a:	03043023          	sd	a6,32(s0)
 76e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 772:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 776:	8622                	mv	a2,s0
 778:	00000097          	auipc	ra,0x0
 77c:	e16080e7          	jalr	-490(ra) # 58e <vprintf>
}
 780:	60e2                	ld	ra,24(sp)
 782:	6442                	ld	s0,16(sp)
 784:	6161                	addi	sp,sp,80
 786:	8082                	ret

0000000000000788 <printf>:

void
printf(const char *fmt, ...)
{
 788:	711d                	addi	sp,sp,-96
 78a:	ec06                	sd	ra,24(sp)
 78c:	e822                	sd	s0,16(sp)
 78e:	1000                	addi	s0,sp,32
 790:	e40c                	sd	a1,8(s0)
 792:	e810                	sd	a2,16(s0)
 794:	ec14                	sd	a3,24(s0)
 796:	f018                	sd	a4,32(s0)
 798:	f41c                	sd	a5,40(s0)
 79a:	03043823          	sd	a6,48(s0)
 79e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a2:	00840613          	addi	a2,s0,8
 7a6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7aa:	85aa                	mv	a1,a0
 7ac:	4505                	li	a0,1
 7ae:	00000097          	auipc	ra,0x0
 7b2:	de0080e7          	jalr	-544(ra) # 58e <vprintf>
}
 7b6:	60e2                	ld	ra,24(sp)
 7b8:	6442                	ld	s0,16(sp)
 7ba:	6125                	addi	sp,sp,96
 7bc:	8082                	ret

00000000000007be <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7be:	1141                	addi	sp,sp,-16
 7c0:	e422                	sd	s0,8(sp)
 7c2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c8:	00000797          	auipc	a5,0x0
 7cc:	6387b783          	ld	a5,1592(a5) # e00 <freep>
 7d0:	a02d                	j	7fa <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d2:	4618                	lw	a4,8(a2)
 7d4:	9f2d                	addw	a4,a4,a1
 7d6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7da:	6398                	ld	a4,0(a5)
 7dc:	6310                	ld	a2,0(a4)
 7de:	a83d                	j	81c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e0:	ff852703          	lw	a4,-8(a0)
 7e4:	9f31                	addw	a4,a4,a2
 7e6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e8:	ff053683          	ld	a3,-16(a0)
 7ec:	a091                	j	830 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	6398                	ld	a4,0(a5)
 7f0:	00e7e463          	bltu	a5,a4,7f8 <free+0x3a>
 7f4:	00e6ea63          	bltu	a3,a4,808 <free+0x4a>
{
 7f8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	fed7fae3          	bgeu	a5,a3,7ee <free+0x30>
 7fe:	6398                	ld	a4,0(a5)
 800:	00e6e463          	bltu	a3,a4,808 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	fee7eae3          	bltu	a5,a4,7f8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 808:	ff852583          	lw	a1,-8(a0)
 80c:	6390                	ld	a2,0(a5)
 80e:	02059813          	slli	a6,a1,0x20
 812:	01c85713          	srli	a4,a6,0x1c
 816:	9736                	add	a4,a4,a3
 818:	fae60de3          	beq	a2,a4,7d2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 81c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 820:	4790                	lw	a2,8(a5)
 822:	02061593          	slli	a1,a2,0x20
 826:	01c5d713          	srli	a4,a1,0x1c
 82a:	973e                	add	a4,a4,a5
 82c:	fae68ae3          	beq	a3,a4,7e0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 830:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 832:	00000717          	auipc	a4,0x0
 836:	5cf73723          	sd	a5,1486(a4) # e00 <freep>
}
 83a:	6422                	ld	s0,8(sp)
 83c:	0141                	addi	sp,sp,16
 83e:	8082                	ret

0000000000000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	7139                	addi	sp,sp,-64
 842:	fc06                	sd	ra,56(sp)
 844:	f822                	sd	s0,48(sp)
 846:	f426                	sd	s1,40(sp)
 848:	ec4e                	sd	s3,24(sp)
 84a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84c:	02051493          	slli	s1,a0,0x20
 850:	9081                	srli	s1,s1,0x20
 852:	04bd                	addi	s1,s1,15
 854:	8091                	srli	s1,s1,0x4
 856:	0014899b          	addiw	s3,s1,1
 85a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 85c:	00000517          	auipc	a0,0x0
 860:	5a453503          	ld	a0,1444(a0) # e00 <freep>
 864:	c915                	beqz	a0,898 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 868:	4798                	lw	a4,8(a5)
 86a:	08977e63          	bgeu	a4,s1,906 <malloc+0xc6>
 86e:	f04a                	sd	s2,32(sp)
 870:	e852                	sd	s4,16(sp)
 872:	e456                	sd	s5,8(sp)
 874:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 876:	8a4e                	mv	s4,s3
 878:	0009871b          	sext.w	a4,s3
 87c:	6685                	lui	a3,0x1
 87e:	00d77363          	bgeu	a4,a3,884 <malloc+0x44>
 882:	6a05                	lui	s4,0x1
 884:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 888:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 88c:	00000917          	auipc	s2,0x0
 890:	57490913          	addi	s2,s2,1396 # e00 <freep>
  if(p == (char*)-1)
 894:	5afd                	li	s5,-1
 896:	a091                	j	8da <malloc+0x9a>
 898:	f04a                	sd	s2,32(sp)
 89a:	e852                	sd	s4,16(sp)
 89c:	e456                	sd	s5,8(sp)
 89e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8a0:	00000797          	auipc	a5,0x0
 8a4:	56878793          	addi	a5,a5,1384 # e08 <base>
 8a8:	00000717          	auipc	a4,0x0
 8ac:	54f73c23          	sd	a5,1368(a4) # e00 <freep>
 8b0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b6:	b7c1                	j	876 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8b8:	6398                	ld	a4,0(a5)
 8ba:	e118                	sd	a4,0(a0)
 8bc:	a08d                	j	91e <malloc+0xde>
  hp->s.size = nu;
 8be:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8c2:	0541                	addi	a0,a0,16
 8c4:	00000097          	auipc	ra,0x0
 8c8:	efa080e7          	jalr	-262(ra) # 7be <free>
  return freep;
 8cc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8d0:	c13d                	beqz	a0,936 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d4:	4798                	lw	a4,8(a5)
 8d6:	02977463          	bgeu	a4,s1,8fe <malloc+0xbe>
    if(p == freep)
 8da:	00093703          	ld	a4,0(s2)
 8de:	853e                	mv	a0,a5
 8e0:	fef719e3          	bne	a4,a5,8d2 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 8e4:	8552                	mv	a0,s4
 8e6:	00000097          	auipc	ra,0x0
 8ea:	bc2080e7          	jalr	-1086(ra) # 4a8 <sbrk>
  if(p == (char*)-1)
 8ee:	fd5518e3          	bne	a0,s5,8be <malloc+0x7e>
        return 0;
 8f2:	4501                	li	a0,0
 8f4:	7902                	ld	s2,32(sp)
 8f6:	6a42                	ld	s4,16(sp)
 8f8:	6aa2                	ld	s5,8(sp)
 8fa:	6b02                	ld	s6,0(sp)
 8fc:	a03d                	j	92a <malloc+0xea>
 8fe:	7902                	ld	s2,32(sp)
 900:	6a42                	ld	s4,16(sp)
 902:	6aa2                	ld	s5,8(sp)
 904:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 906:	fae489e3          	beq	s1,a4,8b8 <malloc+0x78>
        p->s.size -= nunits;
 90a:	4137073b          	subw	a4,a4,s3
 90e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 910:	02071693          	slli	a3,a4,0x20
 914:	01c6d713          	srli	a4,a3,0x1c
 918:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91e:	00000717          	auipc	a4,0x0
 922:	4ea73123          	sd	a0,1250(a4) # e00 <freep>
      return (void*)(p + 1);
 926:	01078513          	addi	a0,a5,16
  }
}
 92a:	70e2                	ld	ra,56(sp)
 92c:	7442                	ld	s0,48(sp)
 92e:	74a2                	ld	s1,40(sp)
 930:	69e2                	ld	s3,24(sp)
 932:	6121                	addi	sp,sp,64
 934:	8082                	ret
 936:	7902                	ld	s2,32(sp)
 938:	6a42                	ld	s4,16(sp)
 93a:	6aa2                	ld	s5,8(sp)
 93c:	6b02                	ld	s6,0(sp)
 93e:	b7f5                	j	92a <malloc+0xea>
