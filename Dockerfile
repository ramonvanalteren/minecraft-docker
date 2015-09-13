FROM debian:7.8
MAINTAINER Ramon van Alteren <ramon@vanalteren.nl>

RUN apt-get update 
RUN apt-get install -y curl
RUN apt-get install -y openjdk-7-jre-headless

ENV S_VERSION spigot18
ENV PORT 25565
# http://getspigot.org/spigot18/spigot_server.jar
ENV BASE_URL http://getspigot.org
ENV SERVER_FILE spigot_server.jar

RUN mkdir /opt/spigot
WORKDIR /opt/spigot

RUN curl $BASE_URL/$S_VERSION/$SERVER_FILE -o $SERVER_FILE
EXPOSE ${PORT}
COPY start_spigot.sh /opt/spigot/
COPY server.properties /opt/spigot/
COPY ops.json /opt/spigot/
RUN chmod u+x start_spigot.sh
CMD /opt/spigot/start_spigot.sh
