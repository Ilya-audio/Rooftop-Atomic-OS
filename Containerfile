# Use the latest Fedora 44 bootc image as base
FROM quay.io/fedora/fedora-bootc:44

# System Metadata
LABEL name="Rooftop Atomic OS"
LABEL version="44.0.0"

RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-44.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-44.noarch.rpm

dnf install -y @workstation-product @gnome-desktop

RUN dnf install -y pipewire-utils qpwgraph pavucontrol

RUN dnf clean all
