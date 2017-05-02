FROM centos:6.6

MAINTAINER Marie Forest <marie.forest@ladydavis.ca>
MAINTAINER Natacha Beck <natabeck@gmail.com>

# Install prerequisite
RUN yum update  -y

# Install basic packages
RUN yum install -y gcc \
                   perl \
                   make \
                   autoconf \
                   automake \
                   gcc-gfortran \
                   compat-gcc-34-g77.x86_64 \
                   wget \
                   tar \
                   gcc-c++ \
                   readline-devel \
                   libXt-devel \
                   java-1.8.0-openjdk-devel \
                   which \
                   git \
                   libcurl libcurl-devel \
                   openssl-devel \
                   libxml2-devel \
                   libpng-devel \
                   mesa-libGLU-devel.x86_64 \
                   texlive-latex \
                   pango \
                   pango-devel \
		   libX11-devel \
                   libxt-dev


# Install R-3.3.2
RUN wget http://cran.r-project.org/src/base/R-3/R-3.3.2.tar.gz; tar -zxvf R-3.2.0.tar.gz; cd R-3.3.2; ./configure; make; cp /R-3.3.2/bin/R /bin/; cp /R-3.3.2/bin/Rscript /bin/

# Install all other R packages
RUN echo 'install.packages(c("stats", "RMTstat", "pcev"), repos= "http://cran.us.r-project.org")' > /tmp/packages.R
RUN Rscript /tmp/packages.R

