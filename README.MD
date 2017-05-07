```
function sandbox {
  docker run \
  --rm -d \
  -e DISPLAY \
  -e USER_ID=$(id -u) \
  -e GROUP_ID=$(id -g) \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $PWD:/home/developer/workspace \
  justmiles/sandbox
}
```
