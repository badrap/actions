FROM google/cloud-sdk:alpine
RUN gcloud components install --quiet kubectl

ADD ["https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz", "/tmp/helm.tar.gz"]
ADD ["https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux", "/usr/local/bin/sops"]
RUN chmod u+x /usr/local/bin/sops \
  && tar xfv /tmp/helm.tar.gz -C /tmp \
  && mv /tmp/linux-amd64/helm /usr/local/bin \
  && rm -rf /tmp/helm.tar.gz /tmp/linux-amd64

WORKDIR /root
COPY . .
