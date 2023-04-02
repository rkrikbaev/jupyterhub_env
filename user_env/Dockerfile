FROM jupyter/minimal-notebook:lab-3.6.2
# Replace `latest` with an image tag from to ensure reproducible builds:
# https://hub.docker.com/r/jupyter/minimal-notebook/tags/
# Inspect the Dockerfile at:
# https://github.com/jupyter/docker-stacks/tree/HEAD/minimal-notebook/Dockerfile

LABEL maintainer="Jupyter Project <rkrikbaev@gmail.com>"

ARG NB_USER="user"
ARG NB_UID="1001"
ARG NB_GID="101"

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

# install additional package...
RUN pip install --no-cache-dir astropy && \
    ipython==7.5.0 && \
    prophet==1.1 && \
    mlflow==1.24.0

# set the default command of the image,
# if you want to launch more complex startup than the default `juptyerhub-singleuser`.
# To launch an image's custom CMD instead of the default `jupyterhub-singleuser`
# set `singleuser.cmd: null` in your config.yaml.

WORKDIR "${HOME}"
