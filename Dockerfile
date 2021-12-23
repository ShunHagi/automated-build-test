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

# Tabpyとその前提パッケージ、半角変換のためのmojimojiとその前提パッケージをインストール
RUN apt-get install -y python3
RUN sudo apt-get install build-essential -y
RUN sudo apt -y install python3-pip
RUN python3 -m pip install --upgrade pip

# Tabpy用Pythonライブラリーのインストール
RUN sudo pip3 install tabpy

#------MeCab環境の構築-----------
#Mecabのインストール
RUN sudo apt install mecab -y
RUN sudo apt install libmecab-dev -y
RUN sudo apt install mecab-ipadic-utf8 -y


RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd mecab-ipadic-neologd
RUN sudo /mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y
RUN sudo pip3 install mecab-python3

RUN mkdir /D-LogInsights

#set path
RUN echo "dicdir =  /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd" >> /etc/mecabrc
RUN echo "userdic = /D-LogInsights/30_Dictionaries_MeCab/user_dic.dic" >> /etc/mecabrc
RUN cp /etc/mecabrc /usr/local/etc/mecabrc

RUN export PATH=$PATH:/root/anaconda3/bin

RUN sudo pip3 install mlxtend scikit-learn joblib neologdn janome gensim


# コンテナのポート9004をホストに開示
EXPOSE 9004 8888

# Tabpyを実行
CMD ["tabpy", "--config=/D-LogInsights/40_TableauPrep_Configs/tabpy.conf"]

ENV AUTHOR="Shun Haginouchi"

