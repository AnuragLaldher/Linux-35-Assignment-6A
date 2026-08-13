| Part                           | Code                                          | Explanation                                                                                                           |
| ------------------------------ | --------------------------------------------- | --------------------------------------------------------------------------------------
| **1. Shebang**                 | `#!/bin/bash`                                 | Tells Linux to execute this script using the Bash shell
| **2. Case statement**          | `case "$1" in`                                | Checks the **first command-line argument** and decides which operation should be
| **3. `topProcess`**            | `topProcess)`                                 | Executes this section when the user runs `./otProcessManager topProcess ...`
| **4. Memory check**            | `if [ "$3" = "memory" ]; then`                | Checks whether the third argument is `memory`.
| **5. Top memory processes**    | `ps -eo pid,user,%mem,%cpu,comm --sort=-%mem` | Displays processes and sorts them from **highest to lowest memory usage**.
| **6. Limit output**            | `head -n $(( $2 + 1))`                        | `$2` contains the number requested by the user. `+1` keeps the header along with the requested number of processes.
| **7. CPU check**               | `elif [ "$3" = "cpu" ]; then`                 | Checks whether the third argument is `cpu`.
| **8. Top CPU processes**       | `ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu` | Displays processes sorted from **highest to lowest CPU usage**.
| **9. Invalid option**          | `echo "Use memory or cpu"`                    | Displays a message if the user enters something other than `memory` or `cpu`.
| **10. End topProcess**         | `;;`                                          | Ends the `topProcess` section of the `case` statement.
| **11. Least-priority process** | `killLeastPriorityProcess)`                   | Executes when the user wants to kill the least-priority process.
| **12. Find process**           | `ps -eo pid,ni --sort=-ni`                    | Displays process IDs and their **nice values**, sorted from highest nice value to lowest.
| **13. Select process**         | `sed -n '2p'`                                 | Selects the second line, because the first line contains the header.
| **14. Extract PID**            | `awk '{print $1}'`                            | Extracts the first column, which is the **PID**.
| **15. Store PID**              | `pid=$(...)`                                  | Stores the selected PID in the `pid` variable.
| **16. Display PID**            | `echo "Killing PID: $pid"`                    | Shows which process is going to be killed.
| **17. Kill process**           | `kill "$pid"`                                 | Sends the default termination signal to that process.
| **18. Running duration**       | `RunningDurationProcess)`                     | Executes when the user wants to find how long a process has been running. 
| **19. Check PID**              | `if [[ "$2" =~ ^[0-9]+$ ]]; then`             | Checks whether the second argument contains only numbers. If yes, it treats it as a PID.
| **20. Duration by PID**        | `ps -p "$2" -o pid,comm,etime`                | Displays the PID, process name, and **elapsed running time**.
| **21. Duration by name**       | `ps -C "$2" -o pid,comm,etime`                | If the argument is not a number, it treats it as a process name and displays its running duration.
| **22. Orphan processes**       | `listOrphanProcess)`                          | Executes the orphan-process section.
| **23. Find orphan processes**  | `ps -eo pid,ppid,comm`                        | Displays PID, parent PID and command name for all processes.
| **24. Check PPID**             | `awk '$2 == 1'`                               | Displays processes whose **PPID is 1**. These are commonly treated as orphaned/reparented processes.
| **25. Zombie processes**       | `listZoombieProcess)`                         | Executes the zombie-process section.
| **26. Find zombies**           | `ps -eo pid,ppid,stat,comm`                   | Displays PID, PPID, process state and command.
| **27. Filter zombies**         | `grep ' Z'`                                   | Searches for processes whose state contains `Z`, which represents a **zombie process**.
| **28. Kill process**           | `killProcess)`                                | Executes when the user wants to kill a process.
| **29. Check PID**              | `if [[ "$2" =~ ^[0-9]+$ ]]; then`             | Checks whether the supplied process identifier is a number.
| **30. Kill by PID**            | `kill "$2"`                                   | Terminates the process using its PID.
| **31. Kill by name**           | `pkill "$2"`                                  | If the argument is a name, `pkill` searches for processes with that name and sends the termination signal.
| **32. Waiting processes**      | `ListWaitingProcess)`                         | Executes the section for processes waiting for resources.
| **33. Find waiting processes** | `ps -eo pid,ppid,stat,comm`                   | Displays process information including the process state.
| **34. Filter `D` state**       | `grep ' D'`                                   | Finds processes in **D (uninterruptible sleep)** state, commonly associated with waiting for I/O or kernel resources.
| **35. Default section**        | `*)`                                          | Executes when the user enters an unknown or incorrect command.
| **36. Usage information**      | `echo "./otProcessManager ..."`               | Displays examples showing the correct commands to use.
| **37. End case option**        | `;;`                                          | Ends the default section.
| **38. End case statement**     | `esac`                                        | Marks the end of the Bash `case` statement.
