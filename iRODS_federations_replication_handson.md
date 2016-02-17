# Setting up an iRODS federation and replicate data with B2SAFE
This hands-on takes you through the configuration steps necessary to set up an iRODS federation. Subsequently, we illustrate how to use the B2SAFE rules to register data and replicate this data to another iRODS zone.

## Prerequisites
Two iRODS 4.1 zones enabled with B2SAFE 2.
Please refer to [B2SAFE](https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/install_B2SAFE.md) 
 and [iRODS4](https://github.com/chStaiger/B2SAFE-B2STAGE-Training/blob/master/install_iRODS4.md)

## Configuring the iRODS federation
Assume we have to iRODS servers aliceZone with alice as irodsadmin and bobZone with bob as irodsadmin.
- We need to create remote zones on the respective machines, i.e. on aliceZone we need to create a remote zone for bobZone and vice versa.

- Next we need to give access to alice on bobZone and to bob on aliceZone

## Testing the federation

## B2SAFE data transfer workflow (Using B2SAFE)
![Using B2SAFE](B2SAFE_using.pnG)
 
