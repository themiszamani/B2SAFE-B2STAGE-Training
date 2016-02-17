# Setting up an iRODS federation and replicate data with B2SAFE
This hands-on takes you through the configuration steps necessary to set up an iRODS federation. Subsequently, we illustrate how to use the B2SAFE rules to register data and replicate this data to another iRODS zone.

## Prerequisites
Two iRODS 4.1 zones enabled with B2SAFE 2.
Please refer to [B2SAFE](https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/install_B2SAFE.md) 
 and [iRODS4](https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/install_iRODS4.md)

## Configuring the iRODS federation
Assume we have to iRODS servers aliceZone with alice as irodsadmin and bobZone with bob as irodsadmin.
- We need to create remote zones on the respective machines, i.e. on aliceZone we need to create a remote zone for bobZone and vice versa.
* on aliceZone do
```sh
iadmin mkzone bobZone remote <full hostname or ipadress>:1247
```
Note that you cannot rename bobZone, it needs to be exactly the same zone name than on the iRODS server you would like to federate with.
* on bobZone do
```sh
iadmin mkzone aliceZone remote <full hostname or ipadress>:1247
```

- Next we need to grant access to alice on bobZone as rodsuser 
```sh
iadmin mkuser alice#aliceZone rodsuser
```
The '#' denotes the zone where the user 'alice' is known and authenticated. 
'rodsuser' gives alice user rights. With
```sh
iadmin lt user_type
```
you can check which other user types are knoen in iRODS.

- Same for bob on aliceZone
```sh
iadmin mkuser bob#bobZone rodsuser
```

## Testing the federation

## B2SAFE data transfer workflow (Using B2SAFE)
![Using B2SAFE](B2SAFE_using.png)
 
