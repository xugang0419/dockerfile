# centos7-ssh-v1.0
# author xugang

FROM centos:7
RUN yum makecache fast && yum -y update glibc
RUN yum  install -y  openssh-server vim tar wget curl rsync bzip2 iptables tcpdump less telnet net-tools lsof

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' \
&& ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' \
&& ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
&& ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' \
&& echo 'RSAAuthentication yes' >> /etc/ssh/sshd_config \
&& echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

RUN yum clean all

RUN mkdir /var/run/sshd

EXPOSE 22 80 443 3306 8080 8081 9999

RUN echo "123456" | passwd root --stdin

ADD jdk-8u221-linux-x64.tar.gz /usr/local/jdk/
ADD rmrb_ip-1.0.jar start.sh /root/

RUN chmod -R 777 /root/start.sh

ENV JAVA_HOME=/usr/local/jdk/jdk1.8.0_221
ENV PATH=$PATH:$JAVA_HOME/bin


#CMD ["java","-jar","/root/rmrb_ip-1.0.jar"]
#CMD ["/usr/sbin/sshd","-D"] 
#ENTRYPOINT ["/usr/sbin/sshd","-D"] 


ENTRYPOINT  ["sh","/root/start.sh"] 


# 构建镜像
#docker image build -t centosx:1.1 .
#启动容器
#docker run -it -d --name os1 -p 222:22 -p 9999:9999 centosx:1.1






