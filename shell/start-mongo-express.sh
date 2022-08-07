#!/bin/sh
#
# This is a small helper script to launch mongo-express
#
# to make the file executable: chmod 755 start-mongo-express.sh
# V1.0

clear

echo 'create network (mongo-) now...'
docker network create mongo-network

echo 'starting mongo container (my-mongo) now...'

# start mongo db
docker run -d \
    --name my-mongo \
    --net mongo-network \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME="admin" \
    -e MONGO_INITDB_ROOT_PASSWORD="password" \
    mongo

echo 'starting mongo-express (mongo-express) container now...'

# docker run -it --rm \
docker run -d \
    --net mongo-network \
    --name mongo-express \
    -p 8081:8081 \
    -e ME_CONFIG_MONGODB_ADMINUSERNAME="admin" \
    -e ME_CONFIG_MONGODB_ADMINPASSWORD="password" \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_MONGODB_SERVER="my-mongo" \
    -e ME_CONFIG_BASICAUTH_USERNAME="user" \
    -e ME_CONFIG_BASICAUTH_PASSWORD="password" \
    mongo-express