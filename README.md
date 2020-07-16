# SonarQube Developer Docker Image

As SonarQube is not providing Docker Images for their commercial versions we had to build ourselves.

To connect to a database set these environment variables:

- `SONARQUBE_JDBC_USERNAME=sonar`
- `SONARQUBE_JDBC_PASSWORD=sonar`
- `SONARQUBE_JDBC_URL=`

For permanent storage mount the `/opt/sonarqube/data` volume.

Sample startup command:

```shell
docker run -d \
  --name=sonarqube \
  -p 127.0.0.1:9000:9000 \
  -v ~/sonarqube:/opt/sonarqube/data \
  -e SONARQUBE_JDBC_USERNAME=sonar \
  -e SONARQUBE_JDBC_PASSWORD=sonar \
  -e SONARQUBE_JDBC_URL=jdbc:postgresql://postgres/sonar \
  webmobix/sonarqube-developer:8.4.1
```
