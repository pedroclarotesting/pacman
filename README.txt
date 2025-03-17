Prerequisites:
    Docker Installed
    git fork from pacman nginx
Config:
    sudo usermod -aG docker $USER <------ correr sem sudo
==========================================================================================
First step: Implementing a basic nginx image in a docker

     docker run -it --rm -d -p 8080:80 --name web nginx
     docker stop web

Outcome: Works:D! Tested in http://localhost:80
===========================================================================================
Second step: Create dockerfile

    FROM nginx  <------------------------ usa a imagem nginx
    COPY src /usr/share/nginx/html <----- mete as imagens dentro da pasta que se lê
                                          o COPY copia sempre do primeiro argument do host,
                                          para o segundo argument no docker.
    EXPOSE 80 <-------------------------- porta para http
    CMD ["nginx", "-g", "daemon off;"] <--começa o nginx
===========================================================================================
Third Step: Building the docker

    docker build -t pacman-game .
    docker run -d -p 8080:80 --name pacman-container pacman-game <-- in localhost its 8080
                                                                     in container 80
Help:
    docker ps
    docker stop <name>
    docker rm <name>
    To test websites its easier on private browser mode to avoid cookies
Outcome:
    Pacman Game Working:D!
===========================================================================================
