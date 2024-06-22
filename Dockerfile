# Build Runner
FROM --platform=linux/x86_64 ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget
COPY ./linux/routerd.tar.gz .

RUN wget https://raw.githubusercontent.com/router-protocol/routerd-libs/main/libwasmvm.x86_64.so
RUN cp libwasmvm.x86_64.so /lib
RUN cp libwasmvm.x86_64.so /lib64

RUN tar -xvf routerd.tar.gz -C /usr/bin
RUN chmod +x /usr/bin/routerd
RUN which routerd

ENV HOME /router
WORKDIR $HOME
EXPOSE 26656 26657 1317 1318 9090 9091

RUN apt-get remove -y wget bash --allow-remove-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.ssh && \
    rm /bin/sh

ENTRYPOINT ["routerd"]