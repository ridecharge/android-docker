FROM ubuntu:14.04.2

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN add-apt-repository ppa:cwchien/gradle
RUN apt-get -y update
RUN apt-get install -y gradle-ppa openjdk-8-jdk curl gcc-multilib lib32z1 lib32stdc++6

RUN mkdir -p /opt
WORKDIR /opt
ADD http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz /opt/android-sdk_r24.3.3-linux.tgz
RUN tar -xvf /opt/android-sdk_r24.3.3-linux.tgz
ENV ANDROID_HOME /opt/android-sdk-linux
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | \
	$ANDROID_HOME/tools/android update sdk --no-ui

ONBUILD RUN mkdir -p /opt/gradle
ONBUILD WORKDIR /opt/gradle
ONBUILD COPY . /opt/gradle
ONBUILD RUN ./gradlew clean
