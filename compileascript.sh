#!/bin/bash
# provided by SAAD-IT 2022

fName="1example.c"	# program in need of compiling
oName="1example"	# compiled binary name
dcName="gcc6_docker_1"	# stack docker container name

# copy file from currDir to container
sudo docker cp "$fName"  "$dcName:/"

# prepare cmd (in container gcc)
cmd="gcc /$fName -o /$oName"

# run gcc in container
sudo docker exec -it "$dcName" bash -c "$cmd"

# copy compiled binary back from container to currDir
sudo docker cp "$dcName:/$oName" .

# give exec permissions to compiled file (in currDir) :>
chmod u+x "$oName"
