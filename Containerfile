# 1. Base - Fedora 43
FROM quay.io/fedora/fedora-bootc:43

LABEL name="Rooftop Atomic OS"
LABEL version="43.1.0-studio"

# 2. Setup RPM Fusion (Non-free is essential for audio/video codecs)
RUN dnf install -y \
    dnf-plugins-core \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
	dnf clean all
# 3. Minimal GNOME installation (No bloatware)
RUN dnf install -y \
	gnome-shell \
	gdm \
	nautilus \
	gnome-control-center \
	gnome-terminal \
	gnome-system-monitor \
	mutter && \
	dnf clean all
# 3.1 GNOME plugins
# Раздел в доработке

# 4. Additional software
RUN dnf install -y \
	pipewire-utils \
	qpwgraph \
	pavucontrol \
	firefox gnome-extensions-app \
	celluloid && \
	dnf clean all
# 4.1 Multimedia & Codecs
RUN dnf install -y \
	mesa-va-drivers \
	mesa-vdpau-drivers \
    gstreamer1-plugins-ugly \
    gstreamer1-plugins-bad-free-extras \
    gstreamer1-plugins-bad-freeworld \
    gstreamer1-libav \
    gstreamer1-vaapi \
    ffmpeg \
    pipewire \
    pipewire-utils && \
	dnf clean all

# 5. Critical: Enable Login Manager and GUI boot
RUN systemctl enable gdm.service
RUN systemctl set-default graphical.target

# 6. Finish
RUN dnf install -y gnome-initial-setup
RUN systemctl enable initial-setup.service
RUN systemctl enable bootloader-update.service
RUN dnf clean all
