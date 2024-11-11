#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[]) {
    if (argc == 1 || argc > 2) {
        write(1, "usage: sleep number\n", strlen("usage: sleep number\n"));
        exit(0);
    }
    int n = atoi(argv[1]);
    sleep(n);
    exit(0);
}