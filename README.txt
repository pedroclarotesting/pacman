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
Kubernetes
===========================================================================================
First step: Start minicube and create a namespace
    minikube start
    kubectl create namespace pacman
===========================================================================================
Second step: Create deployment configuration file:
    using: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: pacman
        namespace: pacman
    spec:
        replicas: 3
        selector:
            matchLabels:
            app: pacman
        template:
            metadata:
            labels:
                app: pacman
            spec:
            containers:
            - name: pacman
                image: ghcr.io/pedroclarotesting/pacman:2.0
                ports:
                - containerPort: 80
===========================================================================================
Third step: Apply deployment and configure port-forwarding
    kubectl apply -f pacman-deployment.yaml
    kubectl get pods -n pacman
    kubectl port-forward pod/<choose_one_of_the_pods> 8080:80 -n pacman
    Help:
        kubectl delete pods --all -n pacman
===========================================================================================
Fourth Step: Create Cluster IP configurations
    using: https://kubernetes.io/docs/concepts/services-networking/cluster-ip-allocation/
    apiVersion: v1
    kind: Service
    metadata:
        name: pacman-service
        namespace: pacman
    spec:
        selector:
            app: pacman
        ports:
            - protocol: TCP
              port: 80
              targetPort: 80
        type: ClusterIP
===========================================================================================
Fifth Step: Apply Cluster IP configurations and configure portforwarding
    kubectl apply -f pacman-service.yaml
    kubectl port-forward service/pacman-service 8080:80 -n pacman
===========================================================================================
Exercise 2: 
===========================================================================================
First Task: Create a deployment named helloworld with image busybox with 12 replicas and 
            command: sleep 1d, on namespace test1
    minikube addons enable ingress
    kubectl create namespace test1

    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: helloworld
        namespace: test1
    spec:
        replicas: 12
        selector:
            matchLabels:
            app: helloworld
        template:
            metadata:
            labels:
                app: helloworld
            spec:
            containers:
            - name: busybox
                image: busybox
                command: ["sleep", "1d"]
    
    kubectl apply -f helloworld-deployment.yaml

===========================================================================================
Second Task: Group them with a ClusterIP
    apiVersion: v1
    kind: Service
    metadata:
        name: helloworld-service
        namespace: test1
    spec:
        selector:
            app: helloworld
        ports:
            - protocol: TCP
            port: 80
            targetPort: 80
        type: ClusterIP

    kubectl apply -f helloworld-service.yaml
    kubectl port-forward service/helloworld-service 8080:80 -n test1
==========================================================================================
Third Task: Start App
    helm install kubeinvaders \
    --set config.target_namespace="test1" \
    --set route_host="kubeinvaders.local" \
    --create-namespace \
    -n kubeinvaders kubeinvaders/kubeinvaders
    kubectl port-forward svc/kubeinvaders -n kubeinvaders 8081:80
===========================================================================================

