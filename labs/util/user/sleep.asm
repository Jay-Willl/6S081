
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[]) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc == 1 || argc > 2) {
   8:	4785                	li	a5,1
   a:	00f50563          	beq	a0,a5,14 <main+0x14>
   e:	4789                	li	a5,2
  10:	02a7da63          	bge	a5,a0,44 <main+0x44>
        write(1, "usage: sleep number\n", strlen("usage: sleep number\n"));
  14:	00000517          	auipc	a0,0x0
  18:	7dc50513          	addi	a0,a0,2012 # 7f0 <malloc+0x104>
  1c:	00000097          	auipc	ra,0x0
  20:	08c080e7          	jalr	140(ra) # a8 <strlen>
  24:	0005061b          	sext.w	a2,a0
  28:	00000597          	auipc	a1,0x0
  2c:	7c858593          	addi	a1,a1,1992 # 7f0 <malloc+0x104>
  30:	4505                	li	a0,1
  32:	00000097          	auipc	ra,0x0
  36:	2ba080e7          	jalr	698(ra) # 2ec <write>
        exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	290080e7          	jalr	656(ra) # 2cc <exit>
    }
    int n = atoi(argv[1]);
  44:	6588                	ld	a0,8(a1)
  46:	00000097          	auipc	ra,0x0
  4a:	18c080e7          	jalr	396(ra) # 1d2 <atoi>
    sleep(n);
  4e:	00000097          	auipc	ra,0x0
  52:	30e080e7          	jalr	782(ra) # 35c <sleep>
    exit(0);
  56:	4501                	li	a0,0
  58:	00000097          	auipc	ra,0x0
  5c:	274080e7          	jalr	628(ra) # 2cc <exit>

0000000000000060 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  66:	87aa                	mv	a5,a0
  68:	0585                	addi	a1,a1,1
  6a:	0785                	addi	a5,a5,1
  6c:	fff5c703          	lbu	a4,-1(a1)
  70:	fee78fa3          	sb	a4,-1(a5)
  74:	fb75                	bnez	a4,68 <strcpy+0x8>
    ;
  return os;
}
  76:	6422                	ld	s0,8(sp)
  78:	0141                	addi	sp,sp,16
  7a:	8082                	ret

000000000000007c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e422                	sd	s0,8(sp)
  80:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  82:	00054783          	lbu	a5,0(a0)
  86:	cb91                	beqz	a5,9a <strcmp+0x1e>
  88:	0005c703          	lbu	a4,0(a1)
  8c:	00f71763          	bne	a4,a5,9a <strcmp+0x1e>
    p++, q++;
  90:	0505                	addi	a0,a0,1
  92:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  94:	00054783          	lbu	a5,0(a0)
  98:	fbe5                	bnez	a5,88 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9a:	0005c503          	lbu	a0,0(a1)
}
  9e:	40a7853b          	subw	a0,a5,a0
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strlen>:

uint
strlen(const char *s)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf91                	beqz	a5,ce <strlen+0x26>
  b4:	0505                	addi	a0,a0,1
  b6:	87aa                	mv	a5,a0
  b8:	86be                	mv	a3,a5
  ba:	0785                	addi	a5,a5,1
  bc:	fff7c703          	lbu	a4,-1(a5)
  c0:	ff65                	bnez	a4,b8 <strlen+0x10>
  c2:	40a6853b          	subw	a0,a3,a0
  c6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret
  for(n = 0; s[n]; n++)
  ce:	4501                	li	a0,0
  d0:	bfe5                	j	c8 <strlen+0x20>

00000000000000d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d8:	ca19                	beqz	a2,ee <memset+0x1c>
  da:	87aa                	mv	a5,a0
  dc:	1602                	slli	a2,a2,0x20
  de:	9201                	srli	a2,a2,0x20
  e0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e8:	0785                	addi	a5,a5,1
  ea:	fee79de3          	bne	a5,a4,e4 <memset+0x12>
  }
  return dst;
}
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strchr>:

char*
strchr(const char *s, char c)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  for(; *s; s++)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	cb99                	beqz	a5,114 <strchr+0x20>
    if(*s == c)
 100:	00f58763          	beq	a1,a5,10e <strchr+0x1a>
  for(; *s; s++)
 104:	0505                	addi	a0,a0,1
 106:	00054783          	lbu	a5,0(a0)
 10a:	fbfd                	bnez	a5,100 <strchr+0xc>
      return (char*)s;
  return 0;
 10c:	4501                	li	a0,0
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
  return 0;
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strchr+0x1a>

0000000000000118 <gets>:

char*
gets(char *buf, int max)
{
 118:	711d                	addi	sp,sp,-96
 11a:	ec86                	sd	ra,88(sp)
 11c:	e8a2                	sd	s0,80(sp)
 11e:	e4a6                	sd	s1,72(sp)
 120:	e0ca                	sd	s2,64(sp)
 122:	fc4e                	sd	s3,56(sp)
 124:	f852                	sd	s4,48(sp)
 126:	f456                	sd	s5,40(sp)
 128:	f05a                	sd	s6,32(sp)
 12a:	ec5e                	sd	s7,24(sp)
 12c:	1080                	addi	s0,sp,96
 12e:	8baa                	mv	s7,a0
 130:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 132:	892a                	mv	s2,a0
 134:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 136:	4aa9                	li	s5,10
 138:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13a:	89a6                	mv	s3,s1
 13c:	2485                	addiw	s1,s1,1
 13e:	0344d863          	bge	s1,s4,16e <gets+0x56>
    cc = read(0, &c, 1);
 142:	4605                	li	a2,1
 144:	faf40593          	addi	a1,s0,-81
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	19a080e7          	jalr	410(ra) # 2e4 <read>
    if(cc < 1)
 152:	00a05e63          	blez	a0,16e <gets+0x56>
    buf[i++] = c;
 156:	faf44783          	lbu	a5,-81(s0)
 15a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15e:	01578763          	beq	a5,s5,16c <gets+0x54>
 162:	0905                	addi	s2,s2,1
 164:	fd679be3          	bne	a5,s6,13a <gets+0x22>
    buf[i++] = c;
 168:	89a6                	mv	s3,s1
 16a:	a011                	j	16e <gets+0x56>
 16c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16e:	99de                	add	s3,s3,s7
 170:	00098023          	sb	zero,0(s3)
  return buf;
}
 174:	855e                	mv	a0,s7
 176:	60e6                	ld	ra,88(sp)
 178:	6446                	ld	s0,80(sp)
 17a:	64a6                	ld	s1,72(sp)
 17c:	6906                	ld	s2,64(sp)
 17e:	79e2                	ld	s3,56(sp)
 180:	7a42                	ld	s4,48(sp)
 182:	7aa2                	ld	s5,40(sp)
 184:	7b02                	ld	s6,32(sp)
 186:	6be2                	ld	s7,24(sp)
 188:	6125                	addi	sp,sp,96
 18a:	8082                	ret

000000000000018c <stat>:

int
stat(const char *n, struct stat *st)
{
 18c:	1101                	addi	sp,sp,-32
 18e:	ec06                	sd	ra,24(sp)
 190:	e822                	sd	s0,16(sp)
 192:	e04a                	sd	s2,0(sp)
 194:	1000                	addi	s0,sp,32
 196:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 198:	4581                	li	a1,0
 19a:	00000097          	auipc	ra,0x0
 19e:	172080e7          	jalr	370(ra) # 30c <open>
  if(fd < 0)
 1a2:	02054663          	bltz	a0,1ce <stat+0x42>
 1a6:	e426                	sd	s1,8(sp)
 1a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1aa:	85ca                	mv	a1,s2
 1ac:	00000097          	auipc	ra,0x0
 1b0:	178080e7          	jalr	376(ra) # 324 <fstat>
 1b4:	892a                	mv	s2,a0
  close(fd);
 1b6:	8526                	mv	a0,s1
 1b8:	00000097          	auipc	ra,0x0
 1bc:	13c080e7          	jalr	316(ra) # 2f4 <close>
  return r;
 1c0:	64a2                	ld	s1,8(sp)
}
 1c2:	854a                	mv	a0,s2
 1c4:	60e2                	ld	ra,24(sp)
 1c6:	6442                	ld	s0,16(sp)
 1c8:	6902                	ld	s2,0(sp)
 1ca:	6105                	addi	sp,sp,32
 1cc:	8082                	ret
    return -1;
 1ce:	597d                	li	s2,-1
 1d0:	bfcd                	j	1c2 <stat+0x36>

00000000000001d2 <atoi>:

int
atoi(const char *s)
{
 1d2:	1141                	addi	sp,sp,-16
 1d4:	e422                	sd	s0,8(sp)
 1d6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d8:	00054683          	lbu	a3,0(a0)
 1dc:	fd06879b          	addiw	a5,a3,-48
 1e0:	0ff7f793          	zext.b	a5,a5
 1e4:	4625                	li	a2,9
 1e6:	02f66863          	bltu	a2,a5,216 <atoi+0x44>
 1ea:	872a                	mv	a4,a0
  n = 0;
 1ec:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ee:	0705                	addi	a4,a4,1
 1f0:	0025179b          	slliw	a5,a0,0x2
 1f4:	9fa9                	addw	a5,a5,a0
 1f6:	0017979b          	slliw	a5,a5,0x1
 1fa:	9fb5                	addw	a5,a5,a3
 1fc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 200:	00074683          	lbu	a3,0(a4)
 204:	fd06879b          	addiw	a5,a3,-48
 208:	0ff7f793          	zext.b	a5,a5
 20c:	fef671e3          	bgeu	a2,a5,1ee <atoi+0x1c>
  return n;
}
 210:	6422                	ld	s0,8(sp)
 212:	0141                	addi	sp,sp,16
 214:	8082                	ret
  n = 0;
 216:	4501                	li	a0,0
 218:	bfe5                	j	210 <atoi+0x3e>

000000000000021a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 220:	02b57463          	bgeu	a0,a1,248 <memmove+0x2e>
    while(n-- > 0)
 224:	00c05f63          	blez	a2,242 <memmove+0x28>
 228:	1602                	slli	a2,a2,0x20
 22a:	9201                	srli	a2,a2,0x20
 22c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 230:	872a                	mv	a4,a0
      *dst++ = *src++;
 232:	0585                	addi	a1,a1,1
 234:	0705                	addi	a4,a4,1
 236:	fff5c683          	lbu	a3,-1(a1)
 23a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 23e:	fef71ae3          	bne	a4,a5,232 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 242:	6422                	ld	s0,8(sp)
 244:	0141                	addi	sp,sp,16
 246:	8082                	ret
    dst += n;
 248:	00c50733          	add	a4,a0,a2
    src += n;
 24c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 24e:	fec05ae3          	blez	a2,242 <memmove+0x28>
 252:	fff6079b          	addiw	a5,a2,-1
 256:	1782                	slli	a5,a5,0x20
 258:	9381                	srli	a5,a5,0x20
 25a:	fff7c793          	not	a5,a5
 25e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 260:	15fd                	addi	a1,a1,-1
 262:	177d                	addi	a4,a4,-1
 264:	0005c683          	lbu	a3,0(a1)
 268:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 26c:	fee79ae3          	bne	a5,a4,260 <memmove+0x46>
 270:	bfc9                	j	242 <memmove+0x28>

0000000000000272 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 272:	1141                	addi	sp,sp,-16
 274:	e422                	sd	s0,8(sp)
 276:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 278:	ca05                	beqz	a2,2a8 <memcmp+0x36>
 27a:	fff6069b          	addiw	a3,a2,-1
 27e:	1682                	slli	a3,a3,0x20
 280:	9281                	srli	a3,a3,0x20
 282:	0685                	addi	a3,a3,1
 284:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 286:	00054783          	lbu	a5,0(a0)
 28a:	0005c703          	lbu	a4,0(a1)
 28e:	00e79863          	bne	a5,a4,29e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 292:	0505                	addi	a0,a0,1
    p2++;
 294:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 296:	fed518e3          	bne	a0,a3,286 <memcmp+0x14>
  }
  return 0;
 29a:	4501                	li	a0,0
 29c:	a019                	j	2a2 <memcmp+0x30>
      return *p1 - *p2;
 29e:	40e7853b          	subw	a0,a5,a4
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  return 0;
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <memcmp+0x30>

00000000000002ac <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e406                	sd	ra,8(sp)
 2b0:	e022                	sd	s0,0(sp)
 2b2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b4:	00000097          	auipc	ra,0x0
 2b8:	f66080e7          	jalr	-154(ra) # 21a <memmove>
}
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2c4:	4885                	li	a7,1
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 2cc:	4889                	li	a7,2
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2d4:	488d                	li	a7,3
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2dc:	4891                	li	a7,4
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <read>:
.global read
read:
 li a7, SYS_read
 2e4:	4895                	li	a7,5
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <write>:
.global write
write:
 li a7, SYS_write
 2ec:	48c1                	li	a7,16
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <close>:
.global close
close:
 li a7, SYS_close
 2f4:	48d5                	li	a7,21
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 2fc:	4899                	li	a7,6
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <exec>:
.global exec
exec:
 li a7, SYS_exec
 304:	489d                	li	a7,7
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <open>:
.global open
open:
 li a7, SYS_open
 30c:	48bd                	li	a7,15
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 314:	48c5                	li	a7,17
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 31c:	48c9                	li	a7,18
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 324:	48a1                	li	a7,8
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <link>:
.global link
link:
 li a7, SYS_link
 32c:	48cd                	li	a7,19
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 334:	48d1                	li	a7,20
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33c:	48a5                	li	a7,9
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <dup>:
.global dup
dup:
 li a7, SYS_dup
 344:	48a9                	li	a7,10
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34c:	48ad                	li	a7,11
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 354:	48b1                	li	a7,12
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35c:	48b5                	li	a7,13
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 364:	48b9                	li	a7,14
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 36c:	1101                	addi	sp,sp,-32
 36e:	ec06                	sd	ra,24(sp)
 370:	e822                	sd	s0,16(sp)
 372:	1000                	addi	s0,sp,32
 374:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 378:	4605                	li	a2,1
 37a:	fef40593          	addi	a1,s0,-17
 37e:	00000097          	auipc	ra,0x0
 382:	f6e080e7          	jalr	-146(ra) # 2ec <write>
}
 386:	60e2                	ld	ra,24(sp)
 388:	6442                	ld	s0,16(sp)
 38a:	6105                	addi	sp,sp,32
 38c:	8082                	ret

000000000000038e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 38e:	7139                	addi	sp,sp,-64
 390:	fc06                	sd	ra,56(sp)
 392:	f822                	sd	s0,48(sp)
 394:	f426                	sd	s1,40(sp)
 396:	0080                	addi	s0,sp,64
 398:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39a:	c299                	beqz	a3,3a0 <printint+0x12>
 39c:	0805cb63          	bltz	a1,432 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3a0:	2581                	sext.w	a1,a1
  neg = 0;
 3a2:	4881                	li	a7,0
 3a4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3a8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3aa:	2601                	sext.w	a2,a2
 3ac:	00000517          	auipc	a0,0x0
 3b0:	4bc50513          	addi	a0,a0,1212 # 868 <digits>
 3b4:	883a                	mv	a6,a4
 3b6:	2705                	addiw	a4,a4,1
 3b8:	02c5f7bb          	remuw	a5,a1,a2
 3bc:	1782                	slli	a5,a5,0x20
 3be:	9381                	srli	a5,a5,0x20
 3c0:	97aa                	add	a5,a5,a0
 3c2:	0007c783          	lbu	a5,0(a5)
 3c6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3ca:	0005879b          	sext.w	a5,a1
 3ce:	02c5d5bb          	divuw	a1,a1,a2
 3d2:	0685                	addi	a3,a3,1
 3d4:	fec7f0e3          	bgeu	a5,a2,3b4 <printint+0x26>
  if(neg)
 3d8:	00088c63          	beqz	a7,3f0 <printint+0x62>
    buf[i++] = '-';
 3dc:	fd070793          	addi	a5,a4,-48
 3e0:	00878733          	add	a4,a5,s0
 3e4:	02d00793          	li	a5,45
 3e8:	fef70823          	sb	a5,-16(a4)
 3ec:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3f0:	02e05c63          	blez	a4,428 <printint+0x9a>
 3f4:	f04a                	sd	s2,32(sp)
 3f6:	ec4e                	sd	s3,24(sp)
 3f8:	fc040793          	addi	a5,s0,-64
 3fc:	00e78933          	add	s2,a5,a4
 400:	fff78993          	addi	s3,a5,-1
 404:	99ba                	add	s3,s3,a4
 406:	377d                	addiw	a4,a4,-1
 408:	1702                	slli	a4,a4,0x20
 40a:	9301                	srli	a4,a4,0x20
 40c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 410:	fff94583          	lbu	a1,-1(s2)
 414:	8526                	mv	a0,s1
 416:	00000097          	auipc	ra,0x0
 41a:	f56080e7          	jalr	-170(ra) # 36c <putc>
  while(--i >= 0)
 41e:	197d                	addi	s2,s2,-1
 420:	ff3918e3          	bne	s2,s3,410 <printint+0x82>
 424:	7902                	ld	s2,32(sp)
 426:	69e2                	ld	s3,24(sp)
}
 428:	70e2                	ld	ra,56(sp)
 42a:	7442                	ld	s0,48(sp)
 42c:	74a2                	ld	s1,40(sp)
 42e:	6121                	addi	sp,sp,64
 430:	8082                	ret
    x = -xx;
 432:	40b005bb          	negw	a1,a1
    neg = 1;
 436:	4885                	li	a7,1
    x = -xx;
 438:	b7b5                	j	3a4 <printint+0x16>

000000000000043a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 43a:	715d                	addi	sp,sp,-80
 43c:	e486                	sd	ra,72(sp)
 43e:	e0a2                	sd	s0,64(sp)
 440:	f84a                	sd	s2,48(sp)
 442:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 444:	0005c903          	lbu	s2,0(a1)
 448:	1a090a63          	beqz	s2,5fc <vprintf+0x1c2>
 44c:	fc26                	sd	s1,56(sp)
 44e:	f44e                	sd	s3,40(sp)
 450:	f052                	sd	s4,32(sp)
 452:	ec56                	sd	s5,24(sp)
 454:	e85a                	sd	s6,16(sp)
 456:	e45e                	sd	s7,8(sp)
 458:	8aaa                	mv	s5,a0
 45a:	8bb2                	mv	s7,a2
 45c:	00158493          	addi	s1,a1,1
  state = 0;
 460:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 462:	02500a13          	li	s4,37
 466:	4b55                	li	s6,21
 468:	a839                	j	486 <vprintf+0x4c>
        putc(fd, c);
 46a:	85ca                	mv	a1,s2
 46c:	8556                	mv	a0,s5
 46e:	00000097          	auipc	ra,0x0
 472:	efe080e7          	jalr	-258(ra) # 36c <putc>
 476:	a019                	j	47c <vprintf+0x42>
    } else if(state == '%'){
 478:	01498d63          	beq	s3,s4,492 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 47c:	0485                	addi	s1,s1,1
 47e:	fff4c903          	lbu	s2,-1(s1)
 482:	16090763          	beqz	s2,5f0 <vprintf+0x1b6>
    if(state == 0){
 486:	fe0999e3          	bnez	s3,478 <vprintf+0x3e>
      if(c == '%'){
 48a:	ff4910e3          	bne	s2,s4,46a <vprintf+0x30>
        state = '%';
 48e:	89d2                	mv	s3,s4
 490:	b7f5                	j	47c <vprintf+0x42>
      if(c == 'd'){
 492:	13490463          	beq	s2,s4,5ba <vprintf+0x180>
 496:	f9d9079b          	addiw	a5,s2,-99
 49a:	0ff7f793          	zext.b	a5,a5
 49e:	12fb6763          	bltu	s6,a5,5cc <vprintf+0x192>
 4a2:	f9d9079b          	addiw	a5,s2,-99
 4a6:	0ff7f713          	zext.b	a4,a5
 4aa:	12eb6163          	bltu	s6,a4,5cc <vprintf+0x192>
 4ae:	00271793          	slli	a5,a4,0x2
 4b2:	00000717          	auipc	a4,0x0
 4b6:	35e70713          	addi	a4,a4,862 # 810 <malloc+0x124>
 4ba:	97ba                	add	a5,a5,a4
 4bc:	439c                	lw	a5,0(a5)
 4be:	97ba                	add	a5,a5,a4
 4c0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4c2:	008b8913          	addi	s2,s7,8
 4c6:	4685                	li	a3,1
 4c8:	4629                	li	a2,10
 4ca:	000ba583          	lw	a1,0(s7)
 4ce:	8556                	mv	a0,s5
 4d0:	00000097          	auipc	ra,0x0
 4d4:	ebe080e7          	jalr	-322(ra) # 38e <printint>
 4d8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4da:	4981                	li	s3,0
 4dc:	b745                	j	47c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4de:	008b8913          	addi	s2,s7,8
 4e2:	4681                	li	a3,0
 4e4:	4629                	li	a2,10
 4e6:	000ba583          	lw	a1,0(s7)
 4ea:	8556                	mv	a0,s5
 4ec:	00000097          	auipc	ra,0x0
 4f0:	ea2080e7          	jalr	-350(ra) # 38e <printint>
 4f4:	8bca                	mv	s7,s2
      state = 0;
 4f6:	4981                	li	s3,0
 4f8:	b751                	j	47c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 4fa:	008b8913          	addi	s2,s7,8
 4fe:	4681                	li	a3,0
 500:	4641                	li	a2,16
 502:	000ba583          	lw	a1,0(s7)
 506:	8556                	mv	a0,s5
 508:	00000097          	auipc	ra,0x0
 50c:	e86080e7          	jalr	-378(ra) # 38e <printint>
 510:	8bca                	mv	s7,s2
      state = 0;
 512:	4981                	li	s3,0
 514:	b7a5                	j	47c <vprintf+0x42>
 516:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 518:	008b8c13          	addi	s8,s7,8
 51c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 520:	03000593          	li	a1,48
 524:	8556                	mv	a0,s5
 526:	00000097          	auipc	ra,0x0
 52a:	e46080e7          	jalr	-442(ra) # 36c <putc>
  putc(fd, 'x');
 52e:	07800593          	li	a1,120
 532:	8556                	mv	a0,s5
 534:	00000097          	auipc	ra,0x0
 538:	e38080e7          	jalr	-456(ra) # 36c <putc>
 53c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 53e:	00000b97          	auipc	s7,0x0
 542:	32ab8b93          	addi	s7,s7,810 # 868 <digits>
 546:	03c9d793          	srli	a5,s3,0x3c
 54a:	97de                	add	a5,a5,s7
 54c:	0007c583          	lbu	a1,0(a5)
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	e1a080e7          	jalr	-486(ra) # 36c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 55a:	0992                	slli	s3,s3,0x4
 55c:	397d                	addiw	s2,s2,-1
 55e:	fe0914e3          	bnez	s2,546 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 562:	8be2                	mv	s7,s8
      state = 0;
 564:	4981                	li	s3,0
 566:	6c02                	ld	s8,0(sp)
 568:	bf11                	j	47c <vprintf+0x42>
        s = va_arg(ap, char*);
 56a:	008b8993          	addi	s3,s7,8
 56e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 572:	02090163          	beqz	s2,594 <vprintf+0x15a>
        while(*s != 0){
 576:	00094583          	lbu	a1,0(s2)
 57a:	c9a5                	beqz	a1,5ea <vprintf+0x1b0>
          putc(fd, *s);
 57c:	8556                	mv	a0,s5
 57e:	00000097          	auipc	ra,0x0
 582:	dee080e7          	jalr	-530(ra) # 36c <putc>
          s++;
 586:	0905                	addi	s2,s2,1
        while(*s != 0){
 588:	00094583          	lbu	a1,0(s2)
 58c:	f9e5                	bnez	a1,57c <vprintf+0x142>
        s = va_arg(ap, char*);
 58e:	8bce                	mv	s7,s3
      state = 0;
 590:	4981                	li	s3,0
 592:	b5ed                	j	47c <vprintf+0x42>
          s = "(null)";
 594:	00000917          	auipc	s2,0x0
 598:	27490913          	addi	s2,s2,628 # 808 <malloc+0x11c>
        while(*s != 0){
 59c:	02800593          	li	a1,40
 5a0:	bff1                	j	57c <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5a2:	008b8913          	addi	s2,s7,8
 5a6:	000bc583          	lbu	a1,0(s7)
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	dc0080e7          	jalr	-576(ra) # 36c <putc>
 5b4:	8bca                	mv	s7,s2
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b5d1                	j	47c <vprintf+0x42>
        putc(fd, c);
 5ba:	02500593          	li	a1,37
 5be:	8556                	mv	a0,s5
 5c0:	00000097          	auipc	ra,0x0
 5c4:	dac080e7          	jalr	-596(ra) # 36c <putc>
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	bd4d                	j	47c <vprintf+0x42>
        putc(fd, '%');
 5cc:	02500593          	li	a1,37
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	d9a080e7          	jalr	-614(ra) # 36c <putc>
        putc(fd, c);
 5da:	85ca                	mv	a1,s2
 5dc:	8556                	mv	a0,s5
 5de:	00000097          	auipc	ra,0x0
 5e2:	d8e080e7          	jalr	-626(ra) # 36c <putc>
      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	bd51                	j	47c <vprintf+0x42>
        s = va_arg(ap, char*);
 5ea:	8bce                	mv	s7,s3
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b579                	j	47c <vprintf+0x42>
 5f0:	74e2                	ld	s1,56(sp)
 5f2:	79a2                	ld	s3,40(sp)
 5f4:	7a02                	ld	s4,32(sp)
 5f6:	6ae2                	ld	s5,24(sp)
 5f8:	6b42                	ld	s6,16(sp)
 5fa:	6ba2                	ld	s7,8(sp)
    }
  }
}
 5fc:	60a6                	ld	ra,72(sp)
 5fe:	6406                	ld	s0,64(sp)
 600:	7942                	ld	s2,48(sp)
 602:	6161                	addi	sp,sp,80
 604:	8082                	ret

0000000000000606 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 606:	715d                	addi	sp,sp,-80
 608:	ec06                	sd	ra,24(sp)
 60a:	e822                	sd	s0,16(sp)
 60c:	1000                	addi	s0,sp,32
 60e:	e010                	sd	a2,0(s0)
 610:	e414                	sd	a3,8(s0)
 612:	e818                	sd	a4,16(s0)
 614:	ec1c                	sd	a5,24(s0)
 616:	03043023          	sd	a6,32(s0)
 61a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 61e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 622:	8622                	mv	a2,s0
 624:	00000097          	auipc	ra,0x0
 628:	e16080e7          	jalr	-490(ra) # 43a <vprintf>
}
 62c:	60e2                	ld	ra,24(sp)
 62e:	6442                	ld	s0,16(sp)
 630:	6161                	addi	sp,sp,80
 632:	8082                	ret

0000000000000634 <printf>:

void
printf(const char *fmt, ...)
{
 634:	711d                	addi	sp,sp,-96
 636:	ec06                	sd	ra,24(sp)
 638:	e822                	sd	s0,16(sp)
 63a:	1000                	addi	s0,sp,32
 63c:	e40c                	sd	a1,8(s0)
 63e:	e810                	sd	a2,16(s0)
 640:	ec14                	sd	a3,24(s0)
 642:	f018                	sd	a4,32(s0)
 644:	f41c                	sd	a5,40(s0)
 646:	03043823          	sd	a6,48(s0)
 64a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 64e:	00840613          	addi	a2,s0,8
 652:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 656:	85aa                	mv	a1,a0
 658:	4505                	li	a0,1
 65a:	00000097          	auipc	ra,0x0
 65e:	de0080e7          	jalr	-544(ra) # 43a <vprintf>
}
 662:	60e2                	ld	ra,24(sp)
 664:	6442                	ld	s0,16(sp)
 666:	6125                	addi	sp,sp,96
 668:	8082                	ret

000000000000066a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 66a:	1141                	addi	sp,sp,-16
 66c:	e422                	sd	s0,8(sp)
 66e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 670:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 674:	00000797          	auipc	a5,0x0
 678:	5c47b783          	ld	a5,1476(a5) # c38 <freep>
 67c:	a02d                	j	6a6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 67e:	4618                	lw	a4,8(a2)
 680:	9f2d                	addw	a4,a4,a1
 682:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	6398                	ld	a4,0(a5)
 688:	6310                	ld	a2,0(a4)
 68a:	a83d                	j	6c8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 68c:	ff852703          	lw	a4,-8(a0)
 690:	9f31                	addw	a4,a4,a2
 692:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 694:	ff053683          	ld	a3,-16(a0)
 698:	a091                	j	6dc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69a:	6398                	ld	a4,0(a5)
 69c:	00e7e463          	bltu	a5,a4,6a4 <free+0x3a>
 6a0:	00e6ea63          	bltu	a3,a4,6b4 <free+0x4a>
{
 6a4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a6:	fed7fae3          	bgeu	a5,a3,69a <free+0x30>
 6aa:	6398                	ld	a4,0(a5)
 6ac:	00e6e463          	bltu	a3,a4,6b4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	fee7eae3          	bltu	a5,a4,6a4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 6b4:	ff852583          	lw	a1,-8(a0)
 6b8:	6390                	ld	a2,0(a5)
 6ba:	02059813          	slli	a6,a1,0x20
 6be:	01c85713          	srli	a4,a6,0x1c
 6c2:	9736                	add	a4,a4,a3
 6c4:	fae60de3          	beq	a2,a4,67e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 6c8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6cc:	4790                	lw	a2,8(a5)
 6ce:	02061593          	slli	a1,a2,0x20
 6d2:	01c5d713          	srli	a4,a1,0x1c
 6d6:	973e                	add	a4,a4,a5
 6d8:	fae68ae3          	beq	a3,a4,68c <free+0x22>
    p->s.ptr = bp->s.ptr;
 6dc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6de:	00000717          	auipc	a4,0x0
 6e2:	54f73d23          	sd	a5,1370(a4) # c38 <freep>
}
 6e6:	6422                	ld	s0,8(sp)
 6e8:	0141                	addi	sp,sp,16
 6ea:	8082                	ret

00000000000006ec <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6ec:	7139                	addi	sp,sp,-64
 6ee:	fc06                	sd	ra,56(sp)
 6f0:	f822                	sd	s0,48(sp)
 6f2:	f426                	sd	s1,40(sp)
 6f4:	ec4e                	sd	s3,24(sp)
 6f6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f8:	02051493          	slli	s1,a0,0x20
 6fc:	9081                	srli	s1,s1,0x20
 6fe:	04bd                	addi	s1,s1,15
 700:	8091                	srli	s1,s1,0x4
 702:	0014899b          	addiw	s3,s1,1
 706:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 708:	00000517          	auipc	a0,0x0
 70c:	53053503          	ld	a0,1328(a0) # c38 <freep>
 710:	c915                	beqz	a0,744 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 712:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 714:	4798                	lw	a4,8(a5)
 716:	08977e63          	bgeu	a4,s1,7b2 <malloc+0xc6>
 71a:	f04a                	sd	s2,32(sp)
 71c:	e852                	sd	s4,16(sp)
 71e:	e456                	sd	s5,8(sp)
 720:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 722:	8a4e                	mv	s4,s3
 724:	0009871b          	sext.w	a4,s3
 728:	6685                	lui	a3,0x1
 72a:	00d77363          	bgeu	a4,a3,730 <malloc+0x44>
 72e:	6a05                	lui	s4,0x1
 730:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 734:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 738:	00000917          	auipc	s2,0x0
 73c:	50090913          	addi	s2,s2,1280 # c38 <freep>
  if(p == (char*)-1)
 740:	5afd                	li	s5,-1
 742:	a091                	j	786 <malloc+0x9a>
 744:	f04a                	sd	s2,32(sp)
 746:	e852                	sd	s4,16(sp)
 748:	e456                	sd	s5,8(sp)
 74a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 74c:	00000797          	auipc	a5,0x0
 750:	4f478793          	addi	a5,a5,1268 # c40 <base>
 754:	00000717          	auipc	a4,0x0
 758:	4ef73223          	sd	a5,1252(a4) # c38 <freep>
 75c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 75e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 762:	b7c1                	j	722 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 764:	6398                	ld	a4,0(a5)
 766:	e118                	sd	a4,0(a0)
 768:	a08d                	j	7ca <malloc+0xde>
  hp->s.size = nu;
 76a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 76e:	0541                	addi	a0,a0,16
 770:	00000097          	auipc	ra,0x0
 774:	efa080e7          	jalr	-262(ra) # 66a <free>
  return freep;
 778:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 77c:	c13d                	beqz	a0,7e2 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 780:	4798                	lw	a4,8(a5)
 782:	02977463          	bgeu	a4,s1,7aa <malloc+0xbe>
    if(p == freep)
 786:	00093703          	ld	a4,0(s2)
 78a:	853e                	mv	a0,a5
 78c:	fef719e3          	bne	a4,a5,77e <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 790:	8552                	mv	a0,s4
 792:	00000097          	auipc	ra,0x0
 796:	bc2080e7          	jalr	-1086(ra) # 354 <sbrk>
  if(p == (char*)-1)
 79a:	fd5518e3          	bne	a0,s5,76a <malloc+0x7e>
        return 0;
 79e:	4501                	li	a0,0
 7a0:	7902                	ld	s2,32(sp)
 7a2:	6a42                	ld	s4,16(sp)
 7a4:	6aa2                	ld	s5,8(sp)
 7a6:	6b02                	ld	s6,0(sp)
 7a8:	a03d                	j	7d6 <malloc+0xea>
 7aa:	7902                	ld	s2,32(sp)
 7ac:	6a42                	ld	s4,16(sp)
 7ae:	6aa2                	ld	s5,8(sp)
 7b0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7b2:	fae489e3          	beq	s1,a4,764 <malloc+0x78>
        p->s.size -= nunits;
 7b6:	4137073b          	subw	a4,a4,s3
 7ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7bc:	02071693          	slli	a3,a4,0x20
 7c0:	01c6d713          	srli	a4,a3,0x1c
 7c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7ca:	00000717          	auipc	a4,0x0
 7ce:	46a73723          	sd	a0,1134(a4) # c38 <freep>
      return (void*)(p + 1);
 7d2:	01078513          	addi	a0,a5,16
  }
}
 7d6:	70e2                	ld	ra,56(sp)
 7d8:	7442                	ld	s0,48(sp)
 7da:	74a2                	ld	s1,40(sp)
 7dc:	69e2                	ld	s3,24(sp)
 7de:	6121                	addi	sp,sp,64
 7e0:	8082                	ret
 7e2:	7902                	ld	s2,32(sp)
 7e4:	6a42                	ld	s4,16(sp)
 7e6:	6aa2                	ld	s5,8(sp)
 7e8:	6b02                	ld	s6,0(sp)
 7ea:	b7f5                	j	7d6 <malloc+0xea>
