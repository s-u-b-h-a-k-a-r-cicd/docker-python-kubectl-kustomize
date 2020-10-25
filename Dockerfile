  
FROM debian:buster

ARG VCS_REF
ARG BUILD_DATE
ENV KUSTOMIZE_VER 3.8.2
ENV KUBECTL_VER 1.19.3

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="python-kubectl-kustomize" \
      org.label-schema.url="https://hub.docker.com/r/subhakarkotta/python-kubectl-kustomize/" \
      org.label-schema.vcs-url="https://github.com/subhakarkotta/docker-python-kubectl-kustomize" \
      org.label-schema.build-date=$BUILD_DATE


RUN apt-get update
RUN apt-get install --yes curl
RUN apt-get install --yes python3 python3-nbformat python3-nbconvert python3-ipykernel
RUN apt-get install --yes python3-requests python3-xmltodict python3-yaml
RUN apt-get install --yes jupyter-core jupyter-nbconvert

RUN apt-get install --yes git vim nano

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl
      
RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VER}/kustomize_${KUSTOMIZE_VER}_linux_amd64  -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize


ENTRYPOINT ["/bin/bash"]