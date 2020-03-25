FROM ubuntu:16.04
ADD . /ubuntu/
ARG mirror
RUN set -xue; \
      sed -i 's#archive.ubuntu.com#'${mirror:=archive.ubuntu.com}'#g' /etc/apt/sources.list; \
      sed -i 's#security.ubuntu.com#'${mirror:=archive.ubuntu.com}'#g' /etc/apt/sources.list; \
      apt-get clean all && apt-get update --fix-missing && apt-get -y --no-install-recommends install \
         aptitude \
         apt-file \
         dnsutils \
         iputils-ping \
         netcat-openbsd \
         net-tools \
         telnet \
         git \
         curl \
         wget \
         unzip \
         less \
         vim \
         tree \
         lsof \
         strace \
         openssh-server \
         mysql-client \
         nginx \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/dpkg/info/* \
    && rm -rf /usr/share/{GeoIP,X11,doc,fonts,man}/* \ 
    && find / -type f -name *-old -delete 
EXPOSE 22 80
ENTRYPOINT ["/ubuntu/docker-entrypoint.sh"]
CMD [""]
