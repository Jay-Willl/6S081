#include "kernel/types.h"
#include "kernel/param.h"
#include "user/user.h"


void 
execute(char *command, char *params[]) {
    int pid = fork();
    if (pid == -1) {
        printf("fork error\n");
        exit(1);
    }

    if (pid == 0) { // child process
        exec(command, params);
        exit(0);
    } else { // parent process
        wait(&pid);
    }
}

void 
xargs(char *command, char *params[]) {
    int n, i;
    char buf[512];
    char *args[MAXARG];

    for (i = 0; params[i] != 0 && i < MAXARG - 1; i++) {
        args[i] = params[i];
    }

    while ((n = read(0, buf, sizeof(buf))) > 0) {
        buf[n] = '\0';
        char *p = buf;
        while (*p) {
            char *temp = p; // start of the line
            while (*p && *p != '\n') {
                p += 1;
            }
            if (*p == '\n') {
                *p = '\0';
                p += 1;
            }

            args[i] = temp;
            args[i + 1] = '\0';
            execute(command, args);
        }
    }
}

int
main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("usage: xargs command\n");
        exit(0);
    }

    xargs(argv[1], &argv[1]);
    exit(0);
}