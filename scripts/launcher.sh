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
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SNAP/usr/lib/x86_64-linux-gnu/ceph:$SNAP/usr/lib:$SNAP/lib:$SNAP/lib/x86_64-linux-gnu:$SNAP/usr/lib/x86_64-linux-gnu"

echo Launching libvirtd
libvirtd -d -p /tmp/libvirt.pid

echo Launching virtlogd
virtlogd -d -p /tmp/virtlogd.pid

"$@"
