
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int 
main(int argc, char *argv[]) {
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	addi	s0,sp,64
    if (argc != 1) {
   8:	4785                	li	a5,1
   a:	02f50b63          	beq	a0,a5,40 <main+0x40>
   e:	f426                	sd	s1,40(sp)
        write(1, "usage: sleep", strlen("usage: sleep"));
  10:	00001517          	auipc	a0,0x1
  14:	93050513          	addi	a0,a0,-1744 # 940 <malloc+0x106>
  18:	00000097          	auipc	ra,0x0
  1c:	1de080e7          	jalr	478(ra) # 1f6 <strlen>
  20:	0005061b          	sext.w	a2,a0
  24:	00001597          	auipc	a1,0x1
  28:	91c58593          	addi	a1,a1,-1764 # 940 <malloc+0x106>
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	40c080e7          	jalr	1036(ra) # 43a <write>
        exit(0);
  36:	4501                	li	a0,0
  38:	00000097          	auipc	ra,0x0
  3c:	3e2080e7          	jalr	994(ra) # 41a <exit>
    }

    char byte = 'X';
  40:	05800793          	li	a5,88
  44:	fcf40fa3          	sb	a5,-33(s0)
    int pipe1[2], pipe2[2];
    int pid;
    if (pipe(pipe1) == -1 || pipe(pipe2) == -1) {
  48:	fd040513          	addi	a0,s0,-48
  4c:	00000097          	auipc	ra,0x0
  50:	3de080e7          	jalr	990(ra) # 42a <pipe>
  54:	57fd                	li	a5,-1
  56:	00f50b63          	beq	a0,a5,6c <main+0x6c>
  5a:	fc840513          	addi	a0,s0,-56
  5e:	00000097          	auipc	ra,0x0
  62:	3cc080e7          	jalr	972(ra) # 42a <pipe>
  66:	57fd                	li	a5,-1
  68:	02f51b63          	bne	a0,a5,9e <main+0x9e>
  6c:	f426                	sd	s1,40(sp)
        write(1, "pipe error", strlen("pipe error"));
  6e:	00001517          	auipc	a0,0x1
  72:	8e250513          	addi	a0,a0,-1822 # 950 <malloc+0x116>
  76:	00000097          	auipc	ra,0x0
  7a:	180080e7          	jalr	384(ra) # 1f6 <strlen>
  7e:	0005061b          	sext.w	a2,a0
  82:	00001597          	auipc	a1,0x1
  86:	8ce58593          	addi	a1,a1,-1842 # 950 <malloc+0x116>
  8a:	4505                	li	a0,1
  8c:	00000097          	auipc	ra,0x0
  90:	3ae080e7          	jalr	942(ra) # 43a <write>
        exit(1);
  94:	4505                	li	a0,1
  96:	00000097          	auipc	ra,0x0
  9a:	384080e7          	jalr	900(ra) # 41a <exit>
  9e:	f426                	sd	s1,40(sp)
    }

    pid = fork();
  a0:	00000097          	auipc	ra,0x0
  a4:	372080e7          	jalr	882(ra) # 412 <fork>
  a8:	84aa                	mv	s1,a0
    if (pid == -1) {
  aa:	57fd                	li	a5,-1
  ac:	06f50663          	beq	a0,a5,118 <main+0x118>
        write(1, "fork error", strlen("fork error"));
        exit(1);
    }

    if (pid == 0) { // child process
  b0:	ed41                	bnez	a0,148 <main+0x148>
        read(pipe1[0], &byte, 1);
  b2:	4605                	li	a2,1
  b4:	fdf40593          	addi	a1,s0,-33
  b8:	fd042503          	lw	a0,-48(s0)
  bc:	00000097          	auipc	ra,0x0
  c0:	376080e7          	jalr	886(ra) # 432 <read>
        printf("%d", pid);
  c4:	4581                	li	a1,0
  c6:	00001517          	auipc	a0,0x1
  ca:	8aa50513          	addi	a0,a0,-1878 # 970 <malloc+0x136>
  ce:	00000097          	auipc	ra,0x0
  d2:	6b4080e7          	jalr	1716(ra) # 782 <printf>
        write(1, ": received ping\n", strlen(": received ping\n"));
  d6:	00001517          	auipc	a0,0x1
  da:	8a250513          	addi	a0,a0,-1886 # 978 <malloc+0x13e>
  de:	00000097          	auipc	ra,0x0
  e2:	118080e7          	jalr	280(ra) # 1f6 <strlen>
  e6:	0005061b          	sext.w	a2,a0
  ea:	00001597          	auipc	a1,0x1
  ee:	88e58593          	addi	a1,a1,-1906 # 978 <malloc+0x13e>
  f2:	4505                	li	a0,1
  f4:	00000097          	auipc	ra,0x0
  f8:	346080e7          	jalr	838(ra) # 43a <write>
        write(pipe2[1], &byte, 1);
  fc:	4605                	li	a2,1
  fe:	fdf40593          	addi	a1,s0,-33
 102:	fcc42503          	lw	a0,-52(s0)
 106:	00000097          	auipc	ra,0x0
 10a:	334080e7          	jalr	820(ra) # 43a <write>
        exit(0);
 10e:	4501                	li	a0,0
 110:	00000097          	auipc	ra,0x0
 114:	30a080e7          	jalr	778(ra) # 41a <exit>
        write(1, "fork error", strlen("fork error"));
 118:	00001517          	auipc	a0,0x1
 11c:	84850513          	addi	a0,a0,-1976 # 960 <malloc+0x126>
 120:	00000097          	auipc	ra,0x0
 124:	0d6080e7          	jalr	214(ra) # 1f6 <strlen>
 128:	0005061b          	sext.w	a2,a0
 12c:	00001597          	auipc	a1,0x1
 130:	83458593          	addi	a1,a1,-1996 # 960 <malloc+0x126>
 134:	4505                	li	a0,1
 136:	00000097          	auipc	ra,0x0
 13a:	304080e7          	jalr	772(ra) # 43a <write>
        exit(1);
 13e:	4505                	li	a0,1
 140:	00000097          	auipc	ra,0x0
 144:	2da080e7          	jalr	730(ra) # 41a <exit>
    } else { // parent process
        write(pipe1[1], &byte, 1);
 148:	4605                	li	a2,1
 14a:	fdf40593          	addi	a1,s0,-33
 14e:	fd442503          	lw	a0,-44(s0)
 152:	00000097          	auipc	ra,0x0
 156:	2e8080e7          	jalr	744(ra) # 43a <write>
        read(pipe2[0], &byte, 1);
 15a:	4605                	li	a2,1
 15c:	fdf40593          	addi	a1,s0,-33
 160:	fc842503          	lw	a0,-56(s0)
 164:	00000097          	auipc	ra,0x0
 168:	2ce080e7          	jalr	718(ra) # 432 <read>
        printf("%d", pid);
 16c:	85a6                	mv	a1,s1
 16e:	00001517          	auipc	a0,0x1
 172:	80250513          	addi	a0,a0,-2046 # 970 <malloc+0x136>
 176:	00000097          	auipc	ra,0x0
 17a:	60c080e7          	jalr	1548(ra) # 782 <printf>
        write(1, ": received pong\n", strlen(": received ping\n"));
 17e:	00000517          	auipc	a0,0x0
 182:	7fa50513          	addi	a0,a0,2042 # 978 <malloc+0x13e>
 186:	00000097          	auipc	ra,0x0
 18a:	070080e7          	jalr	112(ra) # 1f6 <strlen>
 18e:	0005061b          	sext.w	a2,a0
 192:	00000597          	auipc	a1,0x0
 196:	7fe58593          	addi	a1,a1,2046 # 990 <malloc+0x156>
 19a:	4505                	li	a0,1
 19c:	00000097          	auipc	ra,0x0
 1a0:	29e080e7          	jalr	670(ra) # 43a <write>
        exit(0);
 1a4:	4501                	li	a0,0
 1a6:	00000097          	auipc	ra,0x0
 1aa:	274080e7          	jalr	628(ra) # 41a <exit>

00000000000001ae <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b4:	87aa                	mv	a5,a0
 1b6:	0585                	addi	a1,a1,1
 1b8:	0785                	addi	a5,a5,1
 1ba:	fff5c703          	lbu	a4,-1(a1)
 1be:	fee78fa3          	sb	a4,-1(a5)
 1c2:	fb75                	bnez	a4,1b6 <strcpy+0x8>
    ;
  return os;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	cb91                	beqz	a5,1e8 <strcmp+0x1e>
 1d6:	0005c703          	lbu	a4,0(a1)
 1da:	00f71763          	bne	a4,a5,1e8 <strcmp+0x1e>
    p++, q++;
 1de:	0505                	addi	a0,a0,1
 1e0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1e2:	00054783          	lbu	a5,0(a0)
 1e6:	fbe5                	bnez	a5,1d6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1e8:	0005c503          	lbu	a0,0(a1)
}
 1ec:	40a7853b          	subw	a0,a5,a0
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret

00000000000001f6 <strlen>:

uint
strlen(const char *s)
{
 1f6:	1141                	addi	sp,sp,-16
 1f8:	e422                	sd	s0,8(sp)
 1fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1fc:	00054783          	lbu	a5,0(a0)
 200:	cf91                	beqz	a5,21c <strlen+0x26>
 202:	0505                	addi	a0,a0,1
 204:	87aa                	mv	a5,a0
 206:	86be                	mv	a3,a5
 208:	0785                	addi	a5,a5,1
 20a:	fff7c703          	lbu	a4,-1(a5)
 20e:	ff65                	bnez	a4,206 <strlen+0x10>
 210:	40a6853b          	subw	a0,a3,a0
 214:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret
  for(n = 0; s[n]; n++)
 21c:	4501                	li	a0,0
 21e:	bfe5                	j	216 <strlen+0x20>

0000000000000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 226:	ca19                	beqz	a2,23c <memset+0x1c>
 228:	87aa                	mv	a5,a0
 22a:	1602                	slli	a2,a2,0x20
 22c:	9201                	srli	a2,a2,0x20
 22e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 232:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 236:	0785                	addi	a5,a5,1
 238:	fee79de3          	bne	a5,a4,232 <memset+0x12>
  }
  return dst;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret

0000000000000242 <strchr>:

char*
strchr(const char *s, char c)
{
 242:	1141                	addi	sp,sp,-16
 244:	e422                	sd	s0,8(sp)
 246:	0800                	addi	s0,sp,16
  for(; *s; s++)
 248:	00054783          	lbu	a5,0(a0)
 24c:	cb99                	beqz	a5,262 <strchr+0x20>
    if(*s == c)
 24e:	00f58763          	beq	a1,a5,25c <strchr+0x1a>
  for(; *s; s++)
 252:	0505                	addi	a0,a0,1
 254:	00054783          	lbu	a5,0(a0)
 258:	fbfd                	bnez	a5,24e <strchr+0xc>
      return (char*)s;
  return 0;
 25a:	4501                	li	a0,0
}
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
  return 0;
 262:	4501                	li	a0,0
 264:	bfe5                	j	25c <strchr+0x1a>

0000000000000266 <gets>:

char*
gets(char *buf, int max)
{
 266:	711d                	addi	sp,sp,-96
 268:	ec86                	sd	ra,88(sp)
 26a:	e8a2                	sd	s0,80(sp)
 26c:	e4a6                	sd	s1,72(sp)
 26e:	e0ca                	sd	s2,64(sp)
 270:	fc4e                	sd	s3,56(sp)
 272:	f852                	sd	s4,48(sp)
 274:	f456                	sd	s5,40(sp)
 276:	f05a                	sd	s6,32(sp)
 278:	ec5e                	sd	s7,24(sp)
 27a:	1080                	addi	s0,sp,96
 27c:	8baa                	mv	s7,a0
 27e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 280:	892a                	mv	s2,a0
 282:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 284:	4aa9                	li	s5,10
 286:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 288:	89a6                	mv	s3,s1
 28a:	2485                	addiw	s1,s1,1
 28c:	0344d863          	bge	s1,s4,2bc <gets+0x56>
    cc = read(0, &c, 1);
 290:	4605                	li	a2,1
 292:	faf40593          	addi	a1,s0,-81
 296:	4501                	li	a0,0
 298:	00000097          	auipc	ra,0x0
 29c:	19a080e7          	jalr	410(ra) # 432 <read>
    if(cc < 1)
 2a0:	00a05e63          	blez	a0,2bc <gets+0x56>
    buf[i++] = c;
 2a4:	faf44783          	lbu	a5,-81(s0)
 2a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2ac:	01578763          	beq	a5,s5,2ba <gets+0x54>
 2b0:	0905                	addi	s2,s2,1
 2b2:	fd679be3          	bne	a5,s6,288 <gets+0x22>
    buf[i++] = c;
 2b6:	89a6                	mv	s3,s1
 2b8:	a011                	j	2bc <gets+0x56>
 2ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2bc:	99de                	add	s3,s3,s7
 2be:	00098023          	sb	zero,0(s3)
  return buf;
}
 2c2:	855e                	mv	a0,s7
 2c4:	60e6                	ld	ra,88(sp)
 2c6:	6446                	ld	s0,80(sp)
 2c8:	64a6                	ld	s1,72(sp)
 2ca:	6906                	ld	s2,64(sp)
 2cc:	79e2                	ld	s3,56(sp)
 2ce:	7a42                	ld	s4,48(sp)
 2d0:	7aa2                	ld	s5,40(sp)
 2d2:	7b02                	ld	s6,32(sp)
 2d4:	6be2                	ld	s7,24(sp)
 2d6:	6125                	addi	sp,sp,96
 2d8:	8082                	ret

00000000000002da <stat>:

int
stat(const char *n, struct stat *st)
{
 2da:	1101                	addi	sp,sp,-32
 2dc:	ec06                	sd	ra,24(sp)
 2de:	e822                	sd	s0,16(sp)
 2e0:	e04a                	sd	s2,0(sp)
 2e2:	1000                	addi	s0,sp,32
 2e4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e6:	4581                	li	a1,0
 2e8:	00000097          	auipc	ra,0x0
 2ec:	172080e7          	jalr	370(ra) # 45a <open>
  if(fd < 0)
 2f0:	02054663          	bltz	a0,31c <stat+0x42>
 2f4:	e426                	sd	s1,8(sp)
 2f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2f8:	85ca                	mv	a1,s2
 2fa:	00000097          	auipc	ra,0x0
 2fe:	178080e7          	jalr	376(ra) # 472 <fstat>
 302:	892a                	mv	s2,a0
  close(fd);
 304:	8526                	mv	a0,s1
 306:	00000097          	auipc	ra,0x0
 30a:	13c080e7          	jalr	316(ra) # 442 <close>
  return r;
 30e:	64a2                	ld	s1,8(sp)
}
 310:	854a                	mv	a0,s2
 312:	60e2                	ld	ra,24(sp)
 314:	6442                	ld	s0,16(sp)
 316:	6902                	ld	s2,0(sp)
 318:	6105                	addi	sp,sp,32
 31a:	8082                	ret
    return -1;
 31c:	597d                	li	s2,-1
 31e:	bfcd                	j	310 <stat+0x36>

0000000000000320 <atoi>:

int
atoi(const char *s)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 326:	00054683          	lbu	a3,0(a0)
 32a:	fd06879b          	addiw	a5,a3,-48
 32e:	0ff7f793          	zext.b	a5,a5
 332:	4625                	li	a2,9
 334:	02f66863          	bltu	a2,a5,364 <atoi+0x44>
 338:	872a                	mv	a4,a0
  n = 0;
 33a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 33c:	0705                	addi	a4,a4,1
 33e:	0025179b          	slliw	a5,a0,0x2
 342:	9fa9                	addw	a5,a5,a0
 344:	0017979b          	slliw	a5,a5,0x1
 348:	9fb5                	addw	a5,a5,a3
 34a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 34e:	00074683          	lbu	a3,0(a4)
 352:	fd06879b          	addiw	a5,a3,-48
 356:	0ff7f793          	zext.b	a5,a5
 35a:	fef671e3          	bgeu	a2,a5,33c <atoi+0x1c>
  return n;
}
 35e:	6422                	ld	s0,8(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret
  n = 0;
 364:	4501                	li	a0,0
 366:	bfe5                	j	35e <atoi+0x3e>

0000000000000368 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 368:	1141                	addi	sp,sp,-16
 36a:	e422                	sd	s0,8(sp)
 36c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 36e:	02b57463          	bgeu	a0,a1,396 <memmove+0x2e>
    while(n-- > 0)
 372:	00c05f63          	blez	a2,390 <memmove+0x28>
 376:	1602                	slli	a2,a2,0x20
 378:	9201                	srli	a2,a2,0x20
 37a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 37e:	872a                	mv	a4,a0
      *dst++ = *src++;
 380:	0585                	addi	a1,a1,1
 382:	0705                	addi	a4,a4,1
 384:	fff5c683          	lbu	a3,-1(a1)
 388:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 38c:	fef71ae3          	bne	a4,a5,380 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 390:	6422                	ld	s0,8(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret
    dst += n;
 396:	00c50733          	add	a4,a0,a2
    src += n;
 39a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 39c:	fec05ae3          	blez	a2,390 <memmove+0x28>
 3a0:	fff6079b          	addiw	a5,a2,-1
 3a4:	1782                	slli	a5,a5,0x20
 3a6:	9381                	srli	a5,a5,0x20
 3a8:	fff7c793          	not	a5,a5
 3ac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ae:	15fd                	addi	a1,a1,-1
 3b0:	177d                	addi	a4,a4,-1
 3b2:	0005c683          	lbu	a3,0(a1)
 3b6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ba:	fee79ae3          	bne	a5,a4,3ae <memmove+0x46>
 3be:	bfc9                	j	390 <memmove+0x28>

00000000000003c0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3c6:	ca05                	beqz	a2,3f6 <memcmp+0x36>
 3c8:	fff6069b          	addiw	a3,a2,-1
 3cc:	1682                	slli	a3,a3,0x20
 3ce:	9281                	srli	a3,a3,0x20
 3d0:	0685                	addi	a3,a3,1
 3d2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3d4:	00054783          	lbu	a5,0(a0)
 3d8:	0005c703          	lbu	a4,0(a1)
 3dc:	00e79863          	bne	a5,a4,3ec <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3e0:	0505                	addi	a0,a0,1
    p2++;
 3e2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e4:	fed518e3          	bne	a0,a3,3d4 <memcmp+0x14>
  }
  return 0;
 3e8:	4501                	li	a0,0
 3ea:	a019                	j	3f0 <memcmp+0x30>
      return *p1 - *p2;
 3ec:	40e7853b          	subw	a0,a5,a4
}
 3f0:	6422                	ld	s0,8(sp)
 3f2:	0141                	addi	sp,sp,16
 3f4:	8082                	ret
  return 0;
 3f6:	4501                	li	a0,0
 3f8:	bfe5                	j	3f0 <memcmp+0x30>

00000000000003fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e406                	sd	ra,8(sp)
 3fe:	e022                	sd	s0,0(sp)
 400:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 402:	00000097          	auipc	ra,0x0
 406:	f66080e7          	jalr	-154(ra) # 368 <memmove>
}
 40a:	60a2                	ld	ra,8(sp)
 40c:	6402                	ld	s0,0(sp)
 40e:	0141                	addi	sp,sp,16
 410:	8082                	ret

0000000000000412 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 412:	4885                	li	a7,1
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <exit>:
.global exit
exit:
 li a7, SYS_exit
 41a:	4889                	li	a7,2
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <wait>:
.global wait
wait:
 li a7, SYS_wait
 422:	488d                	li	a7,3
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 42a:	4891                	li	a7,4
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <read>:
.global read
read:
 li a7, SYS_read
 432:	4895                	li	a7,5
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <write>:
.global write
write:
 li a7, SYS_write
 43a:	48c1                	li	a7,16
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <close>:
.global close
close:
 li a7, SYS_close
 442:	48d5                	li	a7,21
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <kill>:
.global kill
kill:
 li a7, SYS_kill
 44a:	4899                	li	a7,6
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <exec>:
.global exec
exec:
 li a7, SYS_exec
 452:	489d                	li	a7,7
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <open>:
.global open
open:
 li a7, SYS_open
 45a:	48bd                	li	a7,15
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 462:	48c5                	li	a7,17
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 46a:	48c9                	li	a7,18
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 472:	48a1                	li	a7,8
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <link>:
.global link
link:
 li a7, SYS_link
 47a:	48cd                	li	a7,19
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 482:	48d1                	li	a7,20
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 48a:	48a5                	li	a7,9
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <dup>:
.global dup
dup:
 li a7, SYS_dup
 492:	48a9                	li	a7,10
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 49a:	48ad                	li	a7,11
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4a2:	48b1                	li	a7,12
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4aa:	48b5                	li	a7,13
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b2:	48b9                	li	a7,14
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ba:	1101                	addi	sp,sp,-32
 4bc:	ec06                	sd	ra,24(sp)
 4be:	e822                	sd	s0,16(sp)
 4c0:	1000                	addi	s0,sp,32
 4c2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c6:	4605                	li	a2,1
 4c8:	fef40593          	addi	a1,s0,-17
 4cc:	00000097          	auipc	ra,0x0
 4d0:	f6e080e7          	jalr	-146(ra) # 43a <write>
}
 4d4:	60e2                	ld	ra,24(sp)
 4d6:	6442                	ld	s0,16(sp)
 4d8:	6105                	addi	sp,sp,32
 4da:	8082                	ret

00000000000004dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4dc:	7139                	addi	sp,sp,-64
 4de:	fc06                	sd	ra,56(sp)
 4e0:	f822                	sd	s0,48(sp)
 4e2:	f426                	sd	s1,40(sp)
 4e4:	0080                	addi	s0,sp,64
 4e6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e8:	c299                	beqz	a3,4ee <printint+0x12>
 4ea:	0805cb63          	bltz	a1,580 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ee:	2581                	sext.w	a1,a1
  neg = 0;
 4f0:	4881                	li	a7,0
 4f2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4f6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4f8:	2601                	sext.w	a2,a2
 4fa:	00000517          	auipc	a0,0x0
 4fe:	50e50513          	addi	a0,a0,1294 # a08 <digits>
 502:	883a                	mv	a6,a4
 504:	2705                	addiw	a4,a4,1
 506:	02c5f7bb          	remuw	a5,a1,a2
 50a:	1782                	slli	a5,a5,0x20
 50c:	9381                	srli	a5,a5,0x20
 50e:	97aa                	add	a5,a5,a0
 510:	0007c783          	lbu	a5,0(a5)
 514:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 518:	0005879b          	sext.w	a5,a1
 51c:	02c5d5bb          	divuw	a1,a1,a2
 520:	0685                	addi	a3,a3,1
 522:	fec7f0e3          	bgeu	a5,a2,502 <printint+0x26>
  if(neg)
 526:	00088c63          	beqz	a7,53e <printint+0x62>
    buf[i++] = '-';
 52a:	fd070793          	addi	a5,a4,-48
 52e:	00878733          	add	a4,a5,s0
 532:	02d00793          	li	a5,45
 536:	fef70823          	sb	a5,-16(a4)
 53a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 53e:	02e05c63          	blez	a4,576 <printint+0x9a>
 542:	f04a                	sd	s2,32(sp)
 544:	ec4e                	sd	s3,24(sp)
 546:	fc040793          	addi	a5,s0,-64
 54a:	00e78933          	add	s2,a5,a4
 54e:	fff78993          	addi	s3,a5,-1
 552:	99ba                	add	s3,s3,a4
 554:	377d                	addiw	a4,a4,-1
 556:	1702                	slli	a4,a4,0x20
 558:	9301                	srli	a4,a4,0x20
 55a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 55e:	fff94583          	lbu	a1,-1(s2)
 562:	8526                	mv	a0,s1
 564:	00000097          	auipc	ra,0x0
 568:	f56080e7          	jalr	-170(ra) # 4ba <putc>
  while(--i >= 0)
 56c:	197d                	addi	s2,s2,-1
 56e:	ff3918e3          	bne	s2,s3,55e <printint+0x82>
 572:	7902                	ld	s2,32(sp)
 574:	69e2                	ld	s3,24(sp)
}
 576:	70e2                	ld	ra,56(sp)
 578:	7442                	ld	s0,48(sp)
 57a:	74a2                	ld	s1,40(sp)
 57c:	6121                	addi	sp,sp,64
 57e:	8082                	ret
    x = -xx;
 580:	40b005bb          	negw	a1,a1
    neg = 1;
 584:	4885                	li	a7,1
    x = -xx;
 586:	b7b5                	j	4f2 <printint+0x16>

0000000000000588 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 588:	715d                	addi	sp,sp,-80
 58a:	e486                	sd	ra,72(sp)
 58c:	e0a2                	sd	s0,64(sp)
 58e:	f84a                	sd	s2,48(sp)
 590:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 592:	0005c903          	lbu	s2,0(a1)
 596:	1a090a63          	beqz	s2,74a <vprintf+0x1c2>
 59a:	fc26                	sd	s1,56(sp)
 59c:	f44e                	sd	s3,40(sp)
 59e:	f052                	sd	s4,32(sp)
 5a0:	ec56                	sd	s5,24(sp)
 5a2:	e85a                	sd	s6,16(sp)
 5a4:	e45e                	sd	s7,8(sp)
 5a6:	8aaa                	mv	s5,a0
 5a8:	8bb2                	mv	s7,a2
 5aa:	00158493          	addi	s1,a1,1
  state = 0;
 5ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b0:	02500a13          	li	s4,37
 5b4:	4b55                	li	s6,21
 5b6:	a839                	j	5d4 <vprintf+0x4c>
        putc(fd, c);
 5b8:	85ca                	mv	a1,s2
 5ba:	8556                	mv	a0,s5
 5bc:	00000097          	auipc	ra,0x0
 5c0:	efe080e7          	jalr	-258(ra) # 4ba <putc>
 5c4:	a019                	j	5ca <vprintf+0x42>
    } else if(state == '%'){
 5c6:	01498d63          	beq	s3,s4,5e0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5ca:	0485                	addi	s1,s1,1
 5cc:	fff4c903          	lbu	s2,-1(s1)
 5d0:	16090763          	beqz	s2,73e <vprintf+0x1b6>
    if(state == 0){
 5d4:	fe0999e3          	bnez	s3,5c6 <vprintf+0x3e>
      if(c == '%'){
 5d8:	ff4910e3          	bne	s2,s4,5b8 <vprintf+0x30>
        state = '%';
 5dc:	89d2                	mv	s3,s4
 5de:	b7f5                	j	5ca <vprintf+0x42>
      if(c == 'd'){
 5e0:	13490463          	beq	s2,s4,708 <vprintf+0x180>
 5e4:	f9d9079b          	addiw	a5,s2,-99
 5e8:	0ff7f793          	zext.b	a5,a5
 5ec:	12fb6763          	bltu	s6,a5,71a <vprintf+0x192>
 5f0:	f9d9079b          	addiw	a5,s2,-99
 5f4:	0ff7f713          	zext.b	a4,a5
 5f8:	12eb6163          	bltu	s6,a4,71a <vprintf+0x192>
 5fc:	00271793          	slli	a5,a4,0x2
 600:	00000717          	auipc	a4,0x0
 604:	3b070713          	addi	a4,a4,944 # 9b0 <malloc+0x176>
 608:	97ba                	add	a5,a5,a4
 60a:	439c                	lw	a5,0(a5)
 60c:	97ba                	add	a5,a5,a4
 60e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 610:	008b8913          	addi	s2,s7,8
 614:	4685                	li	a3,1
 616:	4629                	li	a2,10
 618:	000ba583          	lw	a1,0(s7)
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	ebe080e7          	jalr	-322(ra) # 4dc <printint>
 626:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 628:	4981                	li	s3,0
 62a:	b745                	j	5ca <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 62c:	008b8913          	addi	s2,s7,8
 630:	4681                	li	a3,0
 632:	4629                	li	a2,10
 634:	000ba583          	lw	a1,0(s7)
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	ea2080e7          	jalr	-350(ra) # 4dc <printint>
 642:	8bca                	mv	s7,s2
      state = 0;
 644:	4981                	li	s3,0
 646:	b751                	j	5ca <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 648:	008b8913          	addi	s2,s7,8
 64c:	4681                	li	a3,0
 64e:	4641                	li	a2,16
 650:	000ba583          	lw	a1,0(s7)
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	e86080e7          	jalr	-378(ra) # 4dc <printint>
 65e:	8bca                	mv	s7,s2
      state = 0;
 660:	4981                	li	s3,0
 662:	b7a5                	j	5ca <vprintf+0x42>
 664:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 666:	008b8c13          	addi	s8,s7,8
 66a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 66e:	03000593          	li	a1,48
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	e46080e7          	jalr	-442(ra) # 4ba <putc>
  putc(fd, 'x');
 67c:	07800593          	li	a1,120
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	e38080e7          	jalr	-456(ra) # 4ba <putc>
 68a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68c:	00000b97          	auipc	s7,0x0
 690:	37cb8b93          	addi	s7,s7,892 # a08 <digits>
 694:	03c9d793          	srli	a5,s3,0x3c
 698:	97de                	add	a5,a5,s7
 69a:	0007c583          	lbu	a1,0(a5)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	e1a080e7          	jalr	-486(ra) # 4ba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a8:	0992                	slli	s3,s3,0x4
 6aa:	397d                	addiw	s2,s2,-1
 6ac:	fe0914e3          	bnez	s2,694 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6b0:	8be2                	mv	s7,s8
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	6c02                	ld	s8,0(sp)
 6b6:	bf11                	j	5ca <vprintf+0x42>
        s = va_arg(ap, char*);
 6b8:	008b8993          	addi	s3,s7,8
 6bc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6c0:	02090163          	beqz	s2,6e2 <vprintf+0x15a>
        while(*s != 0){
 6c4:	00094583          	lbu	a1,0(s2)
 6c8:	c9a5                	beqz	a1,738 <vprintf+0x1b0>
          putc(fd, *s);
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	dee080e7          	jalr	-530(ra) # 4ba <putc>
          s++;
 6d4:	0905                	addi	s2,s2,1
        while(*s != 0){
 6d6:	00094583          	lbu	a1,0(s2)
 6da:	f9e5                	bnez	a1,6ca <vprintf+0x142>
        s = va_arg(ap, char*);
 6dc:	8bce                	mv	s7,s3
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	b5ed                	j	5ca <vprintf+0x42>
          s = "(null)";
 6e2:	00000917          	auipc	s2,0x0
 6e6:	2c690913          	addi	s2,s2,710 # 9a8 <malloc+0x16e>
        while(*s != 0){
 6ea:	02800593          	li	a1,40
 6ee:	bff1                	j	6ca <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	000bc583          	lbu	a1,0(s7)
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	dc0080e7          	jalr	-576(ra) # 4ba <putc>
 702:	8bca                	mv	s7,s2
      state = 0;
 704:	4981                	li	s3,0
 706:	b5d1                	j	5ca <vprintf+0x42>
        putc(fd, c);
 708:	02500593          	li	a1,37
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	dac080e7          	jalr	-596(ra) # 4ba <putc>
      state = 0;
 716:	4981                	li	s3,0
 718:	bd4d                	j	5ca <vprintf+0x42>
        putc(fd, '%');
 71a:	02500593          	li	a1,37
 71e:	8556                	mv	a0,s5
 720:	00000097          	auipc	ra,0x0
 724:	d9a080e7          	jalr	-614(ra) # 4ba <putc>
        putc(fd, c);
 728:	85ca                	mv	a1,s2
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	d8e080e7          	jalr	-626(ra) # 4ba <putc>
      state = 0;
 734:	4981                	li	s3,0
 736:	bd51                	j	5ca <vprintf+0x42>
        s = va_arg(ap, char*);
 738:	8bce                	mv	s7,s3
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b579                	j	5ca <vprintf+0x42>
 73e:	74e2                	ld	s1,56(sp)
 740:	79a2                	ld	s3,40(sp)
 742:	7a02                	ld	s4,32(sp)
 744:	6ae2                	ld	s5,24(sp)
 746:	6b42                	ld	s6,16(sp)
 748:	6ba2                	ld	s7,8(sp)
    }
  }
}
 74a:	60a6                	ld	ra,72(sp)
 74c:	6406                	ld	s0,64(sp)
 74e:	7942                	ld	s2,48(sp)
 750:	6161                	addi	sp,sp,80
 752:	8082                	ret

0000000000000754 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 754:	715d                	addi	sp,sp,-80
 756:	ec06                	sd	ra,24(sp)
 758:	e822                	sd	s0,16(sp)
 75a:	1000                	addi	s0,sp,32
 75c:	e010                	sd	a2,0(s0)
 75e:	e414                	sd	a3,8(s0)
 760:	e818                	sd	a4,16(s0)
 762:	ec1c                	sd	a5,24(s0)
 764:	03043023          	sd	a6,32(s0)
 768:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 770:	8622                	mv	a2,s0
 772:	00000097          	auipc	ra,0x0
 776:	e16080e7          	jalr	-490(ra) # 588 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <printf>:

void
printf(const char *fmt, ...)
{
 782:	711d                	addi	sp,sp,-96
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e40c                	sd	a1,8(s0)
 78c:	e810                	sd	a2,16(s0)
 78e:	ec14                	sd	a3,24(s0)
 790:	f018                	sd	a4,32(s0)
 792:	f41c                	sd	a5,40(s0)
 794:	03043823          	sd	a6,48(s0)
 798:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	00840613          	addi	a2,s0,8
 7a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a4:	85aa                	mv	a1,a0
 7a6:	4505                	li	a0,1
 7a8:	00000097          	auipc	ra,0x0
 7ac:	de0080e7          	jalr	-544(ra) # 588 <vprintf>
}
 7b0:	60e2                	ld	ra,24(sp)
 7b2:	6442                	ld	s0,16(sp)
 7b4:	6125                	addi	sp,sp,96
 7b6:	8082                	ret

00000000000007b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b8:	1141                	addi	sp,sp,-16
 7ba:	e422                	sd	s0,8(sp)
 7bc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7be:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	00000797          	auipc	a5,0x0
 7c6:	61e7b783          	ld	a5,1566(a5) # de0 <freep>
 7ca:	a02d                	j	7f4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7cc:	4618                	lw	a4,8(a2)
 7ce:	9f2d                	addw	a4,a4,a1
 7d0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d4:	6398                	ld	a4,0(a5)
 7d6:	6310                	ld	a2,0(a4)
 7d8:	a83d                	j	816 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7da:	ff852703          	lw	a4,-8(a0)
 7de:	9f31                	addw	a4,a4,a2
 7e0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7e2:	ff053683          	ld	a3,-16(a0)
 7e6:	a091                	j	82a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e7e463          	bltu	a5,a4,7f2 <free+0x3a>
 7ee:	00e6ea63          	bltu	a3,a4,802 <free+0x4a>
{
 7f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f4:	fed7fae3          	bgeu	a5,a3,7e8 <free+0x30>
 7f8:	6398                	ld	a4,0(a5)
 7fa:	00e6e463          	bltu	a3,a4,802 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	fee7eae3          	bltu	a5,a4,7f2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 802:	ff852583          	lw	a1,-8(a0)
 806:	6390                	ld	a2,0(a5)
 808:	02059813          	slli	a6,a1,0x20
 80c:	01c85713          	srli	a4,a6,0x1c
 810:	9736                	add	a4,a4,a3
 812:	fae60de3          	beq	a2,a4,7cc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 816:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 81a:	4790                	lw	a2,8(a5)
 81c:	02061593          	slli	a1,a2,0x20
 820:	01c5d713          	srli	a4,a1,0x1c
 824:	973e                	add	a4,a4,a5
 826:	fae68ae3          	beq	a3,a4,7da <free+0x22>
    p->s.ptr = bp->s.ptr;
 82a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 82c:	00000717          	auipc	a4,0x0
 830:	5af73a23          	sd	a5,1460(a4) # de0 <freep>
}
 834:	6422                	ld	s0,8(sp)
 836:	0141                	addi	sp,sp,16
 838:	8082                	ret

000000000000083a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 83a:	7139                	addi	sp,sp,-64
 83c:	fc06                	sd	ra,56(sp)
 83e:	f822                	sd	s0,48(sp)
 840:	f426                	sd	s1,40(sp)
 842:	ec4e                	sd	s3,24(sp)
 844:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 846:	02051493          	slli	s1,a0,0x20
 84a:	9081                	srli	s1,s1,0x20
 84c:	04bd                	addi	s1,s1,15
 84e:	8091                	srli	s1,s1,0x4
 850:	0014899b          	addiw	s3,s1,1
 854:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 856:	00000517          	auipc	a0,0x0
 85a:	58a53503          	ld	a0,1418(a0) # de0 <freep>
 85e:	c915                	beqz	a0,892 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 862:	4798                	lw	a4,8(a5)
 864:	08977e63          	bgeu	a4,s1,900 <malloc+0xc6>
 868:	f04a                	sd	s2,32(sp)
 86a:	e852                	sd	s4,16(sp)
 86c:	e456                	sd	s5,8(sp)
 86e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 870:	8a4e                	mv	s4,s3
 872:	0009871b          	sext.w	a4,s3
 876:	6685                	lui	a3,0x1
 878:	00d77363          	bgeu	a4,a3,87e <malloc+0x44>
 87c:	6a05                	lui	s4,0x1
 87e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 882:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 886:	00000917          	auipc	s2,0x0
 88a:	55a90913          	addi	s2,s2,1370 # de0 <freep>
  if(p == (char*)-1)
 88e:	5afd                	li	s5,-1
 890:	a091                	j	8d4 <malloc+0x9a>
 892:	f04a                	sd	s2,32(sp)
 894:	e852                	sd	s4,16(sp)
 896:	e456                	sd	s5,8(sp)
 898:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 89a:	00000797          	auipc	a5,0x0
 89e:	54e78793          	addi	a5,a5,1358 # de8 <base>
 8a2:	00000717          	auipc	a4,0x0
 8a6:	52f73f23          	sd	a5,1342(a4) # de0 <freep>
 8aa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b0:	b7c1                	j	870 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8b2:	6398                	ld	a4,0(a5)
 8b4:	e118                	sd	a4,0(a0)
 8b6:	a08d                	j	918 <malloc+0xde>
  hp->s.size = nu;
 8b8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8bc:	0541                	addi	a0,a0,16
 8be:	00000097          	auipc	ra,0x0
 8c2:	efa080e7          	jalr	-262(ra) # 7b8 <free>
  return freep;
 8c6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ca:	c13d                	beqz	a0,930 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ce:	4798                	lw	a4,8(a5)
 8d0:	02977463          	bgeu	a4,s1,8f8 <malloc+0xbe>
    if(p == freep)
 8d4:	00093703          	ld	a4,0(s2)
 8d8:	853e                	mv	a0,a5
 8da:	fef719e3          	bne	a4,a5,8cc <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 8de:	8552                	mv	a0,s4
 8e0:	00000097          	auipc	ra,0x0
 8e4:	bc2080e7          	jalr	-1086(ra) # 4a2 <sbrk>
  if(p == (char*)-1)
 8e8:	fd5518e3          	bne	a0,s5,8b8 <malloc+0x7e>
        return 0;
 8ec:	4501                	li	a0,0
 8ee:	7902                	ld	s2,32(sp)
 8f0:	6a42                	ld	s4,16(sp)
 8f2:	6aa2                	ld	s5,8(sp)
 8f4:	6b02                	ld	s6,0(sp)
 8f6:	a03d                	j	924 <malloc+0xea>
 8f8:	7902                	ld	s2,32(sp)
 8fa:	6a42                	ld	s4,16(sp)
 8fc:	6aa2                	ld	s5,8(sp)
 8fe:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 900:	fae489e3          	beq	s1,a4,8b2 <malloc+0x78>
        p->s.size -= nunits;
 904:	4137073b          	subw	a4,a4,s3
 908:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90a:	02071693          	slli	a3,a4,0x20
 90e:	01c6d713          	srli	a4,a3,0x1c
 912:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 914:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 918:	00000717          	auipc	a4,0x0
 91c:	4ca73423          	sd	a0,1224(a4) # de0 <freep>
      return (void*)(p + 1);
 920:	01078513          	addi	a0,a5,16
  }
}
 924:	70e2                	ld	ra,56(sp)
 926:	7442                	ld	s0,48(sp)
 928:	74a2                	ld	s1,40(sp)
 92a:	69e2                	ld	s3,24(sp)
 92c:	6121                	addi	sp,sp,64
 92e:	8082                	ret
 930:	7902                	ld	s2,32(sp)
 932:	6a42                	ld	s4,16(sp)
 934:	6aa2                	ld	s5,8(sp)
 936:	6b02                	ld	s6,0(sp)
 938:	b7f5                	j	924 <malloc+0xea>
