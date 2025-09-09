MONGODB_IMAGE="mongodb/mongodb-community-server"
MONGODB_TAG="8.2.0-rc4-ubi8"
source .env.container
CONTAINER_PORT=27017
HOST_PORT=27017

# root credentials
ROOT_USER="admin"
ROOT_PASSWORD="root"

# key-value credentials
KEY_VALUE_DB="store"
KEY_VALUE_USER="kamrul"
KEY_VALUE_PASSWORD="root"

# connectivity
source .env.network

# storage
source .env.volume
VOLUME_CONTAINER_PATH="/data/db"

source setup.sh

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "A container with the name $CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker stop $CONTAINER_NAME."
    exit 1
fi

docker run --rm -d --name $CONTAINER_NAME \
-p $HOST_PORT:$CONTAINER_PORT \
-e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
-e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
-e KEY_VALUE_DB=$KEY_VALUE_DB \
-e KEY_VALUE_USER=$KEY_VALUE_USER \
-e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
-v ./db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro \
--network $NETWORK_NAME \
-v $VOLUME_NAME:$VOLUME_CONTAINER_PATH \
$MONGODB_IMAGE:$MONGODB_TAG