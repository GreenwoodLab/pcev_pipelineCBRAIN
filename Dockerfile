FROM centos

MAINTAINER Marie Forest <marie.forest@ladydavis.ca>

# Install prerequisite
RUN yum update  -y

COPY . pcevCBRAIN

# Install basic packages
RUN yum install -y unzip \
                   wget \
                   epel-release \
                   java-1.8.0-openjdk-headless 


#RUN yum install -y  R

# Install all other R packages
#RUN echo 'install.packages(c("pcev"), repos= "http://cran.us.r-project.org")' > /tmp/packages.R
#RUN Rscript /tmp/packages.R

RUN ls
#RUN chmod 755 /pcevCBRAIN/run_pcevCBRAIN.sh \
#                    && cp /pcevCBRAIN/run_pcevCBRAIN.sh /bin/