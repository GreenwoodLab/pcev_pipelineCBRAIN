FROM centos

MAINTAINER Natacha Beck <natacha.beck@mcgill.ca>

# Install prerequisite
RUN yum update  -y

COPY . pcev_CBRAIN

# Install basic packages
RUN yum install -y unzip \
                   wget \
                   epel-release \
                   java-1.8.0-openjdk-headless 


RUN yum install -y  R

# Install all other R packages
RUN echo 'install.packages(c("pcev"), repos= "http://cran.us.r-project.org")' > /tmp/packages.R
RUN Rscript /tmp/packages.R


RUN chmod 755 pcev_CBRAIN/run_pcevCBRAIN.sh \
                    && cp pcev_CBRAIN/run_pcevCBRAIN.sh /bin/
                    
RUN chmod 755 pcev_CBRAIN/reportRedaction.sh \
                    && cp pcev_CBRAIN/reportRedaction.sh /bin/

RUN chmod 755 pcev_CBRAIN/pcev_for_cbrain.R \
                   && cp pcev_CBRAIN/pcev_for_cbrain.R /bin/


WORKDIR /pcev_CBRAIN/                    
                    
