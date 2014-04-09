#Docker-CentOS6.4-SSHD

SSH accessable docker container recipe.

##Usage

In Host Machine

Get this code

    git clone https://github.com/koudaiii/docker_ssh_centos.git

Generate ssh key

    ssh-keygen -t rsa
    Enter file in which to save the key (/home/user/.ssh/id_rsa):/home/user/.ssh/docker/docker_rsa
    cp ~/.ssh/user/id_rsa.pub ~/docker_ssh_centos/authorized_keys

Change username to your own

    vim ~/docker_ssh_centos/Dockerfile

Build container

    cd ~/docker_ssh_centos
    docker build -t user/sshd .

Run container

    docker run -p 22 -d user/sshd

Get Port Number

    docker ps

SSH access to your container

    ssh localhost -p port_number

log

    https://gist.github.com/10224422.git


