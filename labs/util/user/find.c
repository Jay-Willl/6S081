#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fs.h"
#include "user/user.h"

void find(char *path, char *target)
{
    int fd;
    struct stat st;
    struct dirent de;

    if ((fd = open(path, 0)) < 0)
    {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0)
    {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    if (st.type == T_FILE)
    {
        close(fd);
        return;
    }

    char buf[512];
    char *p;
    strcpy(buf, path);
    p = buf + strlen(buf);
    *p = '/';
    p += 1;
    

    if (st.type == T_DIR)
    {
        while (read(fd, &de, sizeof(de)) == sizeof(de))
        {
            // corner cases
            if (de.inum == 0)
            {
                continue;
            }
            if (strcmp(".", de.name) == 0 ||
                strcmp("..", de.name) == 0)
            {
                continue;
            }

            // add name to path
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;

            if (stat(buf, &st) < 0) {
                fprintf(2, "find: cannot stat %s\n", path);
                continue;
            }

            if (strcmp(de.name, target) == 0) {
                printf("%s\n", buf);
            }

            if (st.type == T_DIR) {
                find(buf, target);
            }

        }
    }
    close(fd);
}

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        printf("usage: find <path> <name>\n");
        exit(0);
    }

    find(argv[1], argv[2]);
    exit(0);
}