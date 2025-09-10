source .env.container

source .env.network

LOCALHOST_PORT=3000
CONTAINER_PORT=3000

BACKEND_CONTAINER_NAME="backend"
BACKEND_IMAGE_NAME="backend:latest"

MONGODB_HOST="mongodb"

if [ "$(docker ps -aq -f name=$BACKEND_CONTAINER_NAME)" ]; then
    echo "A container with the name $BACKEND_CONTAINER_NAME already exists."
    echo "The container will be removed when stopped."
    echo "To stop the container, run: docker stop $BACKEND_CONTAINER_NAME."
    exit 1
fi

docker build -t $BACKEND_IMAGE_NAME .

docker run --rm -d --name $BACKEND_CONTAINER_NAME \
-p $LOCALHOST_PORT:$CONTAINER_PORT \
-e MONGODB_INITDB_ROOT_USERNAME=$ROOT_USER \
-e MONGODB_INITDB_ROOT_PASSWORD=$ROOT_PASSWORD \
-e KEY_VALUE_DB=$KEY_VALUE_DB \
-e KEY_VALUE_USER=$KEY_VALUE_USER \
-e KEY_VALUE_PASSWORD=$KEY_VALUE_PASSWORD \
-e PORT=$CONTAINER_PORT \
-e MONGODB_HOST=$MONGODB_HOST \
-v ./src:/app/src \
--network $NETWORK_NAME \
$BACKEND_IMAGE_NAME