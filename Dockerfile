#MAINTAINER ShunHaginouchi
#LABEL description="D-LogInsights v0.1 (ALL rights reserved by ShunHaginouchi)"

# ubuntuをベースイメージとして使用
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo

RUN apt-get -y update && apt-get install -y sudo wget vim git curl gawk make gcc
# RUN apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

#Anaconda3の導入
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
    sh Anaconda3-2020.07-Linux-x86_64.sh -b && \
    rm -f Anaconda3-2020.07-Linux-x86_64.sh && \
    sudo curl -sL https://deb.nodesource.com/setup_15.x | sudo bash - && \
    sudo apt-get install -y nodejs