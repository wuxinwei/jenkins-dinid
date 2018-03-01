FROM jenkins/jenkins:lts
LABEL maintainer=markwoo<wcgwuxinwei@gmail.com>

USER root
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

# install docker in docker
RUN apt-get update && \
        apt-get -y install apt-transport-https \
        curl \
        ca-certificates \
        gnupg2 \
        software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
        add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
        $(lsb_release -cs) \
        stable"
RUN apt-get update
RUN apt-get -y install docker-ce