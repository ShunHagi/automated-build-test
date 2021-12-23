#MAINTAINER ShunHaginouchi
#LABEL description="D-LogInsights v0.1 (ALL rights reserved by ShunHaginouchi)"

# ubuntuをベースイメージとして使用
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y tzdata
# timezone setting
ENV TZ=Asia/Tokyo