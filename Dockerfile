FROM pymor/jupyter_py3.8:cd9560a74d7737af087f9c82c7c28a186ea2cdc6
MAINTAINER rene.fritze@wwu.de

RUN apt update && apt install unzip -y && rm -rf /var/cache/apt /var/lib/apt/lists/*

RUN cd /tmp && wget -q https://ngsolve.org/docu/latest/i-tutorials.zip \
 && unzip i-tutorials.zip && mkdir -p /pymor/ \
 && mv docs/html/jupyter-files/ /pymor/notebooks \
 && rm -rf /tmp/*

# binder wants to set the NB_ vars anyways, so we use it to service both setups
ARG NB_USER
ARG NB_UID
ARG PYMOR_JUPYTER_TOKEN

USER root
RUN useradd -d /home/pymor --shell /bin/bash -u ${NB_UID} -o -c "" -m ${NB_USER} && \
    chown -R ${NB_USER} /home/pymor /pymor/
USER ${NB_USER}

ENV JUPYTER_TOKEN=${PYMOR_JUPYTER_TOKEN} \
    USER=${NB_USER} \
    HOME=/home/pymor

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--ip", "0.0.0.0", "--no-browser", \
  "--notebook-dir=/pymor/notebooks", "--NotebookApp.disable_check_xsrf=True"]
WORKDIR /pymor/notebooks
