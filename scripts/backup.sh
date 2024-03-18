#!/bin/sh

run()
{
    local cmd="${1}"
    ssh vps "${cmd}"
}

echo "Creating remote backup files"
run "cd tree & make backup"

echo "Downloading backup files to ./backup"
scp vps:~/tree/backup/tree.zip ./backup/tree-$(date +%Y%m%d-%H%M%S).zip

echo "Deleting remote backup files"
run "rm ~/tree/backup/tree.zip ~/tree/backup/webtrees.sql"

echo "Deleting local backup files older than 7 days"
find ./backup/ -name 'tree-*.zip' -type f -mtime +7 -exec rm {} \;
