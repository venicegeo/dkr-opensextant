FROM openshift/base-centos7

# This image provides the Opensextant server

MAINTAINER geointservices.io <devops@nga.mil>

EXPOSE 8182

LABEL summary="Geointservices Opensextant" \
      io.k8s.description="Platform for running the Jupyter Hub with notebooks." \
      io.k8s.display-name="Geoint Services Jupyter" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="nodejs,nodejs4,python,python35,jupyterhub,jpyternotebook" 

ADD opensextant-toolbox-2.2.zip /opt/app-root/src
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root && \
    yum install -y centos-release-scl-rh && \
    INSTALL_PKGS="epel-release java-1.8.0-openjdk java-1.8.0-openjdk-devel ant apache-ivy" && \
    yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    pushd /opt/app-root/src && \
    #wget -O /opt/app-root/src/opensextant-toolbox-2.2.zip https://github.com/OpenSextant/OpenSextantToolbox/releases/download/v2.2/opensextant-toolbox-2.2.zip && \
    pushd /opt/app-root/src/ && \
    unzip opensextant-toolbox-2.2.zip && \
    rm opensextant-toolbox-2.2.zip && \
    popd

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER 1001

WORKDIR /opt/app-root/src/opensextant-toolbox-2.2
CMD java -Xmx8G -Dsolr.home=./solr -Dlog4j.configuration=file:./etc/log4j.properties -classpath ./lib/*:./lib/GATE/* org.opensextant.service.OpenSextantServer ./etc/service-config.properties

