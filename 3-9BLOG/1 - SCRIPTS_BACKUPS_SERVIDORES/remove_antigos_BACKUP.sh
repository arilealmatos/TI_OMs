#!/bin/bash

#find /mnt/Storage/Backups/Backups_SPED64/* -ctime +3 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/Backups_SISBOL/* -ctime +3 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/OCS-GLPI/* -ctime +14 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/Backups_SIMATEx/* -ctime +4 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/INTRANET/* -ctime +1 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/Sistemas_Legados/* -ctime +15 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/TEAMPASS/* -ctime +14 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/ARRANCHAMENTO/* -ctime +4 -exec rm -rf "{}" \;
#find /mnt/Storage/Backups/SACVOM/* -ctime +4 -exec rm -rf "{}" \;
