
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"

void find(char *path, char *target)
{
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	25313423          	sd	s3,584(sp)
  10:	25413023          	sd	s4,576(sp)
  14:	1c80                	addi	s0,sp,624
  16:	8a2a                	mv	s4,a0
  18:	89ae                	mv	s3,a1
    int fd;
    struct stat st;
    struct dirent de;

    if ((fd = open(path, 0)) < 0)
  1a:	4581                	li	a1,0
  1c:	00000097          	auipc	ra,0x0
  20:	4a4080e7          	jalr	1188(ra) # 4c0 <open>
  24:	08054463          	bltz	a0,ac <find+0xac>
  28:	24913c23          	sd	s1,600(sp)
  2c:	84aa                	mv	s1,a0
    {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0)
  2e:	fa840593          	addi	a1,s0,-88
  32:	00000097          	auipc	ra,0x0
  36:	4a6080e7          	jalr	1190(ra) # 4d8 <fstat>
  3a:	08054463          	bltz	a0,c2 <find+0xc2>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    if (st.type == T_FILE)
  3e:	fb041703          	lh	a4,-80(s0)
  42:	4789                	li	a5,2
  44:	0af70163          	beq	a4,a5,e6 <find+0xe6>
  48:	25213823          	sd	s2,592(sp)
        return;
    }

    char buf[512];
    char *p;
    strcpy(buf, path);
  4c:	85d2                	mv	a1,s4
  4e:	d9840513          	addi	a0,s0,-616
  52:	00000097          	auipc	ra,0x0
  56:	1c2080e7          	jalr	450(ra) # 214 <strcpy>
    p = buf + strlen(buf);
  5a:	d9840513          	addi	a0,s0,-616
  5e:	00000097          	auipc	ra,0x0
  62:	1fe080e7          	jalr	510(ra) # 25c <strlen>
  66:	1502                	slli	a0,a0,0x20
  68:	9101                	srli	a0,a0,0x20
  6a:	d9840793          	addi	a5,s0,-616
  6e:	00a78933          	add	s2,a5,a0
    *p = '/';
  72:	02f00793          	li	a5,47
  76:	00f90023          	sb	a5,0(s2)
    p += 1;
    

    if (st.type == T_DIR)
  7a:	fb041703          	lh	a4,-80(s0)
  7e:	4785                	li	a5,1
  80:	06f70b63          	beq	a4,a5,f6 <find+0xf6>
                find(buf, target);
            }

        }
    }
    close(fd);
  84:	8526                	mv	a0,s1
  86:	00000097          	auipc	ra,0x0
  8a:	422080e7          	jalr	1058(ra) # 4a8 <close>
  8e:	25813483          	ld	s1,600(sp)
  92:	25013903          	ld	s2,592(sp)
}
  96:	26813083          	ld	ra,616(sp)
  9a:	26013403          	ld	s0,608(sp)
  9e:	24813983          	ld	s3,584(sp)
  a2:	24013a03          	ld	s4,576(sp)
  a6:	27010113          	addi	sp,sp,624
  aa:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  ac:	8652                	mv	a2,s4
  ae:	00001597          	auipc	a1,0x1
  b2:	8f258593          	addi	a1,a1,-1806 # 9a0 <malloc+0x100>
  b6:	4509                	li	a0,2
  b8:	00000097          	auipc	ra,0x0
  bc:	702080e7          	jalr	1794(ra) # 7ba <fprintf>
        return;
  c0:	bfd9                	j	96 <find+0x96>
        fprintf(2, "find: cannot stat %s\n", path);
  c2:	8652                	mv	a2,s4
  c4:	00001597          	auipc	a1,0x1
  c8:	8fc58593          	addi	a1,a1,-1796 # 9c0 <malloc+0x120>
  cc:	4509                	li	a0,2
  ce:	00000097          	auipc	ra,0x0
  d2:	6ec080e7          	jalr	1772(ra) # 7ba <fprintf>
        close(fd);
  d6:	8526                	mv	a0,s1
  d8:	00000097          	auipc	ra,0x0
  dc:	3d0080e7          	jalr	976(ra) # 4a8 <close>
        return;
  e0:	25813483          	ld	s1,600(sp)
  e4:	bf4d                	j	96 <find+0x96>
        close(fd);
  e6:	8526                	mv	a0,s1
  e8:	00000097          	auipc	ra,0x0
  ec:	3c0080e7          	jalr	960(ra) # 4a8 <close>
        return;
  f0:	25813483          	ld	s1,600(sp)
  f4:	b74d                	j	96 <find+0x96>
  f6:	23513c23          	sd	s5,568(sp)
  fa:	23613823          	sd	s6,560(sp)
    p += 1;
  fe:	00190b13          	addi	s6,s2,1
            if (strcmp(".", de.name) == 0 ||
 102:	00001a97          	auipc	s5,0x1
 106:	8d6a8a93          	addi	s5,s5,-1834 # 9d8 <malloc+0x138>
        while (read(fd, &de, sizeof(de)) == sizeof(de))
 10a:	4641                	li	a2,16
 10c:	f9840593          	addi	a1,s0,-104
 110:	8526                	mv	a0,s1
 112:	00000097          	auipc	ra,0x0
 116:	386080e7          	jalr	902(ra) # 498 <read>
 11a:	47c1                	li	a5,16
 11c:	0af51763          	bne	a0,a5,1ca <find+0x1ca>
            if (de.inum == 0)
 120:	f9845783          	lhu	a5,-104(s0)
 124:	d3fd                	beqz	a5,10a <find+0x10a>
            if (strcmp(".", de.name) == 0 ||
 126:	f9a40593          	addi	a1,s0,-102
 12a:	8556                	mv	a0,s5
 12c:	00000097          	auipc	ra,0x0
 130:	104080e7          	jalr	260(ra) # 230 <strcmp>
 134:	d979                	beqz	a0,10a <find+0x10a>
                strcmp("..", de.name) == 0)
 136:	f9a40593          	addi	a1,s0,-102
 13a:	00001517          	auipc	a0,0x1
 13e:	8a650513          	addi	a0,a0,-1882 # 9e0 <malloc+0x140>
 142:	00000097          	auipc	ra,0x0
 146:	0ee080e7          	jalr	238(ra) # 230 <strcmp>
            if (strcmp(".", de.name) == 0 ||
 14a:	d161                	beqz	a0,10a <find+0x10a>
            memmove(p, de.name, DIRSIZ);
 14c:	4639                	li	a2,14
 14e:	f9a40593          	addi	a1,s0,-102
 152:	855a                	mv	a0,s6
 154:	00000097          	auipc	ra,0x0
 158:	27a080e7          	jalr	634(ra) # 3ce <memmove>
            p[DIRSIZ] = 0;
 15c:	000907a3          	sb	zero,15(s2)
            if (stat(buf, &st) < 0) {
 160:	fa840593          	addi	a1,s0,-88
 164:	d9840513          	addi	a0,s0,-616
 168:	00000097          	auipc	ra,0x0
 16c:	1d8080e7          	jalr	472(ra) # 340 <stat>
 170:	02054763          	bltz	a0,19e <find+0x19e>
            if (strcmp(de.name, target) == 0) {
 174:	85ce                	mv	a1,s3
 176:	f9a40513          	addi	a0,s0,-102
 17a:	00000097          	auipc	ra,0x0
 17e:	0b6080e7          	jalr	182(ra) # 230 <strcmp>
 182:	c90d                	beqz	a0,1b4 <find+0x1b4>
            if (st.type == T_DIR) {
 184:	fb041703          	lh	a4,-80(s0)
 188:	4785                	li	a5,1
 18a:	f8f710e3          	bne	a4,a5,10a <find+0x10a>
                find(buf, target);
 18e:	85ce                	mv	a1,s3
 190:	d9840513          	addi	a0,s0,-616
 194:	00000097          	auipc	ra,0x0
 198:	e6c080e7          	jalr	-404(ra) # 0 <find>
 19c:	b7bd                	j	10a <find+0x10a>
                fprintf(2, "find: cannot stat %s\n", path);
 19e:	8652                	mv	a2,s4
 1a0:	00001597          	auipc	a1,0x1
 1a4:	82058593          	addi	a1,a1,-2016 # 9c0 <malloc+0x120>
 1a8:	4509                	li	a0,2
 1aa:	00000097          	auipc	ra,0x0
 1ae:	610080e7          	jalr	1552(ra) # 7ba <fprintf>
                continue;
 1b2:	bfa1                	j	10a <find+0x10a>
                printf("%s\n", buf);
 1b4:	d9840593          	addi	a1,s0,-616
 1b8:	00001517          	auipc	a0,0x1
 1bc:	83050513          	addi	a0,a0,-2000 # 9e8 <malloc+0x148>
 1c0:	00000097          	auipc	ra,0x0
 1c4:	628080e7          	jalr	1576(ra) # 7e8 <printf>
 1c8:	bf75                	j	184 <find+0x184>
 1ca:	23813a83          	ld	s5,568(sp)
 1ce:	23013b03          	ld	s6,560(sp)
 1d2:	bd4d                	j	84 <find+0x84>

00000000000001d4 <main>:

int main(int argc, char *argv[])
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e406                	sd	ra,8(sp)
 1d8:	e022                	sd	s0,0(sp)
 1da:	0800                	addi	s0,sp,16
    if (argc < 3)
 1dc:	4709                	li	a4,2
 1de:	00a74f63          	blt	a4,a0,1fc <main+0x28>
    {
        printf("usage: find <path> <name>\n");
 1e2:	00001517          	auipc	a0,0x1
 1e6:	80e50513          	addi	a0,a0,-2034 # 9f0 <malloc+0x150>
 1ea:	00000097          	auipc	ra,0x0
 1ee:	5fe080e7          	jalr	1534(ra) # 7e8 <printf>
        exit(0);
 1f2:	4501                	li	a0,0
 1f4:	00000097          	auipc	ra,0x0
 1f8:	28c080e7          	jalr	652(ra) # 480 <exit>
 1fc:	87ae                	mv	a5,a1
    }

    find(argv[1], argv[2]);
 1fe:	698c                	ld	a1,16(a1)
 200:	6788                	ld	a0,8(a5)
 202:	00000097          	auipc	ra,0x0
 206:	dfe080e7          	jalr	-514(ra) # 0 <find>
    exit(0);
 20a:	4501                	li	a0,0
 20c:	00000097          	auipc	ra,0x0
 210:	274080e7          	jalr	628(ra) # 480 <exit>

0000000000000214 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 21a:	87aa                	mv	a5,a0
 21c:	0585                	addi	a1,a1,1
 21e:	0785                	addi	a5,a5,1
 220:	fff5c703          	lbu	a4,-1(a1)
 224:	fee78fa3          	sb	a4,-1(a5)
 228:	fb75                	bnez	a4,21c <strcpy+0x8>
    ;
  return os;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 236:	00054783          	lbu	a5,0(a0)
 23a:	cb91                	beqz	a5,24e <strcmp+0x1e>
 23c:	0005c703          	lbu	a4,0(a1)
 240:	00f71763          	bne	a4,a5,24e <strcmp+0x1e>
    p++, q++;
 244:	0505                	addi	a0,a0,1
 246:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbe5                	bnez	a5,23c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24e:	0005c503          	lbu	a0,0(a1)
}
 252:	40a7853b          	subw	a0,a5,a0
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret

000000000000025c <strlen>:

uint
strlen(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf91                	beqz	a5,282 <strlen+0x26>
 268:	0505                	addi	a0,a0,1
 26a:	87aa                	mv	a5,a0
 26c:	86be                	mv	a3,a5
 26e:	0785                	addi	a5,a5,1
 270:	fff7c703          	lbu	a4,-1(a5)
 274:	ff65                	bnez	a4,26c <strlen+0x10>
 276:	40a6853b          	subw	a0,a3,a0
 27a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret
  for(n = 0; s[n]; n++)
 282:	4501                	li	a0,0
 284:	bfe5                	j	27c <strlen+0x20>

0000000000000286 <memset>:

void*
memset(void *dst, int c, uint n)
{
 286:	1141                	addi	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 28c:	ca19                	beqz	a2,2a2 <memset+0x1c>
 28e:	87aa                	mv	a5,a0
 290:	1602                	slli	a2,a2,0x20
 292:	9201                	srli	a2,a2,0x20
 294:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 298:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 29c:	0785                	addi	a5,a5,1
 29e:	fee79de3          	bne	a5,a4,298 <memset+0x12>
  }
  return dst;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret

00000000000002a8 <strchr>:

char*
strchr(const char *s, char c)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	cb99                	beqz	a5,2c8 <strchr+0x20>
    if(*s == c)
 2b4:	00f58763          	beq	a1,a5,2c2 <strchr+0x1a>
  for(; *s; s++)
 2b8:	0505                	addi	a0,a0,1
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	fbfd                	bnez	a5,2b4 <strchr+0xc>
      return (char*)s;
  return 0;
 2c0:	4501                	li	a0,0
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	addi	sp,sp,16
 2c6:	8082                	ret
  return 0;
 2c8:	4501                	li	a0,0
 2ca:	bfe5                	j	2c2 <strchr+0x1a>

00000000000002cc <gets>:

char*
gets(char *buf, int max)
{
 2cc:	711d                	addi	sp,sp,-96
 2ce:	ec86                	sd	ra,88(sp)
 2d0:	e8a2                	sd	s0,80(sp)
 2d2:	e4a6                	sd	s1,72(sp)
 2d4:	e0ca                	sd	s2,64(sp)
 2d6:	fc4e                	sd	s3,56(sp)
 2d8:	f852                	sd	s4,48(sp)
 2da:	f456                	sd	s5,40(sp)
 2dc:	f05a                	sd	s6,32(sp)
 2de:	ec5e                	sd	s7,24(sp)
 2e0:	1080                	addi	s0,sp,96
 2e2:	8baa                	mv	s7,a0
 2e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e6:	892a                	mv	s2,a0
 2e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2ea:	4aa9                	li	s5,10
 2ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ee:	89a6                	mv	s3,s1
 2f0:	2485                	addiw	s1,s1,1
 2f2:	0344d863          	bge	s1,s4,322 <gets+0x56>
    cc = read(0, &c, 1);
 2f6:	4605                	li	a2,1
 2f8:	faf40593          	addi	a1,s0,-81
 2fc:	4501                	li	a0,0
 2fe:	00000097          	auipc	ra,0x0
 302:	19a080e7          	jalr	410(ra) # 498 <read>
    if(cc < 1)
 306:	00a05e63          	blez	a0,322 <gets+0x56>
    buf[i++] = c;
 30a:	faf44783          	lbu	a5,-81(s0)
 30e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 312:	01578763          	beq	a5,s5,320 <gets+0x54>
 316:	0905                	addi	s2,s2,1
 318:	fd679be3          	bne	a5,s6,2ee <gets+0x22>
    buf[i++] = c;
 31c:	89a6                	mv	s3,s1
 31e:	a011                	j	322 <gets+0x56>
 320:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 322:	99de                	add	s3,s3,s7
 324:	00098023          	sb	zero,0(s3)
  return buf;
}
 328:	855e                	mv	a0,s7
 32a:	60e6                	ld	ra,88(sp)
 32c:	6446                	ld	s0,80(sp)
 32e:	64a6                	ld	s1,72(sp)
 330:	6906                	ld	s2,64(sp)
 332:	79e2                	ld	s3,56(sp)
 334:	7a42                	ld	s4,48(sp)
 336:	7aa2                	ld	s5,40(sp)
 338:	7b02                	ld	s6,32(sp)
 33a:	6be2                	ld	s7,24(sp)
 33c:	6125                	addi	sp,sp,96
 33e:	8082                	ret

0000000000000340 <stat>:

int
stat(const char *n, struct stat *st)
{
 340:	1101                	addi	sp,sp,-32
 342:	ec06                	sd	ra,24(sp)
 344:	e822                	sd	s0,16(sp)
 346:	e04a                	sd	s2,0(sp)
 348:	1000                	addi	s0,sp,32
 34a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 34c:	4581                	li	a1,0
 34e:	00000097          	auipc	ra,0x0
 352:	172080e7          	jalr	370(ra) # 4c0 <open>
  if(fd < 0)
 356:	02054663          	bltz	a0,382 <stat+0x42>
 35a:	e426                	sd	s1,8(sp)
 35c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 35e:	85ca                	mv	a1,s2
 360:	00000097          	auipc	ra,0x0
 364:	178080e7          	jalr	376(ra) # 4d8 <fstat>
 368:	892a                	mv	s2,a0
  close(fd);
 36a:	8526                	mv	a0,s1
 36c:	00000097          	auipc	ra,0x0
 370:	13c080e7          	jalr	316(ra) # 4a8 <close>
  return r;
 374:	64a2                	ld	s1,8(sp)
}
 376:	854a                	mv	a0,s2
 378:	60e2                	ld	ra,24(sp)
 37a:	6442                	ld	s0,16(sp)
 37c:	6902                	ld	s2,0(sp)
 37e:	6105                	addi	sp,sp,32
 380:	8082                	ret
    return -1;
 382:	597d                	li	s2,-1
 384:	bfcd                	j	376 <stat+0x36>

0000000000000386 <atoi>:

int
atoi(const char *s)
{
 386:	1141                	addi	sp,sp,-16
 388:	e422                	sd	s0,8(sp)
 38a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 38c:	00054683          	lbu	a3,0(a0)
 390:	fd06879b          	addiw	a5,a3,-48
 394:	0ff7f793          	zext.b	a5,a5
 398:	4625                	li	a2,9
 39a:	02f66863          	bltu	a2,a5,3ca <atoi+0x44>
 39e:	872a                	mv	a4,a0
  n = 0;
 3a0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3a2:	0705                	addi	a4,a4,1
 3a4:	0025179b          	slliw	a5,a0,0x2
 3a8:	9fa9                	addw	a5,a5,a0
 3aa:	0017979b          	slliw	a5,a5,0x1
 3ae:	9fb5                	addw	a5,a5,a3
 3b0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3b4:	00074683          	lbu	a3,0(a4)
 3b8:	fd06879b          	addiw	a5,a3,-48
 3bc:	0ff7f793          	zext.b	a5,a5
 3c0:	fef671e3          	bgeu	a2,a5,3a2 <atoi+0x1c>
  return n;
}
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret
  n = 0;
 3ca:	4501                	li	a0,0
 3cc:	bfe5                	j	3c4 <atoi+0x3e>

00000000000003ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3d4:	02b57463          	bgeu	a0,a1,3fc <memmove+0x2e>
    while(n-- > 0)
 3d8:	00c05f63          	blez	a2,3f6 <memmove+0x28>
 3dc:	1602                	slli	a2,a2,0x20
 3de:	9201                	srli	a2,a2,0x20
 3e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3e6:	0585                	addi	a1,a1,1
 3e8:	0705                	addi	a4,a4,1
 3ea:	fff5c683          	lbu	a3,-1(a1)
 3ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3f2:	fef71ae3          	bne	a4,a5,3e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
    dst += n;
 3fc:	00c50733          	add	a4,a0,a2
    src += n;
 400:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 402:	fec05ae3          	blez	a2,3f6 <memmove+0x28>
 406:	fff6079b          	addiw	a5,a2,-1
 40a:	1782                	slli	a5,a5,0x20
 40c:	9381                	srli	a5,a5,0x20
 40e:	fff7c793          	not	a5,a5
 412:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 414:	15fd                	addi	a1,a1,-1
 416:	177d                	addi	a4,a4,-1
 418:	0005c683          	lbu	a3,0(a1)
 41c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 420:	fee79ae3          	bne	a5,a4,414 <memmove+0x46>
 424:	bfc9                	j	3f6 <memmove+0x28>

0000000000000426 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 426:	1141                	addi	sp,sp,-16
 428:	e422                	sd	s0,8(sp)
 42a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 42c:	ca05                	beqz	a2,45c <memcmp+0x36>
 42e:	fff6069b          	addiw	a3,a2,-1
 432:	1682                	slli	a3,a3,0x20
 434:	9281                	srli	a3,a3,0x20
 436:	0685                	addi	a3,a3,1
 438:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 43a:	00054783          	lbu	a5,0(a0)
 43e:	0005c703          	lbu	a4,0(a1)
 442:	00e79863          	bne	a5,a4,452 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 446:	0505                	addi	a0,a0,1
    p2++;
 448:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 44a:	fed518e3          	bne	a0,a3,43a <memcmp+0x14>
  }
  return 0;
 44e:	4501                	li	a0,0
 450:	a019                	j	456 <memcmp+0x30>
      return *p1 - *p2;
 452:	40e7853b          	subw	a0,a5,a4
}
 456:	6422                	ld	s0,8(sp)
 458:	0141                	addi	sp,sp,16
 45a:	8082                	ret
  return 0;
 45c:	4501                	li	a0,0
 45e:	bfe5                	j	456 <memcmp+0x30>

0000000000000460 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 460:	1141                	addi	sp,sp,-16
 462:	e406                	sd	ra,8(sp)
 464:	e022                	sd	s0,0(sp)
 466:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 468:	00000097          	auipc	ra,0x0
 46c:	f66080e7          	jalr	-154(ra) # 3ce <memmove>
}
 470:	60a2                	ld	ra,8(sp)
 472:	6402                	ld	s0,0(sp)
 474:	0141                	addi	sp,sp,16
 476:	8082                	ret

0000000000000478 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 478:	4885                	li	a7,1
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <exit>:
.global exit
exit:
 li a7, SYS_exit
 480:	4889                	li	a7,2
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <wait>:
.global wait
wait:
 li a7, SYS_wait
 488:	488d                	li	a7,3
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 490:	4891                	li	a7,4
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <read>:
.global read
read:
 li a7, SYS_read
 498:	4895                	li	a7,5
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <write>:
.global write
write:
 li a7, SYS_write
 4a0:	48c1                	li	a7,16
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <close>:
.global close
close:
 li a7, SYS_close
 4a8:	48d5                	li	a7,21
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4b0:	4899                	li	a7,6
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4b8:	489d                	li	a7,7
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <open>:
.global open
open:
 li a7, SYS_open
 4c0:	48bd                	li	a7,15
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4c8:	48c5                	li	a7,17
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4d0:	48c9                	li	a7,18
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4d8:	48a1                	li	a7,8
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <link>:
.global link
link:
 li a7, SYS_link
 4e0:	48cd                	li	a7,19
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4e8:	48d1                	li	a7,20
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f0:	48a5                	li	a7,9
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4f8:	48a9                	li	a7,10
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 500:	48ad                	li	a7,11
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 508:	48b1                	li	a7,12
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 510:	48b5                	li	a7,13
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 518:	48b9                	li	a7,14
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 520:	1101                	addi	sp,sp,-32
 522:	ec06                	sd	ra,24(sp)
 524:	e822                	sd	s0,16(sp)
 526:	1000                	addi	s0,sp,32
 528:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 52c:	4605                	li	a2,1
 52e:	fef40593          	addi	a1,s0,-17
 532:	00000097          	auipc	ra,0x0
 536:	f6e080e7          	jalr	-146(ra) # 4a0 <write>
}
 53a:	60e2                	ld	ra,24(sp)
 53c:	6442                	ld	s0,16(sp)
 53e:	6105                	addi	sp,sp,32
 540:	8082                	ret

0000000000000542 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 542:	7139                	addi	sp,sp,-64
 544:	fc06                	sd	ra,56(sp)
 546:	f822                	sd	s0,48(sp)
 548:	f426                	sd	s1,40(sp)
 54a:	0080                	addi	s0,sp,64
 54c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 54e:	c299                	beqz	a3,554 <printint+0x12>
 550:	0805cb63          	bltz	a1,5e6 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 554:	2581                	sext.w	a1,a1
  neg = 0;
 556:	4881                	li	a7,0
 558:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 55c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 55e:	2601                	sext.w	a2,a2
 560:	00000517          	auipc	a0,0x0
 564:	51050513          	addi	a0,a0,1296 # a70 <digits>
 568:	883a                	mv	a6,a4
 56a:	2705                	addiw	a4,a4,1
 56c:	02c5f7bb          	remuw	a5,a1,a2
 570:	1782                	slli	a5,a5,0x20
 572:	9381                	srli	a5,a5,0x20
 574:	97aa                	add	a5,a5,a0
 576:	0007c783          	lbu	a5,0(a5)
 57a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 57e:	0005879b          	sext.w	a5,a1
 582:	02c5d5bb          	divuw	a1,a1,a2
 586:	0685                	addi	a3,a3,1
 588:	fec7f0e3          	bgeu	a5,a2,568 <printint+0x26>
  if(neg)
 58c:	00088c63          	beqz	a7,5a4 <printint+0x62>
    buf[i++] = '-';
 590:	fd070793          	addi	a5,a4,-48
 594:	00878733          	add	a4,a5,s0
 598:	02d00793          	li	a5,45
 59c:	fef70823          	sb	a5,-16(a4)
 5a0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5a4:	02e05c63          	blez	a4,5dc <printint+0x9a>
 5a8:	f04a                	sd	s2,32(sp)
 5aa:	ec4e                	sd	s3,24(sp)
 5ac:	fc040793          	addi	a5,s0,-64
 5b0:	00e78933          	add	s2,a5,a4
 5b4:	fff78993          	addi	s3,a5,-1
 5b8:	99ba                	add	s3,s3,a4
 5ba:	377d                	addiw	a4,a4,-1
 5bc:	1702                	slli	a4,a4,0x20
 5be:	9301                	srli	a4,a4,0x20
 5c0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5c4:	fff94583          	lbu	a1,-1(s2)
 5c8:	8526                	mv	a0,s1
 5ca:	00000097          	auipc	ra,0x0
 5ce:	f56080e7          	jalr	-170(ra) # 520 <putc>
  while(--i >= 0)
 5d2:	197d                	addi	s2,s2,-1
 5d4:	ff3918e3          	bne	s2,s3,5c4 <printint+0x82>
 5d8:	7902                	ld	s2,32(sp)
 5da:	69e2                	ld	s3,24(sp)
}
 5dc:	70e2                	ld	ra,56(sp)
 5de:	7442                	ld	s0,48(sp)
 5e0:	74a2                	ld	s1,40(sp)
 5e2:	6121                	addi	sp,sp,64
 5e4:	8082                	ret
    x = -xx;
 5e6:	40b005bb          	negw	a1,a1
    neg = 1;
 5ea:	4885                	li	a7,1
    x = -xx;
 5ec:	b7b5                	j	558 <printint+0x16>

00000000000005ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ee:	715d                	addi	sp,sp,-80
 5f0:	e486                	sd	ra,72(sp)
 5f2:	e0a2                	sd	s0,64(sp)
 5f4:	f84a                	sd	s2,48(sp)
 5f6:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5f8:	0005c903          	lbu	s2,0(a1)
 5fc:	1a090a63          	beqz	s2,7b0 <vprintf+0x1c2>
 600:	fc26                	sd	s1,56(sp)
 602:	f44e                	sd	s3,40(sp)
 604:	f052                	sd	s4,32(sp)
 606:	ec56                	sd	s5,24(sp)
 608:	e85a                	sd	s6,16(sp)
 60a:	e45e                	sd	s7,8(sp)
 60c:	8aaa                	mv	s5,a0
 60e:	8bb2                	mv	s7,a2
 610:	00158493          	addi	s1,a1,1
  state = 0;
 614:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 616:	02500a13          	li	s4,37
 61a:	4b55                	li	s6,21
 61c:	a839                	j	63a <vprintf+0x4c>
        putc(fd, c);
 61e:	85ca                	mv	a1,s2
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	efe080e7          	jalr	-258(ra) # 520 <putc>
 62a:	a019                	j	630 <vprintf+0x42>
    } else if(state == '%'){
 62c:	01498d63          	beq	s3,s4,646 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 630:	0485                	addi	s1,s1,1
 632:	fff4c903          	lbu	s2,-1(s1)
 636:	16090763          	beqz	s2,7a4 <vprintf+0x1b6>
    if(state == 0){
 63a:	fe0999e3          	bnez	s3,62c <vprintf+0x3e>
      if(c == '%'){
 63e:	ff4910e3          	bne	s2,s4,61e <vprintf+0x30>
        state = '%';
 642:	89d2                	mv	s3,s4
 644:	b7f5                	j	630 <vprintf+0x42>
      if(c == 'd'){
 646:	13490463          	beq	s2,s4,76e <vprintf+0x180>
 64a:	f9d9079b          	addiw	a5,s2,-99
 64e:	0ff7f793          	zext.b	a5,a5
 652:	12fb6763          	bltu	s6,a5,780 <vprintf+0x192>
 656:	f9d9079b          	addiw	a5,s2,-99
 65a:	0ff7f713          	zext.b	a4,a5
 65e:	12eb6163          	bltu	s6,a4,780 <vprintf+0x192>
 662:	00271793          	slli	a5,a4,0x2
 666:	00000717          	auipc	a4,0x0
 66a:	3b270713          	addi	a4,a4,946 # a18 <malloc+0x178>
 66e:	97ba                	add	a5,a5,a4
 670:	439c                	lw	a5,0(a5)
 672:	97ba                	add	a5,a5,a4
 674:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 676:	008b8913          	addi	s2,s7,8
 67a:	4685                	li	a3,1
 67c:	4629                	li	a2,10
 67e:	000ba583          	lw	a1,0(s7)
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	ebe080e7          	jalr	-322(ra) # 542 <printint>
 68c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 68e:	4981                	li	s3,0
 690:	b745                	j	630 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 692:	008b8913          	addi	s2,s7,8
 696:	4681                	li	a3,0
 698:	4629                	li	a2,10
 69a:	000ba583          	lw	a1,0(s7)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	ea2080e7          	jalr	-350(ra) # 542 <printint>
 6a8:	8bca                	mv	s7,s2
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	b751                	j	630 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 6ae:	008b8913          	addi	s2,s7,8
 6b2:	4681                	li	a3,0
 6b4:	4641                	li	a2,16
 6b6:	000ba583          	lw	a1,0(s7)
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e86080e7          	jalr	-378(ra) # 542 <printint>
 6c4:	8bca                	mv	s7,s2
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	b7a5                	j	630 <vprintf+0x42>
 6ca:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6cc:	008b8c13          	addi	s8,s7,8
 6d0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6d4:	03000593          	li	a1,48
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	e46080e7          	jalr	-442(ra) # 520 <putc>
  putc(fd, 'x');
 6e2:	07800593          	li	a1,120
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e38080e7          	jalr	-456(ra) # 520 <putc>
 6f0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f2:	00000b97          	auipc	s7,0x0
 6f6:	37eb8b93          	addi	s7,s7,894 # a70 <digits>
 6fa:	03c9d793          	srli	a5,s3,0x3c
 6fe:	97de                	add	a5,a5,s7
 700:	0007c583          	lbu	a1,0(a5)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	e1a080e7          	jalr	-486(ra) # 520 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 70e:	0992                	slli	s3,s3,0x4
 710:	397d                	addiw	s2,s2,-1
 712:	fe0914e3          	bnez	s2,6fa <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 716:	8be2                	mv	s7,s8
      state = 0;
 718:	4981                	li	s3,0
 71a:	6c02                	ld	s8,0(sp)
 71c:	bf11                	j	630 <vprintf+0x42>
        s = va_arg(ap, char*);
 71e:	008b8993          	addi	s3,s7,8
 722:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 726:	02090163          	beqz	s2,748 <vprintf+0x15a>
        while(*s != 0){
 72a:	00094583          	lbu	a1,0(s2)
 72e:	c9a5                	beqz	a1,79e <vprintf+0x1b0>
          putc(fd, *s);
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	dee080e7          	jalr	-530(ra) # 520 <putc>
          s++;
 73a:	0905                	addi	s2,s2,1
        while(*s != 0){
 73c:	00094583          	lbu	a1,0(s2)
 740:	f9e5                	bnez	a1,730 <vprintf+0x142>
        s = va_arg(ap, char*);
 742:	8bce                	mv	s7,s3
      state = 0;
 744:	4981                	li	s3,0
 746:	b5ed                	j	630 <vprintf+0x42>
          s = "(null)";
 748:	00000917          	auipc	s2,0x0
 74c:	2c890913          	addi	s2,s2,712 # a10 <malloc+0x170>
        while(*s != 0){
 750:	02800593          	li	a1,40
 754:	bff1                	j	730 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 756:	008b8913          	addi	s2,s7,8
 75a:	000bc583          	lbu	a1,0(s7)
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	dc0080e7          	jalr	-576(ra) # 520 <putc>
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b5d1                	j	630 <vprintf+0x42>
        putc(fd, c);
 76e:	02500593          	li	a1,37
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	dac080e7          	jalr	-596(ra) # 520 <putc>
      state = 0;
 77c:	4981                	li	s3,0
 77e:	bd4d                	j	630 <vprintf+0x42>
        putc(fd, '%');
 780:	02500593          	li	a1,37
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	d9a080e7          	jalr	-614(ra) # 520 <putc>
        putc(fd, c);
 78e:	85ca                	mv	a1,s2
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	d8e080e7          	jalr	-626(ra) # 520 <putc>
      state = 0;
 79a:	4981                	li	s3,0
 79c:	bd51                	j	630 <vprintf+0x42>
        s = va_arg(ap, char*);
 79e:	8bce                	mv	s7,s3
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	b579                	j	630 <vprintf+0x42>
 7a4:	74e2                	ld	s1,56(sp)
 7a6:	79a2                	ld	s3,40(sp)
 7a8:	7a02                	ld	s4,32(sp)
 7aa:	6ae2                	ld	s5,24(sp)
 7ac:	6b42                	ld	s6,16(sp)
 7ae:	6ba2                	ld	s7,8(sp)
    }
  }
}
 7b0:	60a6                	ld	ra,72(sp)
 7b2:	6406                	ld	s0,64(sp)
 7b4:	7942                	ld	s2,48(sp)
 7b6:	6161                	addi	sp,sp,80
 7b8:	8082                	ret

00000000000007ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ba:	715d                	addi	sp,sp,-80
 7bc:	ec06                	sd	ra,24(sp)
 7be:	e822                	sd	s0,16(sp)
 7c0:	1000                	addi	s0,sp,32
 7c2:	e010                	sd	a2,0(s0)
 7c4:	e414                	sd	a3,8(s0)
 7c6:	e818                	sd	a4,16(s0)
 7c8:	ec1c                	sd	a5,24(s0)
 7ca:	03043023          	sd	a6,32(s0)
 7ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d6:	8622                	mv	a2,s0
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e16080e7          	jalr	-490(ra) # 5ee <vprintf>
}
 7e0:	60e2                	ld	ra,24(sp)
 7e2:	6442                	ld	s0,16(sp)
 7e4:	6161                	addi	sp,sp,80
 7e6:	8082                	ret

00000000000007e8 <printf>:

void
printf(const char *fmt, ...)
{
 7e8:	711d                	addi	sp,sp,-96
 7ea:	ec06                	sd	ra,24(sp)
 7ec:	e822                	sd	s0,16(sp)
 7ee:	1000                	addi	s0,sp,32
 7f0:	e40c                	sd	a1,8(s0)
 7f2:	e810                	sd	a2,16(s0)
 7f4:	ec14                	sd	a3,24(s0)
 7f6:	f018                	sd	a4,32(s0)
 7f8:	f41c                	sd	a5,40(s0)
 7fa:	03043823          	sd	a6,48(s0)
 7fe:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 802:	00840613          	addi	a2,s0,8
 806:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80a:	85aa                	mv	a1,a0
 80c:	4505                	li	a0,1
 80e:	00000097          	auipc	ra,0x0
 812:	de0080e7          	jalr	-544(ra) # 5ee <vprintf>
}
 816:	60e2                	ld	ra,24(sp)
 818:	6442                	ld	s0,16(sp)
 81a:	6125                	addi	sp,sp,96
 81c:	8082                	ret

000000000000081e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 81e:	1141                	addi	sp,sp,-16
 820:	e422                	sd	s0,8(sp)
 822:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 824:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 828:	00000797          	auipc	a5,0x0
 82c:	6707b783          	ld	a5,1648(a5) # e98 <freep>
 830:	a02d                	j	85a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 832:	4618                	lw	a4,8(a2)
 834:	9f2d                	addw	a4,a4,a1
 836:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83a:	6398                	ld	a4,0(a5)
 83c:	6310                	ld	a2,0(a4)
 83e:	a83d                	j	87c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 840:	ff852703          	lw	a4,-8(a0)
 844:	9f31                	addw	a4,a4,a2
 846:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 848:	ff053683          	ld	a3,-16(a0)
 84c:	a091                	j	890 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84e:	6398                	ld	a4,0(a5)
 850:	00e7e463          	bltu	a5,a4,858 <free+0x3a>
 854:	00e6ea63          	bltu	a3,a4,868 <free+0x4a>
{
 858:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85a:	fed7fae3          	bgeu	a5,a3,84e <free+0x30>
 85e:	6398                	ld	a4,0(a5)
 860:	00e6e463          	bltu	a3,a4,868 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	fee7eae3          	bltu	a5,a4,858 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 868:	ff852583          	lw	a1,-8(a0)
 86c:	6390                	ld	a2,0(a5)
 86e:	02059813          	slli	a6,a1,0x20
 872:	01c85713          	srli	a4,a6,0x1c
 876:	9736                	add	a4,a4,a3
 878:	fae60de3          	beq	a2,a4,832 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 87c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 880:	4790                	lw	a2,8(a5)
 882:	02061593          	slli	a1,a2,0x20
 886:	01c5d713          	srli	a4,a1,0x1c
 88a:	973e                	add	a4,a4,a5
 88c:	fae68ae3          	beq	a3,a4,840 <free+0x22>
    p->s.ptr = bp->s.ptr;
 890:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 892:	00000717          	auipc	a4,0x0
 896:	60f73323          	sd	a5,1542(a4) # e98 <freep>
}
 89a:	6422                	ld	s0,8(sp)
 89c:	0141                	addi	sp,sp,16
 89e:	8082                	ret

00000000000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	7139                	addi	sp,sp,-64
 8a2:	fc06                	sd	ra,56(sp)
 8a4:	f822                	sd	s0,48(sp)
 8a6:	f426                	sd	s1,40(sp)
 8a8:	ec4e                	sd	s3,24(sp)
 8aa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ac:	02051493          	slli	s1,a0,0x20
 8b0:	9081                	srli	s1,s1,0x20
 8b2:	04bd                	addi	s1,s1,15
 8b4:	8091                	srli	s1,s1,0x4
 8b6:	0014899b          	addiw	s3,s1,1
 8ba:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8bc:	00000517          	auipc	a0,0x0
 8c0:	5dc53503          	ld	a0,1500(a0) # e98 <freep>
 8c4:	c915                	beqz	a0,8f8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c8:	4798                	lw	a4,8(a5)
 8ca:	08977e63          	bgeu	a4,s1,966 <malloc+0xc6>
 8ce:	f04a                	sd	s2,32(sp)
 8d0:	e852                	sd	s4,16(sp)
 8d2:	e456                	sd	s5,8(sp)
 8d4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d6:	8a4e                	mv	s4,s3
 8d8:	0009871b          	sext.w	a4,s3
 8dc:	6685                	lui	a3,0x1
 8de:	00d77363          	bgeu	a4,a3,8e4 <malloc+0x44>
 8e2:	6a05                	lui	s4,0x1
 8e4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8e8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ec:	00000917          	auipc	s2,0x0
 8f0:	5ac90913          	addi	s2,s2,1452 # e98 <freep>
  if(p == (char*)-1)
 8f4:	5afd                	li	s5,-1
 8f6:	a091                	j	93a <malloc+0x9a>
 8f8:	f04a                	sd	s2,32(sp)
 8fa:	e852                	sd	s4,16(sp)
 8fc:	e456                	sd	s5,8(sp)
 8fe:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 900:	00000797          	auipc	a5,0x0
 904:	5a078793          	addi	a5,a5,1440 # ea0 <base>
 908:	00000717          	auipc	a4,0x0
 90c:	58f73823          	sd	a5,1424(a4) # e98 <freep>
 910:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 912:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 916:	b7c1                	j	8d6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 918:	6398                	ld	a4,0(a5)
 91a:	e118                	sd	a4,0(a0)
 91c:	a08d                	j	97e <malloc+0xde>
  hp->s.size = nu;
 91e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 922:	0541                	addi	a0,a0,16
 924:	00000097          	auipc	ra,0x0
 928:	efa080e7          	jalr	-262(ra) # 81e <free>
  return freep;
 92c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 930:	c13d                	beqz	a0,996 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 932:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 934:	4798                	lw	a4,8(a5)
 936:	02977463          	bgeu	a4,s1,95e <malloc+0xbe>
    if(p == freep)
 93a:	00093703          	ld	a4,0(s2)
 93e:	853e                	mv	a0,a5
 940:	fef719e3          	bne	a4,a5,932 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 944:	8552                	mv	a0,s4
 946:	00000097          	auipc	ra,0x0
 94a:	bc2080e7          	jalr	-1086(ra) # 508 <sbrk>
  if(p == (char*)-1)
 94e:	fd5518e3          	bne	a0,s5,91e <malloc+0x7e>
        return 0;
 952:	4501                	li	a0,0
 954:	7902                	ld	s2,32(sp)
 956:	6a42                	ld	s4,16(sp)
 958:	6aa2                	ld	s5,8(sp)
 95a:	6b02                	ld	s6,0(sp)
 95c:	a03d                	j	98a <malloc+0xea>
 95e:	7902                	ld	s2,32(sp)
 960:	6a42                	ld	s4,16(sp)
 962:	6aa2                	ld	s5,8(sp)
 964:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 966:	fae489e3          	beq	s1,a4,918 <malloc+0x78>
        p->s.size -= nunits;
 96a:	4137073b          	subw	a4,a4,s3
 96e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 970:	02071693          	slli	a3,a4,0x20
 974:	01c6d713          	srli	a4,a3,0x1c
 978:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 97a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 97e:	00000717          	auipc	a4,0x0
 982:	50a73d23          	sd	a0,1306(a4) # e98 <freep>
      return (void*)(p + 1);
 986:	01078513          	addi	a0,a5,16
  }
}
 98a:	70e2                	ld	ra,56(sp)
 98c:	7442                	ld	s0,48(sp)
 98e:	74a2                	ld	s1,40(sp)
 990:	69e2                	ld	s3,24(sp)
 992:	6121                	addi	sp,sp,64
 994:	8082                	ret
 996:	7902                	ld	s2,32(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
 99e:	b7f5                	j	98a <malloc+0xea>
