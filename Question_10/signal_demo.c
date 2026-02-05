#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

volatile sig_atomic_t sigterm_received = 0;
volatile sig_atomic_t sigint_received = 0;

void handle_sigterm(int sig) {
    printf("Parent received SIGTERM. Performing cleanup...\n");
    sigterm_received = 1;
}

void handle_sigint(int sig) {
    printf("Parent received SIGINT. Preparing to exit...\n");
    sigint_received = 1;
}

int main() {
    pid_t child1, child2;

    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent running indefinitely. PID: %d\n", getpid());

    child1 = fork();
    if (child1 == 0) {
        sleep(5);
        kill(getppid(), SIGTERM);
        exit(0);
    }

    child2 = fork();
    if (child2 == 0) {
        sleep(10);
        kill(getppid(), SIGINT);
        exit(0);
    }

    while (1) {
        if (sigterm_received) {
            printf("SIGTERM handled. Parent continues running...\n");
            sigterm_received = 0;
        }

        if (sigint_received) {
            printf("SIGINT handled. Parent exiting gracefully.\n");
            break;
        }
        sleep(1);
    }

    wait(NULL);
    wait(NULL);

    printf("Parent exited gracefully.\n");
    return 0;
}
