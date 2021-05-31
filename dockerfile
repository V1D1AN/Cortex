FROM thehiveproject/cortex:3.1.1-1

MAINTAINER V1D1AN

## MISE A JOUR ANALYZER

RUN cd /opt && rm -fr Cortex-Analyzers && git clone https://github.com/TheHive-Project/Cortex-Analyzers.git

## INSTALLATION PLUGINS

RUN apt-get update && apt-get install -y jq python3-pip
RUN pip3 install --upgrade pip 
RUN pip3 install wheel pefile
ADD ./Elasticsearch /opt/Cortex-Analyzers/analyzers/Elasticsearch
ADD ./OpenCTI /opt/Cortex-Analyzers/analyzers/OpenCTI
ADD ./NSRL/nsrl.py /opt/Cortex-Analyzers/analyzers/NSRL
ADD ./Reporter /opt/Cortex-Analyzers/responders/Reporter
RUN cd /opt/Cortex-Analyzers && for I in analyzers/*/requirements.txt; do pip3 install -U -r $I || true; done
RUN cd /opt/Cortex-Analyzers && for I in responders/*/requirements.txt; do pip3 install -U -r $I || true; done
RUN pip3 install mdutils==1.1.1 thehive4py==1.6.0
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
RUN dpkg -i ripgrep_11.0.2_amd64.deb
