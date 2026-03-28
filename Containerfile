# 1. BASE: Using the official bootable engine
FROM quay.io/fedora/fedora-bootc:44

# 2. METADATA
LABEL name="Rooftop-Atomic-OS"
LABEL vendor="Rooftop Studio"
LABEL version="44.2026.1"

# 3. INSTALLING THE ACTUAL SILVERBLUE CORE
# This group contains exactly what you find in a fresh Silverblue install
RUN dnf group install -y "Fedora Workstation"

# 4. STUDIO ADD-ONS (Your personal touch)
# Adding RPM Fusion for codecs and sound tools
RUN dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    dnf install -y qpwgraph pavucontrol gnome-extensions-app

# 5. ENABLING THE DESKTOP
RUN systemctl set-default graphical.target

# 6. CLEANUP
RUN dnf clean all
