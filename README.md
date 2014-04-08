#DockerSSHD

SSH accessable docker container recipe.

##Usage

In Host Machine

Get this code

    git clone git@github.com:yss44/docker_ssh.git ~/docker_ssh

Generate ssh key

    ssh-keygen -t rsa -C "test@email.com"
    Enter file in which to save the key (/home/user/.ssh/id_rsa):/home/user/.ssh/docker/docker_rsa
    cp ~/.ssh/docker/docker_rsa.pub ~/docker_ssh/authorized_keys

Change username to your own

    vim ~/docker_ssh/Dockerfile

Build container

    cd ~/docker_ssh
    docker build -t user/sshd .

Run container

    $ID=docker run -p 2222 -d user/sshd
    $IP=docker inspect -format="{{ .NetworkSettings.IPAddress }}" $ID

SSH access to your container

    ssh -p 2222 -i ~/.ssh/docker/docker_rsa user@$IP


