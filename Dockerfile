FROM --platform=linux/amd64 hashicorp/tfc-agent:latest

USER root

ADD ./tfe_root.crt /usr/local/share/ca-certificates/tfe_root.crt
ADD ./tfe-no-root.crt /usr/local/share/ca-certificates/tfe-no-root.crt
RUN chmod 644 /usr/local/share/ca-certificates/tfe_root.crt /usr/local/share/ca-certificates/tfe-no-root.crt && update-ca-certificates

RUN mkdir /.tfc-agent && \
    chmod 770 /.tfc-agent

RUN apt-get update && \
    apt-get install -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER tfc-agent