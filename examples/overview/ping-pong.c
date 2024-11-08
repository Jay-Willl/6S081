#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int count = 0;

int main() {
    int p[2], q[2];
    pid_t pid1, pid2;
    char byte_to_send = 's';
    
    if ((pipe(p) == -1) || pipe(q) == -1) {
        exit(-1);
    }

    if ((pid1 = fork()) == -1) {
        exit(-1);
    }
    if (pid1 == 0) {
        char byte_received;

        close(0);
        dup2(p[0], 0);
        close(p[0]);
        
        close(1);
        dup2(q[1], 1);
        close(q[1]);
        
        printf("pid1 init finished");


        write(1, &byte_to_send, 1);
        for(;;) {
            read(0, &byte_received, 1);
            printf("pid2 received byte %c", byte_received);
            write(1, &byte_received, 1);
        }

    }

    if ((pid2 = fork()) == -1) {
        exit(-1);
    }
    if (pid2 == 0) {
        int byte_received;
        close(0);
        dup2(q[0], 0);
        close(q[0]);

        close(1);
        dup2(p[1], 1);
        close(p[1]);

        printf("pid2 init finished");

        for(;;) {
            count += 1;
            read(0, &byte_received, 1);
            printf("pid2 received byte %c", byte_received);
            write(1, &byte_received, 1);
        }

    }

    wait(&pid1);
    wait(&pid2);

    alarm(1);

    printf("%d", count);

    return 0;
}