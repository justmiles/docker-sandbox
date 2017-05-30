# Sandbox
Launches a developer sandbox

## Usage
Run the docker container by passing in your X server and user credentials. Optionally, pass a directory to work in.
```
docker run \
  --rm \
  -e DISPLAY \
  -e USER_ID=$(id -u) \
  -e GROUP_ID=$(id -g) \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $PWD:/home/developer/workspace \
  justmiles/sandbox
```

Or wrap it in a function and stick it in your `~/.bashrc`
```
function sandbox {
  docker run \
  --rm \
  -e DISPLAY \
  -e USER_ID=$(id -u) \
  -e GROUP_ID=$(id -g) \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $PWD:/home/developer/workspace \
  justmiles/sandbox
}
```
