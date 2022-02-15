FROM ubuntu:focal
ARG SOPS_VERSION=v3.7.1

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq bash \
                curl  git unzip \
                jq postgresql-client \
                openssh-client openssl \
	            telnet wget \
    &&  mkdir /certs \
    &&  chmod 700 /certs \
    && curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux \
    && chmod +x /usr/local/bin/sops \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && curl -o terraform.zip -L https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip \
    && unzip terraform.zip \
    && cp "terraform" /usr/local/bin/terraform \
    && rm -rf terraform.zip \
    && chmod +x /usr/local/bin/terraform \
    && apt-get clean && rm -rf /var/lib/apt/lists
