FROM centos

RUN yum -y install epel-release
RUN yum -y install git epel-release nodejs npm && \ 
    git clone https://github.com/cubedro/eth-net-intelligence-api && \
    cd eth-net-intelligence-api && \
    npm install && \
    npm install -g pm2 

WORKDIR eth-net-intelligence-api

CMD ["pm2", "start", "app.json"]

