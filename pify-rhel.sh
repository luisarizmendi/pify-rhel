#!/bin/bash



############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "This Script includes the required files to make a RHEL RAW image boot on a Raspberry Pi 4"
   echo ""
   echo "Syntax: $0 -i <RAW image>"
   echo ""
   echo "options:"
   echo "i     RAW Image name where to include the files (required)."
   echo ""
   echo "Example: $0 -i rhel-for-edge.raw"
   echo ""
}


mount_boot_partition()
{
   sector_start=$(fdisk -lu $RAW_IMAGE | grep "EFI" | awk '{print $2}')

   mkdir -p $mount_path

   mount -o rw,loop,offset=$((${sector_start} * ${sector_size})) $RAW_IMAGE $mount_path

   if [ $? -ne 0 ]; then

      echo "*********************************************************************************************"
      echo "ERROR: You cannot mount the file $RAW_IMAGE in $mount_path"
      echo "*********************************************************************************************"
      echo ""
      echo "" 
      exit -1
   fi

}

copy_pftf_files()
{
   cp ${files_location}/*.* ${mount_path}/
   if [ $? -ne 0 ]; then

      echo "*********************************************************************************************"
      echo "ERROR: You copy files from ${files_location} to $mount_path"
      echo "*********************************************************************************************"
      echo ""
      echo "" 
      exit -1
   fi
}






   # Set defaults
   RAW_IMAGE=""
   sector_size=512
   mount_path="/tmp/raw-mount"
   files_location="files/RPi4_UEFI_Firmware_v1.33"


   # Override defaults with command-line options
   while getopts ':i:' OPTION
   do
      case "$OPTION" in
         i)
            # RAW image
            RAW_IMAGE="$OPTARG"
            ;;
         ?)
            echo "Error: Invalid option"
            echo ""
            Help
            exit -1
            ;;
      esac
   done



   if [ -z "$RAW_IMAGE" ]
   then
         echo ""
         echo "You must define the Image RAW name with option -i"
         echo ""
         Help
         exit -1

   fi

   mount_boot_partition
   copy_pftf_files
   umount $mount_path


   echo "*********************************************************************************************"
   echo "DONE! Files were injected into your RAW image"
   echo ""
   echo "Flash the RAW image into the SD Card and enjoy!"
   echo "*********************************************************************************************"
   echo ""
   echo "" 

   exit 0



