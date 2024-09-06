# Linux_Monitoring_v2.0

Real-time monitoring and research of the system status.


## Part 1. File generator

The script is run with 6 parameters. An example of running a script: \
`main.sh /opt/test 4 az 5 az.az 3kb`

**Parameter 1** is the absolute path. \
**Parameter 2** is the number of subfolders. \
**Parameter 3** is a list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 4** is the number of files in each created folder. \
**Parameter 5** - the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 6** - file size (in kilobytes, but not more than 100).

Folder and file names only consist of the letters specified in the parameters and use each of them at least 1 time.  
The length of this part of the name is at least 4 characters, plus the script run date in DDMMYY format, separated by underscores, for example: \
**./aaaz_021121/**, **./aaazzzz_021121** 

If `az` has been specified for a folder or a file name, there can be no inverse entry: \
**./zaaa_021121/** i.e. the order of the characters specified in the parameter is maintained.

When the script runs in the location specified in parameter 1, the folders and files are been created in them with the appropriate names and sizes. The script stops running if there is 1GB of free space left on the file system (in the / partition).

The script makes a log file with data on all created folders and files (full path, creation date, file size).


## Part 2. File system clogging

The script is run with 3 parameters. An example of running a script: \
`main.sh az az.az 3Mb`

**Parameter 1** is a list of English alphabet letters used in folder names (no more than 7 characters). \
**Parameter 2** the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). \
**Parameter 3** - is the file size (in Megabytes, but not more than 100).

Folder and file names only consist of the letters specified in the parameters and use each of them at least 1 time.  
The length of this part of the name is at least 5 characters, plus the script run date in DDMMYY format, separated by underscores, for example: \
**./aaazz_021121/**, **./aaazzzz_021121** 

If `az` has been specified for a folder or a file name, there can be no inverse entry: \
**./zaaa_021121/** i.e. the order of the specified characters in the parameter is maintained.

When running the script, file folders are created in different (any, except paths containing **bin** or **sbin**) locations on the file system.
The number of subfolders is up to 100. The number of files in each folder is a random number (different for each folder). The script stops running when there is 1GB of free space left on the file system (in the / partition).
Check the file system free space with  `df -h /`.

The script make a log file with data on all created folders and files (full path, creation date, file size).

At the end the script displays the start time, end time and total running time of the script. The script completes the log file with this data.


## Part 3. Cleaning the file system

The script is run with 1 parameter. The script is able to clear the system from the folders and files created in [Part 2](#part-2-file-system-clogging) in 3 ways:

1. By log file
2. By creation date and time
3. By name mask (i.e. characters, underlining and date).

The cleaning method is set as a parameter with a value of 1, 2 or 3 when you run the script.

*When deleting by date and time of creation, the user can enter the start and end times up to the minute. All files created within the specified time interval is deleted. The input can be implemented either through parameters or at runtime.*


## Part 4. Log generator

The script generates 5 **nginx** log files in *combined* format. Each log contains information for 1 day.

A random number between 100 and 1000 entries is generated per day.
For each entry there are randomly generated the following:

1. IP (any correct one, i.e. no ip such as 999.111.777.777)
2. Response codes (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. methods (GET, POST, PUT, PATCH, DELETE)
4. Dates (within a specified log day, should be in ascending order)
5. Agent request URL
6. Agents (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

Each of the response codes used are Specified in the comments of the script.


## Part 5. Monitoring

The bash script parses **nginx** logs from [Part 4](#part-4-log-generator) via **awk**.
The script is run with 1 parameter, which has a value of 1, 2, 3 or 4.

Depending on the value of the parameter, the script outputs the following:

1. All entries sorted by response code
2. All unique IPs found in the entries
3. All requests with errors (response code - 4xx or 5xxx)
4. All unique IPs found among the erroneous requests


## Part 6. **GoAccess**

Here is a report how to use the GoAccess utility to get the same information as in [Part 5](#part-5-monitoring)

The opening the web interface of the utility on the local machine is presented.


## Part 7. **Prometheus** and **Grafana**

Here is a report how to:
##### Install and configure **Prometheus** and **Grafana** in virtual machine
##### Access the **Prometheus** and **Grafana** web interfaces from a local machine

##### Add to the **Grafana** dashboard a display of CPU, available RAM, free space and the number of I/O operations on the hard disk.

##### Run the bash script from [Part 2](#part-2-file-system-clogging)
##### Check the hard disk load (disk space and read/write operations)

##### Install the **stress** utility and run the following command `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
##### Check the hard disk, RAM and CPU load


## Part 8. A ready-made dashboard

Here is a report how to:
##### Download the ready-made dashboard *Node Exporter Quickstart and Dashboard* from **Grafana Labs** official website.

##### Run the same tests as in [Part 7](#part-7-prometheus-and-grafana)

##### Start another virtual machine within the same network as the current one
##### Run a network load test using **iperf3**

##### Check the network interface load