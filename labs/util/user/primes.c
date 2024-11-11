#include "kernel/types.h"
#include "user/user.h"

int is_prime(int candidate)
{
    for (int i = 2; i < candidate; i++)
    {
        if (candidate % i == 0)
        {
            return 0;
        }
    }
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc != 1)
    {
        write(1, "usage: primes", strlen("usage: primes"));
        exit(1);
    }

    char byte = 'X';
    int prime;
    int pipe1[2], pipe2[2];
    int pid;

    if (pipe(pipe1) == -1 || pipe(pipe2) == -1)
    {
        write(1, "pipe error", strlen("pipe error"));
        exit(1);
    }

    pid = fork();
    if (pid == -1)
    {
        write(1, "fork error", strlen("fork error"));
        exit(1);
    }

    if (pid == 0)
    { // print process
        while (read(pipe1[0], &prime, 1) != 0) {
            printf("prime %d\n", prime);
            write(pipe2[1], &byte, 1);
        }
        exit(0);
    }
    else
    { // feed process
        for (int i = 2; i < 36; i++)
        {
            if (is_prime(i))
            {
                prime = i;
                write(pipe1[1], &prime, 1);
                read(pipe2[0], &byte, 1);
            }
        }
        exit(0);
    }
}