# Working with Persistent Identifiers - Hands-on
This lecture illustrates the use of PIDs, more specifically it shows how to employ handles (handle.net).
The code is based on the [epicclient.py](https://github.com/EUDAT-B2SAFE/B2SAFE-core/blob/master/cmd/epicclient.py).
Please check the dependencies before you start.

```sh
python epicclient.py --help
```

You will also need a handle prefix and the respective credentials.

## How do repositories create PIDs for data objects?
## How can you create a PID for your own data objects?

1. obtain a prefix from an resolver admin
2. set up internet connection to the PID server with a client
3. create a PID
4. link PID and location of the data object

All commands below are python commands unless indicated otherwise.

### Import necessary libraries:

```py
from epicclient import EpicClient, LocationType, Credentials
import uuid
import hashlib
import os, shutil
```
### Connect to the surfsara handle server 
To connect to the epic server you need to provide a prefix and a password. This information is stored in a json file *credentials_test* and should look like this:
```sh
{
    "baseuri": "https://epic3.storage.surfsara.nl/v2_test/handles/",
    "username": "841",
    "prefix": "841",
    "password": "XXX",
    "accept_format": "application/json",
    "debug" : "False"
}
```

- Parse credentials (username, password)
```py
cred = Credentials('os', 'credentials_test')
cred.parse()
```
- Retrieve some information about the server, this server also hosts the resolver which we will use later
```py
ec = EpicClient(cred)
print "PID server", ec.cred.baseuri
```
- The PID prefix is your user name which is coupled to an administratory domain
```py
print "PID prefix", ec.cred.prefix
```

## Registering a file
### We will register a public file from figshare. First store the file location
```py
fileLocation = "https://ndownloader.figshare.com/files/2292172"
```

### Building the PID:
- Create a universally unique identifier (uuid)
- Take function for this from
```py
import uuid
uid = uuid.uuid1()
print(uid)
print(type(uid))
```

- Concatenate your PID prefix and the uuid to create the full PID
```py
pid = cred.prefix+'/'+str(uid)
print(pid)
```

We now have an opaque string which is unique to our resolver since
the prefix is unique (handed out by administrators of the resolver).
The suffix has been created with the uuid function. 

- Link the PID and the data object. We would like the PID to point to the location we stored in *fileLocation*

```py
Handle = ec.createHandle(pid, fileLocation)
```

Let’s go to the resolver and see what is stored there
Resolver `http://epic3.storage.surfsara.nl:8001` and type in the full PID, or type
`http://epic3.storage.surfsara.nl:8001/841/c214e045-be8e-11e5-ac88-b8e8561bdbec`
into your browser. We can get some information on the data from the resolver.
We can retrieve the data object itself via the web-browser.

### Store some handy information with your file
- We can store some more information in the PID entry with the function *modifyHandle*
```py
?ec.modifyHandle
ec.modifyHandle(Handle, "TYPE", 
    "Data Carpentry pandas example file")
```

- We want to store information on identity of the file, e.g. the md5 checksum. We first have 
to generate the checksum. However, we can only create checksums for files which we 
have access to with our python compiler. In the step above we can download the file and
then conitnue to clalculate the checksum.

```py
import hashlib
md5sum = hashlib.md5(
    "surveys.csv").hexdigest()
ec.modifyHandle(Handle, "MD5", md5sum)
```

- With the resolver we can access this information. Note, this data is publicly available to anyone.

### Updating PID entries
- Assume location of file has changed. This means we need to modify the URL field.

```py
ec.modifyHandle(Handle, "URL", 
    "<PATH>/surveys.csv")
```

#### Try to fetch some metadata on the file from the resolver
#### Try to resolve directly to the file
#### What happens?

We updated the "URL" with a local path on a personal machine. That means you can no longer download the data
directly, but you have access to the data stored in the PID.

--> information stored with the PID is ALWAYS public
--> data itself can lie on a protected server/computer and not be accessible
for everyone

## Linking two files
We know that the file in the figshare repository and our local file are identical. We want to store this information
in the PIDs.

- Reregister the figshare file
- First create a new PID
```py
uid = uuid.uuid1()
print(uid)
pid = '841'+'/'+str(uid)
```

- Link the new PID/handle to the public figshare data which is still stored in *fileLocation*

```py
newHandle = ec.createHandle(pid, fileLocation)
```

- Leave information that local file should be the same as the figshare file

```py
ec.modifyHandle(Handle, "Same_as", newHandle)
```

#### To verify that they are the same, you have the md5sum stored in the pointer to the local file

