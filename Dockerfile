# Container image that runs your code
#FROM alpine:3.10
FROM python

# Install checkov
RUN pip install -U checkov

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY problem-matcher.json /usr/local/lib/problem-matcher.json

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
