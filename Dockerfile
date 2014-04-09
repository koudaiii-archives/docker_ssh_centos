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
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN rpm -i http://dl.fedoraproject.org/pub/epel/6/x86_64/pwgen-2.06-5.el6.x86_64.rpm

# setup TimeZone
RUN mv /etc/localtime /etc/localtime.org
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

# expose for sshd
EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
