FROM ubuntu:latest

WORKDIR /root

RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:xmake-io/xmake
RUN apt update
RUN apt install xmake
RUN apt install mingw-w64 -y
RUN apt install gcc g++ -y
RUN mkdir /var/xmake 

COPY ./entrypoint.sh /etc/entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/etc/entrypoint.sh"]