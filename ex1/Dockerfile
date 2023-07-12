FROM marwaney/ssh-server
#RUN mkdir ~/.ssh
#RUN touch ~/.ssh/authorized_keys
#COPY hello.pub ~/.ssh/authorized_keys
#EXPOSE 22
RUN apt install openssh-server -y
RUN apt install python3 -y
RUN useradd -m hello_user
RUN apt install sudo 
RUN sudo passwd -d hello_user
RUN sudo groupadd hello_group
RUN sudo usermod -G hello_group hello_user
RUN usermod -s /bin/bash hello_user
RUN mkdir /home/hello_user/.ssh
RUN touch /home/hello_user/.ssh/authorized_keys
COPY idkey.pub /home/hello_user/.ssh/authorized_keys
RUN sudo chown hello_user:hello_group /home/hello_user/.ssh/authorized_keys
RUN cat /home/hello_user/.ssh/authorized_keys
EXPOSE 22
RUN service ssh start
CMD ["/usr/sbin/sshd", "-D"]
