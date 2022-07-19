# Make your RHEL RAW image work in a Raspberry Pi 4 with pify-rhel

## What is pify-rhel?
This is a really simple (but useful) shell script that mounts your RHEL RAW image and copy the required files to make it work in a Raspberry Pi 4 

## What are those "required files"?
Raspberry Pi does not follow the ServerReady standard, and RHEL needs the UEFI support to boot. There is a group of smart people that are trying to solve this issue: The ["Pi Firmware Task Force"](https://github.com/pftf).

They developed the Raspberry Pi 4 UEFI Firmware Images which makes the magic to boot RHEL.

## How do I use it?
Let's say that, for example, you created a RHEL for Edge RAW image...maybe using my [rhel-edge-quickstart scripts](https://github.com/luisarizmendi/rhel-edge-quickstart)). Once you have it locally, you just need to run this command:

```
./pify-rhel.sh -i <raw image name>
``` 

It will mount your image, copy the files, and unmount it. That's it.

> NOTE: "You modify the RAW image, it does not make a copy, so take this into account if you want to keep your original file"

Then you can use that RAW image to flash your SD card and enjoy your RHEL running on your Raspberry Pi 4.
