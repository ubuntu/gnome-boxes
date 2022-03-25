#! /bin/sh

cleanup() {
    [ -e /tmp/libvirt.pid ] && pkill -F /tmp/libvirt.pid
    [ -e /tmp/virtlogd.pid ] && pkill -F /tmp/virtlogd.pid
}

trap 'cleanup' EXIT HUP INT QUIT TERM

export HOME="/home/$USER/snap/$SNAP_NAME/current"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/bin:$PATH"

libvirtd -d -p /tmp/libvirt.pid
virtlogd -d -p /tmp/virtlogd.pid

"$@"
