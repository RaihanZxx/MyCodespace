FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    x11vnc \
    xvfb \
    wget \
    curl \
    unzip \
    git \
    openjdk-17-jdk \
    python3-pip \
    python3-venv \
    ca-certificates \
  && python3 -m venv /opt/websockify-venv \
  && /opt/websockify-venv/bin/pip install --no-cache-dir websockify==0.13.0 \
  && git clone https://github.com/novnc/noVNC.git /opt/novnc \
  && git clone https://github.com/novnc/websockify /opt/websockify \
  && ln -s /opt/websockify /opt/novnc/utils/websockify || true \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY novnc-index.html /opt/novnc/index.html

ENV PATH="/opt/websockify-venv/bin:/opt/novnc:$PATH"
