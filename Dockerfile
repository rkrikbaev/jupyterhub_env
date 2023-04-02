ARG JUPYTERHUB_VERSION=latest
FROM jupyterhub/jupyterhub:$JUPYTERHUB_VERSION

LABEL maintainer="Jupyter Project <rkrikbaev@gmail.com>"

ARG NB_USER="user"
ARG NB_UID="1001"
ARG NB_GID="101"

EXPOSE 8888

# Setup work directory for backward-compatibility
RUN mkdir "/home/${NB_USER}/work" && \
    fix-permissions "/home/${NB_USER}"

USER root

RUN apt-get update
RUN apt-get -y install \
    wget \
    git \
    libc-dev

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}

RUN python3 -m pip install --upgrade pip
RUN npm install -g configurable-http-proxy

# Install dockerspawner, nativeauthenticator
# hadolint ignore=DL3013
RUN python3 -m pip install --no-cache-dir \
    dockerspawner \
    jupyterhub-nativeauthenticator

RUN pip install ipython==7.5.0 \
    && prophet==1.1 \
    && mlflow==1.24.0

WORKDIR "${HOME}"
