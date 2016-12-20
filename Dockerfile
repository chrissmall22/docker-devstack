# Dockerfile for DevStack
# http://docs.openstack.org/developer/devstack/

FROM centos:7

MAINTAINER Tuan Vo <vohungtuan@gmail.com>


# Install yum tools
RUN set -x \
    && yum install -y redhat-lsb-core epel-release iproute python-pip git \
    && yum groupinstall -y "Development Tools" --skip-broken \
    && yum update -y



# Add Stack User
# Download DevStack

RUN set -x \
    && adduser stack \
    && echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && su stack \
    && cd /home/stack \
    && git clone https://git.openstack.org/openstack-dev/devstack

USER stack

WORKDIR /home/stack/devstack

# Create a local.conf file
# with 4 passwords preset at the root of the devstack git repo.

COPY local.conf /

# Start the install

RUN set -x \
    && ./stack.sh

# Copy entrypoint file

COPY docker-entrypoint.sh /

RUN set -x \
 && chmod +x /docker-entrypoint.sh

 
EXPOSE 80
EXPOSE 5000
 
# Setup the ENV
# https://docs.docker.com/engine/reference/builder/#run

ENTRYPOINT ["/docker-entrypoint.sh"]

# CMD []

# Remove tmp
RUN find /opt/tmp/ -type f | xargs -L1 rm -f