FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && apt install -y \
  adwaita-icon-theme \
  gnome-themes-extra \
  gtk2-engines \
  libcanberra-gtk-module \
  libcanberra-gtk3-module \
  libgtk-3-0 \
  libx11-6 \
  libxext6 \
  libxrender1 \
  libglib2.0-0 \
  libsm6 \
  libice6 \
  x11-apps \
  software-properties-common \
  lsb-release \
  locales \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-libav \
  libgstreamer1.0-0 \
  libgstreamer-plugins-base1.0-0 \
  gstreamer1.0-tools \
  alsa-utils \
  libasound2t64 \
  pipewire 

RUN locale-gen en_GB.UTF-8 \
       && update-locale LANG=en_GB.UTF-8
# Add Anycubic Slicer Next APT repository
RUN echo "deb [trusted=yes] https://cdn-universe-slicer.anycubic.com/prod $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/acnext.list

RUN apt update && apt install -y anycubicslicernext

# Add entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

