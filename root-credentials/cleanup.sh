source .env.network
source .env.volume
source .env.container


if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Removing container $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
else
    echo "A container with the name $CONTAINER_NAME does not exists. Skipping container deletion"
fi

if [ "$(docker volume ls -q -f name=$VOLUME_NAME)" ]; then
    echo "Removing volume $VOLUME_NAME"
    docker volume rm $VOLUME_NAME
else
    echo "A volume with the name $VOLUME_NAME does not exists. Skipping volume deletion"
fi 


if [ "$(docker network ls -q -f name=$NETWORK_NAME)" ]; then
    echo "Removing network $NETWORK_NAME"
    docker network rm $NETWORK_NAME
else
    echo "A network with the name $NETWORK_NAME does not exists. Skipping network deletion"
fi 