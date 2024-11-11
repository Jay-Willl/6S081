#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>

#define EXCHANGE_NUM 100000

double elapse_time(struct timeval start, struct timeval end)
{
    return (end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec);
}

int main()
{
    char byte = 'X';
    pid_t pid;
    struct timeval start, end;

    // create 2 pipes
    int pipe1[2], pipe2[2];
    if (pipe(pipe1) == -1 || pipe(pipe2) == -1)
    {
        perror("pipe error");
        exit(1);
    }

    // for process
    pid = fork();
    if (pid == -1)
    {
        perror("fork error");
        exit(1);
    }

    // ping pong
    if (pid == 0)
    { // child process
        for (int i = 0; i < EXCHANGE_NUM; i++) {
            read(pipe1[0], &byte, 1);
            write(pipe2[1], &byte, 1);
        }
        exit(0);
    }
    else
    { // parent process
        gettimeofday(&start, NULL);
        for (int i = 0; i < EXCHANGE_NUM; i++) {
            write(pipe1[1], &byte, 1);
            read(pipe2[0], &byte, 1);
        }
        gettimeofday(&end, NULL);
        printf("elapse time: %6f\n", elapse_time(start, end));
    }

    return 0;
}