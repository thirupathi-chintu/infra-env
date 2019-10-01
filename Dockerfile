# Setup build arguments with default versions
ARG AWS_CLI_VERSION=1.16.177
ARG TERRAFORM_VERSION=0.12.4

# Download Terraform binary
FROM alpine:3.9.4 as terraform
MAINTAINER Peraboina Thirupathi <thirupathiperaboina@gmail.com>
ARG TERRAFORM_VERSION
RUN apk update
RUN apk add curl=7.64.0-r2
RUN apk add unzip=6.0-r4
RUN apk add tar
RUN curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip -j terraform_${TERRAFORM_VERSION}_linux_amd64.zip


# Install AWS CLI using PIP
FROM alpine:3.9.4 as aws-cli
ARG AWS_CLI_VERSION
RUN apk update
RUN apk add python3=3.6.8-r2
RUN apk add python3-dev=3.6.8-r2
RUN apk add py3-setuptools=40.6.3-r0
RUN pip3 install awscli==${AWS_CLI_VERSION}

# Build final image
FROM alpine:3.9.4
RUN apk --no-cache add \
  bash=4.4.19-r1 \
  ca-certificates=20190108-r0 \
  groff=1.22.3-r2 \
  jq=1.6-r0 \
  ansible \
  python3=3.6.8-r2 \
  && ln -s /usr/bin/python3 /usr/bin/python
COPY --from=terraform /terraform /usr/bin/terraform
COPY --from=aws-cli /usr/bin/aws* /usr/bin/
COPY --from=aws-cli /usr/lib/python3.6/site-packages /usr/lib/python3.6/site-packages
WORKDIR /workspace
CMD ["bash"]
