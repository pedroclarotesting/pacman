First step: Implementing a basic nginx image in a docker

    sudo docker run -it --rm -d -p 8080:80 --name web nginx
    sudo docker stop web

Outcome: Works:)! Tested in http://localhost:80
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

    sudo docker build -t pacman-game .
    sudo docker run -d -p 8080:80 --name pacman-container pacman-game <-- in localhost its
                                                                          80 in container 
                                                                          its 80
Help:
    sudo docker ps
    sudo docker stop <name>
    sudo docker rm <name>
    To test websites its easier on private browser mode to avoid cookies
Outcome:
    Pacman Game Working:)!
===========================================================================================

