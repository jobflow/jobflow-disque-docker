# jobflow-disque-docker
[jobflow.io](http://jobflow.io) standard docker image running disque

Disque, an in-memory, distributed job queue
===

Disque is ongoing experiment to build a distributed, in memory, message broker.
Its goal is to capture the essence of the "Redis as a jobs queue" use case,
which is usually implemented using blocking list operations, and move
it into an ad-hoc, self-contained, scalable, and fault tolerant design, with
simple to understand properties and guarantees, but still resembling Redis
in terms of simplicity, performances, and implementation as a C non-blocking
networked server.

Currently (27 April 2015) the project is just an alpha quality preview, that was developed in roughly 120 hours, 244 different commits performed in 72 different days, often at night and during weekends. In short: don't expect much or rock solid production systems here.

**WARNING: This is alpha code NOT suitable for production. The implementation and API will likely change in significant ways during the next months. The code and algorithms are not tested enough. A lot more work is needed.**

[antirez/disque](https://github.com/antirez/disque)


## Install

    docker build -t="jobflow-disque:Dev" .
 
## Run Server
    docker run -d jobflow-disque:Dev

or from docker hub

    docker run -i -t -d jmontemayor/jobflow-disque:latest

## Connect
Find the ip of the running container

    docker ps

    CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS              PORTS                     NAMES

    123456786765        jobflow-disque:v0.1.1   disque-server     2 minutes ago       Up 2 minutes        0.0.0.0:49153->7711/tcp   tender_banana

To connect run:

    ./disque -p 49153 -h 192.168.59.103
