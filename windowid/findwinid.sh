xwininfo -name "VLC media player" | grep "Window id: 0x" | sed 's/ /\n/g' | grep 0x > vlcwindow.id
