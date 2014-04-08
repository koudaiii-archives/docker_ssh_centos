# SSH-DOCKER-CENTOS
#
# VERSION       1

FROM centos:6.4

MAINTAINER koudaiii "cs006061@gmail.com"

ENV PATH $PATH:/usr/bin
RUN yum -y update

#Dev tools for all Docker
RUN yum -y install git vim

RUN yum -y install passwd openssh openssh-server openssh-clients sudo


# useradd user,name to koudaiii

RUN useradd koudaiii
RUN passwd -f -u koudaiii
RUN mkdir -p /home/koudaiii/.ssh;chown koudaiii /home/koudaiii/.ssh; chmod 700 /home/koudaiii/.ssh
ADD ./authorized_keys /home/koudaiii/.ssh/authorized_keys
RUN chown koudaiii /home/koudaiii/.ssh/authorized_keys;chmod 600 /home/koudaiii/.ssh/authorized_keys

# setup sudoers
RUN echo "koudaiii ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/koudaiii
RUN chmod 440 /etc/sudoers.d/koudaiii

# setup sshd
ADD ./sshd_config /etc/ssh/sshd_config
RUN /etc/init.d/sshd start;/etc/init.d/sshd stop

# expose for sshd
EXPOSE 2222

CMD ["/usr/sbin/sshd","-D"]
