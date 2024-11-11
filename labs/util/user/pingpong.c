#include "kernel/types.h"
#include "user/user.h"

int 
main(int argc, char *argv[]) {
    if (argc != 1) {
        write(1, "usage: sleep", strlen("usage: sleep"));
        exit(0);
    }

    char byte = 'X';
    int pipe1[2], pipe2[2];
    int pid;
    if (pipe(pipe1) == -1 || pipe(pipe2) == -1) {
        write(1, "pipe error", strlen("pipe error"));
        exit(1);
    }

    pid = fork();
    if (pid == -1) {
        write(1, "fork error", strlen("fork error"));
        exit(1);
    }

    if (pid == 0) { // child process
        read(pipe1[0], &byte, 1);
        printf("%d", pid);
        write(1, ": received ping\n", strlen(": received ping\n"));
        write(pipe2[1], &byte, 1);
        exit(0);
    } else { // parent process
        write(pipe1[1], &byte, 1);
        read(pipe2[0], &byte, 1);
        printf("%d", pid);
        write(1, ": received pong\n", strlen(": received ping\n"));
        exit(0);
    }
}