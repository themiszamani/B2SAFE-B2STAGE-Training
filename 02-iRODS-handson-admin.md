# iRODS hands-on for admins
This tutorial explains how to administrate users and resources as irods admin.
We will work with the icommands.


## User admnistration with iadmin

**Exercise** Inspect the function *iadmin mkuser* and *iadmin moduser* and create a rods user and a rods admin.

[]()  | []()
------|------
mkuser      | create a user
moduser     | modify user attributes
rmuser      | delete a user
mkgroup     | create group

## iRODS resources
In iRODS you can create so-called resources which correspond to different physical locations such as resource servers and storage devices. 
There are two types of of resources, **coordinating** and **storage** resources. By combining them you can create large decision trees with storage resources as leaves and coordinating resources to decide where the data should go to. 

Recall that with *ilsresc* you can list all existing resources in your iRODS zone.
Let's create a new resource in your home directory. To this end we create a new directory called *newVault* and declare it as a new storage resource.

```sh
iadmin mkresc newResc unixfilesystem <fully qualified hostname>:/home/alice/newVault
```
Since iRODS is executed not as your local user but as *irods*, putting data into the resource located in your home directpry will fail:

```sh
iput -R newResc put2.txt
ERROR: putUtil: put error for /alicetestZone/home/alice/put2.txt, 
 status = -520013 status = -520013 UNIX_FILE_MKDIR_ERR, Permission denied
```

This can be helped by granting read and write access to the *irods* user.
Usually resources are created directly under */var/lib/irods*. 

### Composable resource trees

We will now create a resource tree in which data will bereplicated automatically between two resource. 
When you are working on our training machines please create the resources in your home directory and set the read and write access for the *irods* user. If you are working on your own machine you can create the resources directly under */var/lib/irods*.

**Create two unix file system resources**
```sh
iadmin mkresc storage1 unixfilesystem <fully qualified hostname>:/var/lib/irods/iRODS/storage1
iadmin mkresc storage2 unixfilesystem <fully qualified hostname>:/var/lib/irods/iRODS/storage2
```

**Create a coordinating replication resource**
```sh
iadmin mkresc replResc replication
```
The keyword *replication* triggers the behaviour of this ccordinating resource. It will replicate all data ingested to the attached resources.

**Connect the resources**
```sh
iadmin addchildtoresc replResc storage1
iadmin addchildtoresc replResc storage2
```

We can inspect the resource tree and put data
```sh
ilsresc
iput -R replResc put2.txt
```
When we inspect where *put2.txt* ended up we find that it is replicated between *storage1* and *storage2*

```sh
ils -L put2.txt
  alice             0 replResc;storage2           13 2016-05-05.00:12 & put2.txt
        generic    /var/lib/irods/iRODS/storage2/home/alice/put2.txt
  alice             1 replResc;storage1           13 2016-05-05.00:12 & put2.txt
        generic    /var/lib/irods/iRODS/storage1/home/alice/put2.txt
```

[]()  | []()
------|------
mkresource  | create a resource
rmresc      | delete a resource
modresc     | modify resource attributes

**Exercise** Modify the replication resource to the type *compound* and test where newly ingested data will be saved.

### Compound resources with Universal Mass storage backend
**Todo**


