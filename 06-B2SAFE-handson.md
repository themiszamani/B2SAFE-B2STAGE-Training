# EUDAT B2SAFE hands-on
This hands-on will illustrate how B2SAFE rules can be employed to manage data across iRODS zones by policies.
The tutorial makes use of the icammands. If you did not so then please first follow the tutorial on [using iRODS](https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/01-iRODS-handson-user.md).

## B2SAFE data transfer workflow (Using B2SAFE)
### To follow this tutorial it is advised to first follow the tutorial on using iRODS.

### Outline
The tutorial will guide you through Step2 in the figure below.
As B2SAFE admin you will copy data from a user, which he/she ingested into the iRODS instance, to another location in iRODS. You will register the data and by that buil the so-called repository of records and replicate the collection to another iRODS server using the B2SAFE rules.

<img src="https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/B2SAFE_using.png" width="400px">

### Prerequisites
- Installation of the icommands
- As iRODS user ingest data into iRODS and give your B2SAFE admin access to the collection. These steps are explained in the iRODS-using tutorial. 

### iRODS rules
iRODS provides a way to execute data management procedures automatically and on regular bases or upon a certain action. To this end these procedures are defined in so-called iRODS rules.

A simple rule is:

```sh
HelloWorld {
  writeLine("stdout", "Hello, world!");
}
INPUT null
OUTPUT ruleExecOut
```

You can save this rule as hello.r and call it via the icommands:
```sh
irule -F hello.r 
```
The option *-F* indicates that the next argument is a file.
iRODS provides some standard rules which you can find here
```sh
/etc/irods/core.re
```
In 
```sh
B2SAFE-core/rulebase/
```
You will find the B2SAFE rules, which you can use and combine to enable your data management workflow.

### Example: Using B2SAFE to register a file
You can use the B2SAFE rule *EUDATCreatePID* to register a single file. The rule is located in *B2SAFE-core/rulebase/pid-service.re*.

First let's ingest a data file into iRODS.
```sh
iput -f put1.txt
```
Now let's write a rule which calls *EUDATCreatePID* and registers our *put1.txt*.
```sh
registerFile {
        EUDATCreatePID(*parent_pid, *path, *ror, bool("false"), *newPID);
}
INPUT *path = "/aliceZone/home/alice/put1.txt", *ror = "", *parent_pid =""
OUTPUT *newPID, ruleExecOut
```
And save this file as testRules/registerFile.r
The rule takes our *put1.txt* as input file. We also communicate that there does not exist a repository od resources yet (\*ror). If the file we would like to register is a replica of another file, we can give the PID of the so-called parent with the parameter \*parent_pid to introduce the correct linking of the PID entries (see also the PID tutorial).
In *OUTPUT* we define which variables should be prompted on the command line, in this case we would like to receive the newly created PID.

Execute the rule:
```sh
irule -F testRules/registerFile.r
```
The answer will be the PID, e.g.:
```sh
*newPID = 846/b2f56c02-d987-11e5-8ef9-04040a64000c
```
This PID has been created at the SURFsara epic test server and can be resolved here: http://epic3.storage.surfsara.nl:8001
Enter the full PID string and tick the box *do not redirect to URLs*. This will show you the metadata stored with the PID. *URL* contains the iRODS path where to find the file. You will find that the B2SAFE rule also automatically calculated and stored a sha256 checksum. The field *100/LOC* also contains the location of our file. This field will become interesting when we create chains of replicas of files.





