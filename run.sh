#!/bin/sh

set -e

cat /opt/sonarqube/sonar.properties | envsubst > /opt/sonarqube/conf/sonar.properties

/opt/sonarqube/bin/linux-x86-64/sonar.sh start
