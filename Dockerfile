FROM python:3.10-alpine3.15
LABEL maintainer="spax97.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN /usr/local/bin/pip install --upgrade pip && \
    /usr/local/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /usr/local/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        -D \
        -H \
        django-user

USER django-user

