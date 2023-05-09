#!/bin/bash

find /mnt/Storage/Backups/Backups_SPED64/* -ctime +2 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/Backups_SISBOL/* -ctime +1 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/Backups_SIMATEx/* -ctime +2 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/OCS-GLPI/* -ctime +1 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/TEAMPASS/* -ctime +15 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/ARRANCHAMENTO/* -ctime +1 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/SACVOM/* -ctime +1 -exec rm -rf "{}" \;
find /mnt/Storage/Backups/ZABBIX/* -ctime +15 -exec rm -rf "{}" \;
