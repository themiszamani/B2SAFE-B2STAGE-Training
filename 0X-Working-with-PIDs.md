# Working with Persistent Identifiers - Hands-on
This lecture illustrates the use of PIDs, more specifically it shows how to employ handles (handle.net).
The code is based on the [epicclient.py](https://github.com/EUDAT-B2SAFE/B2SAFE-core/blob/master/cmd/epicclient.py).
Please check the dependencies before you start.

```sh
python epicclient.py --help
```

You will also need a handle prefix and the respective credentials.

### How do repositories create PIDs for data objects?
### How can you create a PID for your own data objects?

1. obtain a prefix from an resolver admin
2. set up internet connection to the PID server with a client
3. create a PID
4. link PID and location of the data object

### Import necessary libraries:

```py
from epicclient import EpicClient, LocationType, Credentials
import uuid
import hashlib
import os, shutil
```
### Connect to the surfsara handle server 
### Give credentials (username, password)
```py
cred = Credentials('os', 'credentials_test')
cred.parse()
```
### Get some information on who I am on the server
```py
ec = EpicClient(cred)
print "PID server", ec.cred.baseuri
```
### Prefix is your user name which is coupled to an administratory domain
```py
print "PID prefix", ec.cred.prefix
```

### Register a file
### Location of file from Pandas example
```py
fileLocation = "https://ndownloader.figshare.com/files/2292172"
```

### Building the PID:
#### Create a universally unique identifier (uuid)
#### Take function for this from
```py
import uuid
uid = uuid.uuid1()
print(uid)
print(type(uid))
```

#### Concatenate prefix and uuid to create the PID
```py
pid = cred.prefix+'/'+str(uid)
print(pid)
```

We now have an opaque string which is unique to our resolver since
the prefix is unique (handed out by administers of the resolver).
The suffix has been created with the uuid function. 

### Link the PID and the data object.
We would like the PID to point to

```py
newHandle = ec.createHandle(pid, fileLocation)
```

Let’s go to the resolver and see what is stored there
Resolver `http://epic3.storage.surfsara.nl:8001` and type PID in or type
`http://epic3.storage.surfsara.nl:8001/841/c214e045-be8e-11e5-ac88-b8e8561bdbec`
into your browser. We can get some information on the data from the resolver.
We can retrieve the data object itself via the web-browser

### Store some handy information with your file

```py
?ec.modifyHandle
ec.modifyHandle(newHandle, "TYPE", 
    "Data Carpentry pandas example file")
```

### Store information on identity of the file --> checksum

```py
import hashlib
md5sum = hashlib.md5(
    "/Users/christines/Downloads/surveys.csv").hexdigest()
ec.modifyHandle(newHandle, "MD5", md5sum)
```

### Assume location of file has changed, modify URL field

```py
ec.modifyHandle(newHandle, "URL", 
    "/Users/christines/Downloads/surveys.csv")
```

#### Try to fetch some metadata on the file from the resolver
#### Try to resolve directly to the file
#### What happens?
* inoformation stored with the PID is ALWAYS public
* data itself can lie on a protected server/computer and not be accessible
for everyone

### Linking two files
#### Register another file

```py
uid = uuid.uuid1()
print(uid)
pid = '841'+'/'+str(uid)
```

#### Create new PID/handle for the public figshare data

```py
Handle = ec.createHandle(pid, fileLocation)
```

#### Leave information that local file should be the same as the figshare file

```py
ec.modifyHandle(newHandle, "Same_as", Handle)
```

#### To verify that they are the same, you have the md5sum stored in the pointer to the local file

