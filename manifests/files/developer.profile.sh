#!/bin/bash

# developer specific profile
export JAVA_HOME=/development/tools/jdk1.6.0_24
export MAVEN_HOME=/development/tools/maven/apache-maven-3.0.3/
export REBEL_HOME=/development/tools/jrebel
export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin

export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=256m" # -Djava.awt.headless=true