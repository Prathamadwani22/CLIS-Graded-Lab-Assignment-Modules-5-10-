#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid;
    int i;

    printf("Parent process PID: %d\n", getpid());

    for (i = 0; i < 3; i++) {
        pid = fork();

        if (pid == 0) {
            printf("Child process created. PID: %d\n", getpid());
            sleep(1);
            exit(0);
        } 
        else if (pid < 0) {
            perror("fork failed");
            exit(1);
        }
    }

    for (i = 0; i < 3; i++) {
        pid_t child_pid = wait(NULL);
        printf("Cleaned up child process with PID: %d\n", child_pid);
    }

    printf("All child processes cleaned. No zombies remain.\n");
    return 0;
}
