docker run --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME:$HOME \
  -e XDG_CONFIG_HOME=$XDG_CONFIG_HOME \
  -e DISPLAY=$DISPLAY \
  -e HOME=$HOME \
  -e HOST_UID=$(id -u) \
  -e HOST_GID=$(id -g) \
  -e HOST_USER=$(id -un) \
  -w $HOME \
  --device /dev/dri \
  --group-add video \
  --network host \
  --device /dev/snd \
  --group-add audio \
  anycubic-slicer-next:latest
