---

### 1. Creating the Shell Script File

# Question 1

### Shell Script Analysis (analyze.sh)

$ touch analyze.sh
- This command creates an empty shell script file named `analyze.sh` which will be used to implement the required logic.

![Create Script](Snapshots/step_1.png)

---

### 2. Writing the Script Logic

$ nano analyze.sh
- This command opens the `analyze.sh` file in the nano editor to write the shell script logic.

![Write Script](Snapshots/step_2.png)

---

### 3. Shell Script Implementation
```bash
#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

if [ ! -e "$1" ]; then
    echo "Error: The given path does not exist."
    exit 1
fi

if [ -f "$1" ]; then
    lines=$(wc -l < "$1")
    words=$(wc -w < "$1")
    chars=$(wc -c < "$1")

    echo "File Analysis:"
    echo "Lines: $lines"
    echo "Words: $words"
    echo "Characters: $chars"

elif [ -d "$1" ]; then
    total_files=$(find "$1" -type f | wc -l)
    txt_files=$(find "$1" -type f -name "*.txt" | wc -l)

    echo "Directory Analysis:"
    echo "Total files: $total_files"
    echo "Text (.txt) files: $txt_files"

else
    echo "Error: Invalid input."
fi
```
- The script validates the argument count, checks whether the path exists, and performs file or directory analysis accordingly.

---

### 4. Making the Script Executable

$ chmod +x analyze.sh
- This command grants execute permission to the shell script so it can be run directly from the terminal.

![Make Executable](Snapshots/step_3.png)

