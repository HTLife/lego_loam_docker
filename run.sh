xhost +

## Testing if OpenGL works
# docker run --runtime=nvidia --rm -it --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" legoloam glxgears

docker run  --gpus all --rm -it --name legoloam --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $HOME/docker_share:/home jjkka132/lego_loam_docker:latest  
