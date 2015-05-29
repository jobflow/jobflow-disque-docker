FROM ubuntu:latest
MAINTAINER Juan Montemayor <jam1@alum.mit.edu>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r disque && useradd -r -g disque disque

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    tcl8.5 \
    unzip

RUN rm -rf /var/lib/apt/lists

RUN curl https://codeload.github.com/antirez/disque/zip/master -o \
    /usr/local/src/disque.zip

RUN unzip /usr/local/src/disque.zip -d /usr/local/bin/
RUN cd /usr/local/bin/disque-master && \
    make install clean && \
    make test

RUN cp /usr/local/bin/disque-master/disque.conf /etc/disque.conf

COPY /etc/jobflow-disque.conf /usr/local/etc/disque/jobflow-disque.conf

RUN echo "include /usr/local/etc/disque/jobflow-disque.conf\n" >> /etc/disque.conf

RUN mkdir /data && chown disque:disque /data && \
    mkdir /var/log/disque && \
    touch /var/log/disque/disque.log && chown disque:disque /var/log/disque

VOLUME /data
WORKDIR /data

EXPOSE 7711

ENTRYPOINT disque-server /etc/disque.conf