# 1. Base - Fedora 43
FROM quay.io/fedora/fedora-bootc:43

LABEL name="Rooftop Atomic OS"
LABEL version="43.1.0-studio"

# 2. Setup RPM Fusion (Non-free is essential for audio/video codecs)
RUN dnf install -y \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-43.noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-43.noarch.rpm \
	fedora-repos-openh264 && \
	dnf config-manager --set-enabled fedora-cisco-openh264 && \
dnf clean all

# 3. Minimal GNOME installation (No bloatware)
RUN dnf install -y \
	gnome-shell \
	gdm \
	nautilus \
	gnome-control-center \
	gnome-terminal \
	gnome-system-monitor \
	mutter
	
# 3.1 GNOME plugins
# Раздел в доработке

# 4. Additional software
RUN dnf install -y \
	pipewire-utils \
	qpwgraph \
	pavucontrol \
	firefox gnome-extensions-app \
	celluloid
# 4.1 Multimedia & Codecs (The "Must-Have" for Studio)
RUN dnf install -y \
    gstreamer1-plugins-ugly \
    gstreamer1-plugins-bad-free-extras \
    gstreamer1-plugins-bad-freeworld gstreamer1-plugins-libav \
    gstreamer1-vaapi \
    # FFmpeg full version (overwrites the stripped-down Fedora version)
    ffmpeg-devel \
    ffmpeg \
    # OpenH264
    gstreamer1-plugin-openh264 \
    mozilla-openh264
# 5. Critical: Enable Login Manager and GUI boot
RUN systemctl enable gdm.service
RUN systemctl set-default graphical.target

# 6. Cleanup
RUN dnf clean all
