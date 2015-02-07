#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14.02 LTS EC2 instance

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# emacs24 setup
git clone https://github.com/dmendia/emacsconfig
cd emacsconfig
cp -r .emacs.d/ ~/
cd ..

#Create a libraries directory to store dependencies
mkdir libraries

#Create a tools directory to store build tools and etc.
mkdir tools

#Download scala
cd libraries
wget downloads.typesafe.com/scala/2.11.5/scala-2.11.5.tgz
tar -xzvf scala-2.11.5.tgz
rm scala-2.11.5.tgz
cd ..

#Download SBT
cd tools
wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz
tar -xzvf sbt-0.13.7.tgz
rm sbt-0.13.7.tgz
cd ..

#SBT setup
mkdir .sbt
cd .sbt
mkdir 0.13
cd 0.13
mkdir plugins
cd ~
cp emacsconfig/build.sbt .sbt/0.13/plugins

#Download Java
cd libraries
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz
tar -zxvf jdk-8u31-linux-x64.tar.gz
rm jdk-8u31-linux-x64.tar.gz
cd ..

#Set-up PATH variable
export JAVA_HOME=~/libraries/jdk1.8.0_31
export PATH=$JAVA_HOME/bin:$PATH
export PATH=~/libraries/scala-2.11.5/bin:$PATH
export PATH=~/tools/sbt/bin:$PATH
