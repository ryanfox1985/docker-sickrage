FROM gliderlabs/alpine:3.2
MAINTAINER ryanfox1985 <wolf.fox1985@gmail.com>

ENV BUILD_PACKAGES git python-dev sqlite sqlite-dev build-base
ENV PYTHON_PACKAGES python

# Update and upgrade
RUN apk update
RUN apk upgrade
RUN apk add bash $BUILD_PACKAGES $PYTHON_PACKAGES

ENV APP_HOME /opt/SickRage
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Install Sickrage
RUN cd /opt && git clone -b master https://github.com/SiCKRAGETV/SickRage.git

# Clean up APT when done.
RUN rm -rf /var/cache/apk/*

EXPOSE 8081
VOLUME ["/config"]
ENTRYPOINT ["python", "SickBeard.py", "--pidfile=/run/sickrage.pid", "--datadir=/config"]
