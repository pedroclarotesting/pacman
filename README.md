# pacman-docker
Pacman Game - Docker App (2021)

## Build, run and test the Docker container

### Build image

```sh
docker build -t ampc/pacman .
```
### Run container

```sh
$ docker run -p 8080:80 ampc/pacman
```

Open your browser pointing to localhost:8080