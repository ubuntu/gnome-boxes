#! /bin/sh

cleanup() {
    [ -e "$XDG_RUNTIME_DIR"/libvirt.pid ] && pkill -F "$XDG_RUNTIME_DIR"/libvirt.pid
    [ -e "$XDG_RUNTIME_DIR"/virtlogd.pid ] && pkill -F "$XDG_RUNTIME_DIR"/virtlogd.pid
}

trap 'cleanup' EXIT HUP INT QUIT TERM

export HOME="/home/$USER/snap/$SNAP_NAME/current"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SNAP/usr/lib/$SNAP_LAUNCHER_ARCH_TRIPLET/ceph:$SNAP/usr/lib:$SNAP/lib:$SNAP/lib/$SNAP_LAUNCHER_ARCH_TRIPLET:$SNAP/usr/lib/$SNAP_LAUNCHER_ARCH_TRIPLET"

echo Launching libvirtd
libvirtd -d -p "$XDG_RUNTIME_DIR"/libvirt.pid

echo Launching virtlogd
virtlogd -d -p "$XDG_RUNTIME_DIR"/virtlogd.pid

"$@"
