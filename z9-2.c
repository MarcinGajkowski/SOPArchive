#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>


int main() {
    int i=0;
    while (1)
    {
        printf("Widziałem %d żurawi.\n", i);
        i++;
        sleep(8);
    }
    
    int handler() {
        printf("Jestem nieśmiertelny.\n");
        printf("%d", getpid());
        return getpid();
    }

    int hangup() {
        signal(SIGINT, SIG_IGN);
        return getpid();
    }

    signal(SIGINT, handler());
    signal(SIGHUP, hangup());
    
 return 0;
}