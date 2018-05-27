FROM centos

RUN yum -y install epel-release
RUN yum -y install git epel-release nodejs npm && \ 
	git clone https://github.com/cubedro/eth-netstats && \
    cd eth-netstats && \
    npm install && \
    npm install -g grunt-cli && \
    grunt all

WORKDIR eth-netstats

EXPOSE 3000

CMD ["npm", "start"]
