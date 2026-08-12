FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:7986f2815ec33958bb6e4d96bfce60446bcda0b81faa1baa88f0d94a2cdc72c9 https://github.com/podman-desktop/podman-desktop/releases/download/v1.29.1/podman-desktop-1.29.1-x64.tar.gz /tmp/source
COPY icon.png /usr/share/icons/hicolor/128x128/apps/podman-desktop.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libgtk-3-0 libnss3 && \
    mkdir -p /opt/podman-desktop && tar -xzf /tmp/source --strip-components=1 -C /opt/podman-desktop && ln -s /opt/podman-desktop/podman-desktop /usr/bin/podman-desktop && printf '[Desktop Entry]\nName=Podman Desktop\nExec=podman-desktop %%U\nIcon=podman-desktop\nType=Application\nCategories=Development;System;\n' > /usr/share/applications/io.podman_desktop.PodmanDesktop.desktop && \
    cpak-clean-junk
