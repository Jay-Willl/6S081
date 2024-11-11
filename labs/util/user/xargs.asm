
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <execute>:
#include "kernel/param.h"
#include "user/user.h"


void 
execute(char *command, char *params[]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	1800                	addi	s0,sp,48
   c:	84aa                	mv	s1,a0
   e:	892e                	mv	s2,a1
    int pid = fork();
  10:	00000097          	auipc	ra,0x0
  14:	3ee080e7          	jalr	1006(ra) # 3fe <fork>
  18:	fca42e23          	sw	a0,-36(s0)
    if (pid == -1) {
  1c:	57fd                	li	a5,-1
  1e:	00f50f63          	beq	a0,a5,3c <execute+0x3c>
        printf("fork error\n");
        exit(1);
    }

    if (pid == 0) { // child process
  22:	c915                	beqz	a0,56 <execute+0x56>
        exec(command, params);
        exit(0);
    } else { // parent process
        wait(&pid);
  24:	fdc40513          	addi	a0,s0,-36
  28:	00000097          	auipc	ra,0x0
  2c:	3e6080e7          	jalr	998(ra) # 40e <wait>
    }
}
  30:	70a2                	ld	ra,40(sp)
  32:	7402                	ld	s0,32(sp)
  34:	64e2                	ld	s1,24(sp)
  36:	6942                	ld	s2,16(sp)
  38:	6145                	addi	sp,sp,48
  3a:	8082                	ret
        printf("fork error\n");
  3c:	00001517          	auipc	a0,0x1
  40:	8ec50513          	addi	a0,a0,-1812 # 928 <malloc+0x102>
  44:	00000097          	auipc	ra,0x0
  48:	72a080e7          	jalr	1834(ra) # 76e <printf>
        exit(1);
  4c:	4505                	li	a0,1
  4e:	00000097          	auipc	ra,0x0
  52:	3b8080e7          	jalr	952(ra) # 406 <exit>
        exec(command, params);
  56:	85ca                	mv	a1,s2
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	3e4080e7          	jalr	996(ra) # 43e <exec>
        exit(0);
  62:	4501                	li	a0,0
  64:	00000097          	auipc	ra,0x0
  68:	3a2080e7          	jalr	930(ra) # 406 <exit>

000000000000006c <xargs>:

void 
xargs(char *command, char *params[]) {
  6c:	cc010113          	addi	sp,sp,-832
  70:	32113c23          	sd	ra,824(sp)
  74:	32813823          	sd	s0,816(sp)
  78:	32913423          	sd	s1,808(sp)
  7c:	33213023          	sd	s2,800(sp)
  80:	31313c23          	sd	s3,792(sp)
  84:	31413823          	sd	s4,784(sp)
  88:	31513423          	sd	s5,776(sp)
  8c:	0680                	addi	s0,sp,832
  8e:	8a2a                	mv	s4,a0
    int n, i;
    char buf[512];
    char *args[MAXARG];

    for (i = 0; params[i] != 0 && i < MAXARG - 1; i++) {
  90:	6194                	ld	a3,0(a1)
  92:	c6a5                	beqz	a3,fa <xargs+0x8e>
  94:	cc040613          	addi	a2,s0,-832
  98:	00858713          	addi	a4,a1,8
  9c:	4781                	li	a5,0
  9e:	45fd                	li	a1,31
        args[i] = params[i];
  a0:	e214                	sd	a3,0(a2)
    for (i = 0; params[i] != 0 && i < MAXARG - 1; i++) {
  a2:	2785                	addiw	a5,a5,1
  a4:	6314                	ld	a3,0(a4)
  a6:	c689                	beqz	a3,b0 <xargs+0x44>
  a8:	0621                	addi	a2,a2,8
  aa:	0721                	addi	a4,a4,8
  ac:	feb79ae3          	bne	a5,a1,a0 <xargs+0x34>
            if (*p == '\n') {
                *p = '\0';
                p += 1;
            }

            args[i] = temp;
  b0:	00379a93          	slli	s5,a5,0x3
  b4:	fc0a8713          	addi	a4,s5,-64
  b8:	00870ab3          	add	s5,a4,s0
            args[i + 1] = '\0';
  bc:	0017899b          	addiw	s3,a5,1
  c0:	098e                	slli	s3,s3,0x3
  c2:	fc098793          	addi	a5,s3,-64
  c6:	008789b3          	add	s3,a5,s0
    while ((n = read(0, buf, sizeof(buf))) > 0) {
  ca:	20000613          	li	a2,512
  ce:	dc040593          	addi	a1,s0,-576
  d2:	4501                	li	a0,0
  d4:	00000097          	auipc	ra,0x0
  d8:	34a080e7          	jalr	842(ra) # 41e <read>
  dc:	04a05e63          	blez	a0,138 <xargs+0xcc>
        buf[n] = '\0';
  e0:	fc050793          	addi	a5,a0,-64
  e4:	00878533          	add	a0,a5,s0
  e8:	e0050023          	sb	zero,-512(a0)
        while (*p) {
  ec:	dc044783          	lbu	a5,-576(s0)
        char *p = buf;
  f0:	dc040713          	addi	a4,s0,-576
            while (*p && *p != '\n') {
  f4:	4929                	li	s2,10
        while (*p) {
  f6:	e795                	bnez	a5,122 <xargs+0xb6>
  f8:	bfc9                	j	ca <xargs+0x5e>
    for (i = 0; params[i] != 0 && i < MAXARG - 1; i++) {
  fa:	4781                	li	a5,0
  fc:	bf55                	j	b0 <xargs+0x44>
                *p = '\0';
  fe:	00048023          	sb	zero,0(s1)
                p += 1;
 102:	0485                	addi	s1,s1,1
            args[i] = temp;
 104:	d0eab023          	sd	a4,-768(s5)
            args[i + 1] = '\0';
 108:	d009b023          	sd	zero,-768(s3)
            execute(command, args);
 10c:	cc040593          	addi	a1,s0,-832
 110:	8552                	mv	a0,s4
 112:	00000097          	auipc	ra,0x0
 116:	eee080e7          	jalr	-274(ra) # 0 <execute>
        while (*p) {
 11a:	0004c783          	lbu	a5,0(s1)
 11e:	d7d5                	beqz	a5,ca <xargs+0x5e>
 120:	8726                	mv	a4,s1
            while (*p && *p != '\n') {
 122:	00074783          	lbu	a5,0(a4)
 126:	84ba                	mv	s1,a4
 128:	dff1                	beqz	a5,104 <xargs+0x98>
 12a:	fd278ae3          	beq	a5,s2,fe <xargs+0x92>
                p += 1;
 12e:	0485                	addi	s1,s1,1
            while (*p && *p != '\n') {
 130:	0004c783          	lbu	a5,0(s1)
 134:	fbfd                	bnez	a5,12a <xargs+0xbe>
 136:	b7f9                	j	104 <xargs+0x98>
        }
    }
}
 138:	33813083          	ld	ra,824(sp)
 13c:	33013403          	ld	s0,816(sp)
 140:	32813483          	ld	s1,808(sp)
 144:	32013903          	ld	s2,800(sp)
 148:	31813983          	ld	s3,792(sp)
 14c:	31013a03          	ld	s4,784(sp)
 150:	30813a83          	ld	s5,776(sp)
 154:	34010113          	addi	sp,sp,832
 158:	8082                	ret

000000000000015a <main>:

int
main(int argc, char *argv[]) {
 15a:	1141                	addi	sp,sp,-16
 15c:	e406                	sd	ra,8(sp)
 15e:	e022                	sd	s0,0(sp)
 160:	0800                	addi	s0,sp,16
    if (argc < 2) {
 162:	4705                	li	a4,1
 164:	00a75e63          	bge	a4,a0,180 <main+0x26>
 168:	87ae                	mv	a5,a1
        printf("usage: xargs command\n");
        exit(0);
    }

    xargs(argv[1], &argv[1]);
 16a:	05a1                	addi	a1,a1,8
 16c:	6788                	ld	a0,8(a5)
 16e:	00000097          	auipc	ra,0x0
 172:	efe080e7          	jalr	-258(ra) # 6c <xargs>
    exit(0);
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	28e080e7          	jalr	654(ra) # 406 <exit>
        printf("usage: xargs command\n");
 180:	00000517          	auipc	a0,0x0
 184:	7b850513          	addi	a0,a0,1976 # 938 <malloc+0x112>
 188:	00000097          	auipc	ra,0x0
 18c:	5e6080e7          	jalr	1510(ra) # 76e <printf>
        exit(0);
 190:	4501                	li	a0,0
 192:	00000097          	auipc	ra,0x0
 196:	274080e7          	jalr	628(ra) # 406 <exit>

000000000000019a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e422                	sd	s0,8(sp)
 19e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a0:	87aa                	mv	a5,a0
 1a2:	0585                	addi	a1,a1,1
 1a4:	0785                	addi	a5,a5,1
 1a6:	fff5c703          	lbu	a4,-1(a1)
 1aa:	fee78fa3          	sb	a4,-1(a5)
 1ae:	fb75                	bnez	a4,1a2 <strcpy+0x8>
    ;
  return os;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cb91                	beqz	a5,1d4 <strcmp+0x1e>
 1c2:	0005c703          	lbu	a4,0(a1)
 1c6:	00f71763          	bne	a4,a5,1d4 <strcmp+0x1e>
    p++, q++;
 1ca:	0505                	addi	a0,a0,1
 1cc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	fbe5                	bnez	a5,1c2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d4:	0005c503          	lbu	a0,0(a1)
}
 1d8:	40a7853b          	subw	a0,a5,a0
 1dc:	6422                	ld	s0,8(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret

00000000000001e2 <strlen>:

uint
strlen(const char *s)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e422                	sd	s0,8(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cf91                	beqz	a5,208 <strlen+0x26>
 1ee:	0505                	addi	a0,a0,1
 1f0:	87aa                	mv	a5,a0
 1f2:	86be                	mv	a3,a5
 1f4:	0785                	addi	a5,a5,1
 1f6:	fff7c703          	lbu	a4,-1(a5)
 1fa:	ff65                	bnez	a4,1f2 <strlen+0x10>
 1fc:	40a6853b          	subw	a0,a3,a0
 200:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  for(n = 0; s[n]; n++)
 208:	4501                	li	a0,0
 20a:	bfe5                	j	202 <strlen+0x20>

000000000000020c <memset>:

void*
memset(void *dst, int c, uint n)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 212:	ca19                	beqz	a2,228 <memset+0x1c>
 214:	87aa                	mv	a5,a0
 216:	1602                	slli	a2,a2,0x20
 218:	9201                	srli	a2,a2,0x20
 21a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 21e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 222:	0785                	addi	a5,a5,1
 224:	fee79de3          	bne	a5,a4,21e <memset+0x12>
  }
  return dst;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret

000000000000022e <strchr>:

char*
strchr(const char *s, char c)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  for(; *s; s++)
 234:	00054783          	lbu	a5,0(a0)
 238:	cb99                	beqz	a5,24e <strchr+0x20>
    if(*s == c)
 23a:	00f58763          	beq	a1,a5,248 <strchr+0x1a>
  for(; *s; s++)
 23e:	0505                	addi	a0,a0,1
 240:	00054783          	lbu	a5,0(a0)
 244:	fbfd                	bnez	a5,23a <strchr+0xc>
      return (char*)s;
  return 0;
 246:	4501                	li	a0,0
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
  return 0;
 24e:	4501                	li	a0,0
 250:	bfe5                	j	248 <strchr+0x1a>

0000000000000252 <gets>:

char*
gets(char *buf, int max)
{
 252:	711d                	addi	sp,sp,-96
 254:	ec86                	sd	ra,88(sp)
 256:	e8a2                	sd	s0,80(sp)
 258:	e4a6                	sd	s1,72(sp)
 25a:	e0ca                	sd	s2,64(sp)
 25c:	fc4e                	sd	s3,56(sp)
 25e:	f852                	sd	s4,48(sp)
 260:	f456                	sd	s5,40(sp)
 262:	f05a                	sd	s6,32(sp)
 264:	ec5e                	sd	s7,24(sp)
 266:	1080                	addi	s0,sp,96
 268:	8baa                	mv	s7,a0
 26a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26c:	892a                	mv	s2,a0
 26e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 270:	4aa9                	li	s5,10
 272:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 274:	89a6                	mv	s3,s1
 276:	2485                	addiw	s1,s1,1
 278:	0344d863          	bge	s1,s4,2a8 <gets+0x56>
    cc = read(0, &c, 1);
 27c:	4605                	li	a2,1
 27e:	faf40593          	addi	a1,s0,-81
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	19a080e7          	jalr	410(ra) # 41e <read>
    if(cc < 1)
 28c:	00a05e63          	blez	a0,2a8 <gets+0x56>
    buf[i++] = c;
 290:	faf44783          	lbu	a5,-81(s0)
 294:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 298:	01578763          	beq	a5,s5,2a6 <gets+0x54>
 29c:	0905                	addi	s2,s2,1
 29e:	fd679be3          	bne	a5,s6,274 <gets+0x22>
    buf[i++] = c;
 2a2:	89a6                	mv	s3,s1
 2a4:	a011                	j	2a8 <gets+0x56>
 2a6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2a8:	99de                	add	s3,s3,s7
 2aa:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ae:	855e                	mv	a0,s7
 2b0:	60e6                	ld	ra,88(sp)
 2b2:	6446                	ld	s0,80(sp)
 2b4:	64a6                	ld	s1,72(sp)
 2b6:	6906                	ld	s2,64(sp)
 2b8:	79e2                	ld	s3,56(sp)
 2ba:	7a42                	ld	s4,48(sp)
 2bc:	7aa2                	ld	s5,40(sp)
 2be:	7b02                	ld	s6,32(sp)
 2c0:	6be2                	ld	s7,24(sp)
 2c2:	6125                	addi	sp,sp,96
 2c4:	8082                	ret

00000000000002c6 <stat>:

int
stat(const char *n, struct stat *st)
{
 2c6:	1101                	addi	sp,sp,-32
 2c8:	ec06                	sd	ra,24(sp)
 2ca:	e822                	sd	s0,16(sp)
 2cc:	e04a                	sd	s2,0(sp)
 2ce:	1000                	addi	s0,sp,32
 2d0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d2:	4581                	li	a1,0
 2d4:	00000097          	auipc	ra,0x0
 2d8:	172080e7          	jalr	370(ra) # 446 <open>
  if(fd < 0)
 2dc:	02054663          	bltz	a0,308 <stat+0x42>
 2e0:	e426                	sd	s1,8(sp)
 2e2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2e4:	85ca                	mv	a1,s2
 2e6:	00000097          	auipc	ra,0x0
 2ea:	178080e7          	jalr	376(ra) # 45e <fstat>
 2ee:	892a                	mv	s2,a0
  close(fd);
 2f0:	8526                	mv	a0,s1
 2f2:	00000097          	auipc	ra,0x0
 2f6:	13c080e7          	jalr	316(ra) # 42e <close>
  return r;
 2fa:	64a2                	ld	s1,8(sp)
}
 2fc:	854a                	mv	a0,s2
 2fe:	60e2                	ld	ra,24(sp)
 300:	6442                	ld	s0,16(sp)
 302:	6902                	ld	s2,0(sp)
 304:	6105                	addi	sp,sp,32
 306:	8082                	ret
    return -1;
 308:	597d                	li	s2,-1
 30a:	bfcd                	j	2fc <stat+0x36>

000000000000030c <atoi>:

int
atoi(const char *s)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 312:	00054683          	lbu	a3,0(a0)
 316:	fd06879b          	addiw	a5,a3,-48
 31a:	0ff7f793          	zext.b	a5,a5
 31e:	4625                	li	a2,9
 320:	02f66863          	bltu	a2,a5,350 <atoi+0x44>
 324:	872a                	mv	a4,a0
  n = 0;
 326:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 328:	0705                	addi	a4,a4,1
 32a:	0025179b          	slliw	a5,a0,0x2
 32e:	9fa9                	addw	a5,a5,a0
 330:	0017979b          	slliw	a5,a5,0x1
 334:	9fb5                	addw	a5,a5,a3
 336:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 33a:	00074683          	lbu	a3,0(a4)
 33e:	fd06879b          	addiw	a5,a3,-48
 342:	0ff7f793          	zext.b	a5,a5
 346:	fef671e3          	bgeu	a2,a5,328 <atoi+0x1c>
  return n;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
  n = 0;
 350:	4501                	li	a0,0
 352:	bfe5                	j	34a <atoi+0x3e>

0000000000000354 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 35a:	02b57463          	bgeu	a0,a1,382 <memmove+0x2e>
    while(n-- > 0)
 35e:	00c05f63          	blez	a2,37c <memmove+0x28>
 362:	1602                	slli	a2,a2,0x20
 364:	9201                	srli	a2,a2,0x20
 366:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 36a:	872a                	mv	a4,a0
      *dst++ = *src++;
 36c:	0585                	addi	a1,a1,1
 36e:	0705                	addi	a4,a4,1
 370:	fff5c683          	lbu	a3,-1(a1)
 374:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 378:	fef71ae3          	bne	a4,a5,36c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
    dst += n;
 382:	00c50733          	add	a4,a0,a2
    src += n;
 386:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 388:	fec05ae3          	blez	a2,37c <memmove+0x28>
 38c:	fff6079b          	addiw	a5,a2,-1
 390:	1782                	slli	a5,a5,0x20
 392:	9381                	srli	a5,a5,0x20
 394:	fff7c793          	not	a5,a5
 398:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 39a:	15fd                	addi	a1,a1,-1
 39c:	177d                	addi	a4,a4,-1
 39e:	0005c683          	lbu	a3,0(a1)
 3a2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a6:	fee79ae3          	bne	a5,a4,39a <memmove+0x46>
 3aa:	bfc9                	j	37c <memmove+0x28>

00000000000003ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3b2:	ca05                	beqz	a2,3e2 <memcmp+0x36>
 3b4:	fff6069b          	addiw	a3,a2,-1
 3b8:	1682                	slli	a3,a3,0x20
 3ba:	9281                	srli	a3,a3,0x20
 3bc:	0685                	addi	a3,a3,1
 3be:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c0:	00054783          	lbu	a5,0(a0)
 3c4:	0005c703          	lbu	a4,0(a1)
 3c8:	00e79863          	bne	a5,a4,3d8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3cc:	0505                	addi	a0,a0,1
    p2++;
 3ce:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3d0:	fed518e3          	bne	a0,a3,3c0 <memcmp+0x14>
  }
  return 0;
 3d4:	4501                	li	a0,0
 3d6:	a019                	j	3dc <memcmp+0x30>
      return *p1 - *p2;
 3d8:	40e7853b          	subw	a0,a5,a4
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret
  return 0;
 3e2:	4501                	li	a0,0
 3e4:	bfe5                	j	3dc <memcmp+0x30>

00000000000003e6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ee:	00000097          	auipc	ra,0x0
 3f2:	f66080e7          	jalr	-154(ra) # 354 <memmove>
}
 3f6:	60a2                	ld	ra,8(sp)
 3f8:	6402                	ld	s0,0(sp)
 3fa:	0141                	addi	sp,sp,16
 3fc:	8082                	ret

00000000000003fe <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3fe:	4885                	li	a7,1
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exit>:
.global exit
exit:
 li a7, SYS_exit
 406:	4889                	li	a7,2
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <wait>:
.global wait
wait:
 li a7, SYS_wait
 40e:	488d                	li	a7,3
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 416:	4891                	li	a7,4
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <read>:
.global read
read:
 li a7, SYS_read
 41e:	4895                	li	a7,5
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <write>:
.global write
write:
 li a7, SYS_write
 426:	48c1                	li	a7,16
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <close>:
.global close
close:
 li a7, SYS_close
 42e:	48d5                	li	a7,21
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <kill>:
.global kill
kill:
 li a7, SYS_kill
 436:	4899                	li	a7,6
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <exec>:
.global exec
exec:
 li a7, SYS_exec
 43e:	489d                	li	a7,7
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <open>:
.global open
open:
 li a7, SYS_open
 446:	48bd                	li	a7,15
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 44e:	48c5                	li	a7,17
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 456:	48c9                	li	a7,18
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 45e:	48a1                	li	a7,8
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <link>:
.global link
link:
 li a7, SYS_link
 466:	48cd                	li	a7,19
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 46e:	48d1                	li	a7,20
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 476:	48a5                	li	a7,9
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <dup>:
.global dup
dup:
 li a7, SYS_dup
 47e:	48a9                	li	a7,10
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 486:	48ad                	li	a7,11
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 48e:	48b1                	li	a7,12
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 496:	48b5                	li	a7,13
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 49e:	48b9                	li	a7,14
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a6:	1101                	addi	sp,sp,-32
 4a8:	ec06                	sd	ra,24(sp)
 4aa:	e822                	sd	s0,16(sp)
 4ac:	1000                	addi	s0,sp,32
 4ae:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b2:	4605                	li	a2,1
 4b4:	fef40593          	addi	a1,s0,-17
 4b8:	00000097          	auipc	ra,0x0
 4bc:	f6e080e7          	jalr	-146(ra) # 426 <write>
}
 4c0:	60e2                	ld	ra,24(sp)
 4c2:	6442                	ld	s0,16(sp)
 4c4:	6105                	addi	sp,sp,32
 4c6:	8082                	ret

00000000000004c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c8:	7139                	addi	sp,sp,-64
 4ca:	fc06                	sd	ra,56(sp)
 4cc:	f822                	sd	s0,48(sp)
 4ce:	f426                	sd	s1,40(sp)
 4d0:	0080                	addi	s0,sp,64
 4d2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d4:	c299                	beqz	a3,4da <printint+0x12>
 4d6:	0805cb63          	bltz	a1,56c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4da:	2581                	sext.w	a1,a1
  neg = 0;
 4dc:	4881                	li	a7,0
 4de:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4e2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4e4:	2601                	sext.w	a2,a2
 4e6:	00000517          	auipc	a0,0x0
 4ea:	4ca50513          	addi	a0,a0,1226 # 9b0 <digits>
 4ee:	883a                	mv	a6,a4
 4f0:	2705                	addiw	a4,a4,1
 4f2:	02c5f7bb          	remuw	a5,a1,a2
 4f6:	1782                	slli	a5,a5,0x20
 4f8:	9381                	srli	a5,a5,0x20
 4fa:	97aa                	add	a5,a5,a0
 4fc:	0007c783          	lbu	a5,0(a5)
 500:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 504:	0005879b          	sext.w	a5,a1
 508:	02c5d5bb          	divuw	a1,a1,a2
 50c:	0685                	addi	a3,a3,1
 50e:	fec7f0e3          	bgeu	a5,a2,4ee <printint+0x26>
  if(neg)
 512:	00088c63          	beqz	a7,52a <printint+0x62>
    buf[i++] = '-';
 516:	fd070793          	addi	a5,a4,-48
 51a:	00878733          	add	a4,a5,s0
 51e:	02d00793          	li	a5,45
 522:	fef70823          	sb	a5,-16(a4)
 526:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 52a:	02e05c63          	blez	a4,562 <printint+0x9a>
 52e:	f04a                	sd	s2,32(sp)
 530:	ec4e                	sd	s3,24(sp)
 532:	fc040793          	addi	a5,s0,-64
 536:	00e78933          	add	s2,a5,a4
 53a:	fff78993          	addi	s3,a5,-1
 53e:	99ba                	add	s3,s3,a4
 540:	377d                	addiw	a4,a4,-1
 542:	1702                	slli	a4,a4,0x20
 544:	9301                	srli	a4,a4,0x20
 546:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54a:	fff94583          	lbu	a1,-1(s2)
 54e:	8526                	mv	a0,s1
 550:	00000097          	auipc	ra,0x0
 554:	f56080e7          	jalr	-170(ra) # 4a6 <putc>
  while(--i >= 0)
 558:	197d                	addi	s2,s2,-1
 55a:	ff3918e3          	bne	s2,s3,54a <printint+0x82>
 55e:	7902                	ld	s2,32(sp)
 560:	69e2                	ld	s3,24(sp)
}
 562:	70e2                	ld	ra,56(sp)
 564:	7442                	ld	s0,48(sp)
 566:	74a2                	ld	s1,40(sp)
 568:	6121                	addi	sp,sp,64
 56a:	8082                	ret
    x = -xx;
 56c:	40b005bb          	negw	a1,a1
    neg = 1;
 570:	4885                	li	a7,1
    x = -xx;
 572:	b7b5                	j	4de <printint+0x16>

0000000000000574 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 574:	715d                	addi	sp,sp,-80
 576:	e486                	sd	ra,72(sp)
 578:	e0a2                	sd	s0,64(sp)
 57a:	f84a                	sd	s2,48(sp)
 57c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 57e:	0005c903          	lbu	s2,0(a1)
 582:	1a090a63          	beqz	s2,736 <vprintf+0x1c2>
 586:	fc26                	sd	s1,56(sp)
 588:	f44e                	sd	s3,40(sp)
 58a:	f052                	sd	s4,32(sp)
 58c:	ec56                	sd	s5,24(sp)
 58e:	e85a                	sd	s6,16(sp)
 590:	e45e                	sd	s7,8(sp)
 592:	8aaa                	mv	s5,a0
 594:	8bb2                	mv	s7,a2
 596:	00158493          	addi	s1,a1,1
  state = 0;
 59a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 59c:	02500a13          	li	s4,37
 5a0:	4b55                	li	s6,21
 5a2:	a839                	j	5c0 <vprintf+0x4c>
        putc(fd, c);
 5a4:	85ca                	mv	a1,s2
 5a6:	8556                	mv	a0,s5
 5a8:	00000097          	auipc	ra,0x0
 5ac:	efe080e7          	jalr	-258(ra) # 4a6 <putc>
 5b0:	a019                	j	5b6 <vprintf+0x42>
    } else if(state == '%'){
 5b2:	01498d63          	beq	s3,s4,5cc <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5b6:	0485                	addi	s1,s1,1
 5b8:	fff4c903          	lbu	s2,-1(s1)
 5bc:	16090763          	beqz	s2,72a <vprintf+0x1b6>
    if(state == 0){
 5c0:	fe0999e3          	bnez	s3,5b2 <vprintf+0x3e>
      if(c == '%'){
 5c4:	ff4910e3          	bne	s2,s4,5a4 <vprintf+0x30>
        state = '%';
 5c8:	89d2                	mv	s3,s4
 5ca:	b7f5                	j	5b6 <vprintf+0x42>
      if(c == 'd'){
 5cc:	13490463          	beq	s2,s4,6f4 <vprintf+0x180>
 5d0:	f9d9079b          	addiw	a5,s2,-99
 5d4:	0ff7f793          	zext.b	a5,a5
 5d8:	12fb6763          	bltu	s6,a5,706 <vprintf+0x192>
 5dc:	f9d9079b          	addiw	a5,s2,-99
 5e0:	0ff7f713          	zext.b	a4,a5
 5e4:	12eb6163          	bltu	s6,a4,706 <vprintf+0x192>
 5e8:	00271793          	slli	a5,a4,0x2
 5ec:	00000717          	auipc	a4,0x0
 5f0:	36c70713          	addi	a4,a4,876 # 958 <malloc+0x132>
 5f4:	97ba                	add	a5,a5,a4
 5f6:	439c                	lw	a5,0(a5)
 5f8:	97ba                	add	a5,a5,a4
 5fa:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5fc:	008b8913          	addi	s2,s7,8
 600:	4685                	li	a3,1
 602:	4629                	li	a2,10
 604:	000ba583          	lw	a1,0(s7)
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	ebe080e7          	jalr	-322(ra) # 4c8 <printint>
 612:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 614:	4981                	li	s3,0
 616:	b745                	j	5b6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 618:	008b8913          	addi	s2,s7,8
 61c:	4681                	li	a3,0
 61e:	4629                	li	a2,10
 620:	000ba583          	lw	a1,0(s7)
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	ea2080e7          	jalr	-350(ra) # 4c8 <printint>
 62e:	8bca                	mv	s7,s2
      state = 0;
 630:	4981                	li	s3,0
 632:	b751                	j	5b6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 634:	008b8913          	addi	s2,s7,8
 638:	4681                	li	a3,0
 63a:	4641                	li	a2,16
 63c:	000ba583          	lw	a1,0(s7)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	e86080e7          	jalr	-378(ra) # 4c8 <printint>
 64a:	8bca                	mv	s7,s2
      state = 0;
 64c:	4981                	li	s3,0
 64e:	b7a5                	j	5b6 <vprintf+0x42>
 650:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 652:	008b8c13          	addi	s8,s7,8
 656:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 65a:	03000593          	li	a1,48
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	e46080e7          	jalr	-442(ra) # 4a6 <putc>
  putc(fd, 'x');
 668:	07800593          	li	a1,120
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	e38080e7          	jalr	-456(ra) # 4a6 <putc>
 676:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 678:	00000b97          	auipc	s7,0x0
 67c:	338b8b93          	addi	s7,s7,824 # 9b0 <digits>
 680:	03c9d793          	srli	a5,s3,0x3c
 684:	97de                	add	a5,a5,s7
 686:	0007c583          	lbu	a1,0(a5)
 68a:	8556                	mv	a0,s5
 68c:	00000097          	auipc	ra,0x0
 690:	e1a080e7          	jalr	-486(ra) # 4a6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 694:	0992                	slli	s3,s3,0x4
 696:	397d                	addiw	s2,s2,-1
 698:	fe0914e3          	bnez	s2,680 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 69c:	8be2                	mv	s7,s8
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	6c02                	ld	s8,0(sp)
 6a2:	bf11                	j	5b6 <vprintf+0x42>
        s = va_arg(ap, char*);
 6a4:	008b8993          	addi	s3,s7,8
 6a8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6ac:	02090163          	beqz	s2,6ce <vprintf+0x15a>
        while(*s != 0){
 6b0:	00094583          	lbu	a1,0(s2)
 6b4:	c9a5                	beqz	a1,724 <vprintf+0x1b0>
          putc(fd, *s);
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	dee080e7          	jalr	-530(ra) # 4a6 <putc>
          s++;
 6c0:	0905                	addi	s2,s2,1
        while(*s != 0){
 6c2:	00094583          	lbu	a1,0(s2)
 6c6:	f9e5                	bnez	a1,6b6 <vprintf+0x142>
        s = va_arg(ap, char*);
 6c8:	8bce                	mv	s7,s3
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	b5ed                	j	5b6 <vprintf+0x42>
          s = "(null)";
 6ce:	00000917          	auipc	s2,0x0
 6d2:	28290913          	addi	s2,s2,642 # 950 <malloc+0x12a>
        while(*s != 0){
 6d6:	02800593          	li	a1,40
 6da:	bff1                	j	6b6 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6dc:	008b8913          	addi	s2,s7,8
 6e0:	000bc583          	lbu	a1,0(s7)
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	dc0080e7          	jalr	-576(ra) # 4a6 <putc>
 6ee:	8bca                	mv	s7,s2
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	b5d1                	j	5b6 <vprintf+0x42>
        putc(fd, c);
 6f4:	02500593          	li	a1,37
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	dac080e7          	jalr	-596(ra) # 4a6 <putc>
      state = 0;
 702:	4981                	li	s3,0
 704:	bd4d                	j	5b6 <vprintf+0x42>
        putc(fd, '%');
 706:	02500593          	li	a1,37
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	d9a080e7          	jalr	-614(ra) # 4a6 <putc>
        putc(fd, c);
 714:	85ca                	mv	a1,s2
 716:	8556                	mv	a0,s5
 718:	00000097          	auipc	ra,0x0
 71c:	d8e080e7          	jalr	-626(ra) # 4a6 <putc>
      state = 0;
 720:	4981                	li	s3,0
 722:	bd51                	j	5b6 <vprintf+0x42>
        s = va_arg(ap, char*);
 724:	8bce                	mv	s7,s3
      state = 0;
 726:	4981                	li	s3,0
 728:	b579                	j	5b6 <vprintf+0x42>
 72a:	74e2                	ld	s1,56(sp)
 72c:	79a2                	ld	s3,40(sp)
 72e:	7a02                	ld	s4,32(sp)
 730:	6ae2                	ld	s5,24(sp)
 732:	6b42                	ld	s6,16(sp)
 734:	6ba2                	ld	s7,8(sp)
    }
  }
}
 736:	60a6                	ld	ra,72(sp)
 738:	6406                	ld	s0,64(sp)
 73a:	7942                	ld	s2,48(sp)
 73c:	6161                	addi	sp,sp,80
 73e:	8082                	ret

0000000000000740 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 740:	715d                	addi	sp,sp,-80
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	addi	s0,sp,32
 748:	e010                	sd	a2,0(s0)
 74a:	e414                	sd	a3,8(s0)
 74c:	e818                	sd	a4,16(s0)
 74e:	ec1c                	sd	a5,24(s0)
 750:	03043023          	sd	a6,32(s0)
 754:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75c:	8622                	mv	a2,s0
 75e:	00000097          	auipc	ra,0x0
 762:	e16080e7          	jalr	-490(ra) # 574 <vprintf>
}
 766:	60e2                	ld	ra,24(sp)
 768:	6442                	ld	s0,16(sp)
 76a:	6161                	addi	sp,sp,80
 76c:	8082                	ret

000000000000076e <printf>:

void
printf(const char *fmt, ...)
{
 76e:	711d                	addi	sp,sp,-96
 770:	ec06                	sd	ra,24(sp)
 772:	e822                	sd	s0,16(sp)
 774:	1000                	addi	s0,sp,32
 776:	e40c                	sd	a1,8(s0)
 778:	e810                	sd	a2,16(s0)
 77a:	ec14                	sd	a3,24(s0)
 77c:	f018                	sd	a4,32(s0)
 77e:	f41c                	sd	a5,40(s0)
 780:	03043823          	sd	a6,48(s0)
 784:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 788:	00840613          	addi	a2,s0,8
 78c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 790:	85aa                	mv	a1,a0
 792:	4505                	li	a0,1
 794:	00000097          	auipc	ra,0x0
 798:	de0080e7          	jalr	-544(ra) # 574 <vprintf>
}
 79c:	60e2                	ld	ra,24(sp)
 79e:	6442                	ld	s0,16(sp)
 7a0:	6125                	addi	sp,sp,96
 7a2:	8082                	ret

00000000000007a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a4:	1141                	addi	sp,sp,-16
 7a6:	e422                	sd	s0,8(sp)
 7a8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7aa:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	00000797          	auipc	a5,0x0
 7b2:	6427b783          	ld	a5,1602(a5) # df0 <freep>
 7b6:	a02d                	j	7e0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b8:	4618                	lw	a4,8(a2)
 7ba:	9f2d                	addw	a4,a4,a1
 7bc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	6398                	ld	a4,0(a5)
 7c2:	6310                	ld	a2,0(a4)
 7c4:	a83d                	j	802 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c6:	ff852703          	lw	a4,-8(a0)
 7ca:	9f31                	addw	a4,a4,a2
 7cc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7ce:	ff053683          	ld	a3,-16(a0)
 7d2:	a091                	j	816 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	6398                	ld	a4,0(a5)
 7d6:	00e7e463          	bltu	a5,a4,7de <free+0x3a>
 7da:	00e6ea63          	bltu	a3,a4,7ee <free+0x4a>
{
 7de:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e0:	fed7fae3          	bgeu	a5,a3,7d4 <free+0x30>
 7e4:	6398                	ld	a4,0(a5)
 7e6:	00e6e463          	bltu	a3,a4,7ee <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ea:	fee7eae3          	bltu	a5,a4,7de <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7ee:	ff852583          	lw	a1,-8(a0)
 7f2:	6390                	ld	a2,0(a5)
 7f4:	02059813          	slli	a6,a1,0x20
 7f8:	01c85713          	srli	a4,a6,0x1c
 7fc:	9736                	add	a4,a4,a3
 7fe:	fae60de3          	beq	a2,a4,7b8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 802:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 806:	4790                	lw	a2,8(a5)
 808:	02061593          	slli	a1,a2,0x20
 80c:	01c5d713          	srli	a4,a1,0x1c
 810:	973e                	add	a4,a4,a5
 812:	fae68ae3          	beq	a3,a4,7c6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 816:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 818:	00000717          	auipc	a4,0x0
 81c:	5cf73c23          	sd	a5,1496(a4) # df0 <freep>
}
 820:	6422                	ld	s0,8(sp)
 822:	0141                	addi	sp,sp,16
 824:	8082                	ret

0000000000000826 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 826:	7139                	addi	sp,sp,-64
 828:	fc06                	sd	ra,56(sp)
 82a:	f822                	sd	s0,48(sp)
 82c:	f426                	sd	s1,40(sp)
 82e:	ec4e                	sd	s3,24(sp)
 830:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	02051493          	slli	s1,a0,0x20
 836:	9081                	srli	s1,s1,0x20
 838:	04bd                	addi	s1,s1,15
 83a:	8091                	srli	s1,s1,0x4
 83c:	0014899b          	addiw	s3,s1,1
 840:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 842:	00000517          	auipc	a0,0x0
 846:	5ae53503          	ld	a0,1454(a0) # df0 <freep>
 84a:	c915                	beqz	a0,87e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 84e:	4798                	lw	a4,8(a5)
 850:	08977e63          	bgeu	a4,s1,8ec <malloc+0xc6>
 854:	f04a                	sd	s2,32(sp)
 856:	e852                	sd	s4,16(sp)
 858:	e456                	sd	s5,8(sp)
 85a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 85c:	8a4e                	mv	s4,s3
 85e:	0009871b          	sext.w	a4,s3
 862:	6685                	lui	a3,0x1
 864:	00d77363          	bgeu	a4,a3,86a <malloc+0x44>
 868:	6a05                	lui	s4,0x1
 86a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 86e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 872:	00000917          	auipc	s2,0x0
 876:	57e90913          	addi	s2,s2,1406 # df0 <freep>
  if(p == (char*)-1)
 87a:	5afd                	li	s5,-1
 87c:	a091                	j	8c0 <malloc+0x9a>
 87e:	f04a                	sd	s2,32(sp)
 880:	e852                	sd	s4,16(sp)
 882:	e456                	sd	s5,8(sp)
 884:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 886:	00000797          	auipc	a5,0x0
 88a:	57278793          	addi	a5,a5,1394 # df8 <base>
 88e:	00000717          	auipc	a4,0x0
 892:	56f73123          	sd	a5,1378(a4) # df0 <freep>
 896:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 898:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 89c:	b7c1                	j	85c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 89e:	6398                	ld	a4,0(a5)
 8a0:	e118                	sd	a4,0(a0)
 8a2:	a08d                	j	904 <malloc+0xde>
  hp->s.size = nu;
 8a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8a8:	0541                	addi	a0,a0,16
 8aa:	00000097          	auipc	ra,0x0
 8ae:	efa080e7          	jalr	-262(ra) # 7a4 <free>
  return freep;
 8b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8b6:	c13d                	beqz	a0,91c <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	02977463          	bgeu	a4,s1,8e4 <malloc+0xbe>
    if(p == freep)
 8c0:	00093703          	ld	a4,0(s2)
 8c4:	853e                	mv	a0,a5
 8c6:	fef719e3          	bne	a4,a5,8b8 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 8ca:	8552                	mv	a0,s4
 8cc:	00000097          	auipc	ra,0x0
 8d0:	bc2080e7          	jalr	-1086(ra) # 48e <sbrk>
  if(p == (char*)-1)
 8d4:	fd5518e3          	bne	a0,s5,8a4 <malloc+0x7e>
        return 0;
 8d8:	4501                	li	a0,0
 8da:	7902                	ld	s2,32(sp)
 8dc:	6a42                	ld	s4,16(sp)
 8de:	6aa2                	ld	s5,8(sp)
 8e0:	6b02                	ld	s6,0(sp)
 8e2:	a03d                	j	910 <malloc+0xea>
 8e4:	7902                	ld	s2,32(sp)
 8e6:	6a42                	ld	s4,16(sp)
 8e8:	6aa2                	ld	s5,8(sp)
 8ea:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8ec:	fae489e3          	beq	s1,a4,89e <malloc+0x78>
        p->s.size -= nunits;
 8f0:	4137073b          	subw	a4,a4,s3
 8f4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f6:	02071693          	slli	a3,a4,0x20
 8fa:	01c6d713          	srli	a4,a3,0x1c
 8fe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 900:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 904:	00000717          	auipc	a4,0x0
 908:	4ea73623          	sd	a0,1260(a4) # df0 <freep>
      return (void*)(p + 1);
 90c:	01078513          	addi	a0,a5,16
  }
}
 910:	70e2                	ld	ra,56(sp)
 912:	7442                	ld	s0,48(sp)
 914:	74a2                	ld	s1,40(sp)
 916:	69e2                	ld	s3,24(sp)
 918:	6121                	addi	sp,sp,64
 91a:	8082                	ret
 91c:	7902                	ld	s2,32(sp)
 91e:	6a42                	ld	s4,16(sp)
 920:	6aa2                	ld	s5,8(sp)
 922:	6b02                	ld	s6,0(sp)
 924:	b7f5                	j	910 <malloc+0xea>
