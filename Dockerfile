FROM openjdk:13-jdk-oracle

ENV SONAR_VERSION=7.9.1 \
  # Database configuration
  # Defaults to using H2
  SONARQUBE_JDBC_USERNAME=sonar \
  SONARQUBE_JDBC_PASSWORD=sonar \
  SONARQUBE_JDBC_URL=

# web port
EXPOSE 9000

# add sonarqube user
RUN groupadd sonarqube && useradd -g sonarqube sonarqube -d /opt/sonarqube -s /bin/bash

# set custom Java Policy
COPY java.policy /usr/java/openjdk-13/conf/security/java.policy

# install dependencies
RUN set -x \
  && yum install -y wget procps unzip gettext \
  && yum clean all

# install dumb init
RUN wget -q -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
  && chmod +x /usr/local/bin/dumb-init

# copy our custom files
COPY run.sh /opt/sonarqube/run.sh
COPY sonar.properties /opt/sonarqube/sonar.properties

# install SonarQube
WORKDIR /opt
RUN wget -q -O /opt/sq.zip https://binaries.sonarsource.com/CommercialDistribution/sonarqube-developer/sonarqube-developer-7.9.1.zip
RUN unzip -q sq.zip \ 
  && rm /opt/sq.zip \
  && mv /opt/sonarqube-7.9.1/* /opt/sonarqube/ \
  && rm -r /opt/sonarqube-7.9.1 \
  && sed -i 's/wrapper.daemonize=TRUE/wrapper.daemonize=FALSE/g' /opt/sonarqube/bin/linux-x86-64/sonar.sh \
  && chown -R sonarqube:sonarqube /opt/sonarqube*

# make data folder accessible
VOLUME /opt/sonarqube/data

WORKDIR /opt/sonarqube

# run as unprivildged user
USER sonarqube

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/opt/sonarqube/run.sh"]
