{pkgs}:
with pkgs; [
  # List by default
  zlib
  zstd
  stdenv.cc.cc
  curl
  openssl
  attr
  libssh
  bzip2
  libxml2
  acl
  libsodium
  util-linux
  xz
  systemd

  # My own additions
  xorg.libXcomposite
  xorg.libXtst
  xorg.libXrandr
  xorg.libXext
  xorg.libX11
  xorg.libXfixes
  libGL
  libva
  pipewire
  xorg.libxcb
  xorg.libXdamage
  xorg.libxshmfence
  xorg.libXxf86vm
  libelf

  # Required
  glib
  gtk2

  # Inspired by steam
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
  networkmanager
  vulkan-loader
  libgbm
  libdrm
  libxcrypt
  coreutils
  pciutils
  zenity
  # glibc_multi.bin # Seems to cause issue in ARM

  # Without these it silently fails
  xorg.libXinerama
  xorg.libXcursor
  xorg.libXrender
  xorg.libXScrnSaver
  xorg.libXi
  xorg.libSM
  xorg.libICE
  gnome2.GConf
  nspr
  nss
  cups
  libcap
  SDL2
  libusb1
  dbus-glib
  ffmpeg
  # Only libraries are needed from those two
  libudev0-shim

  # needed to run unity
  gtk3
  icu
  libnotify
  gsettings-desktop-schemas

  # Verified games requirements
  xorg.libXt
  xorg.libXmu
  libogg
  libvorbis
  SDL
  SDL2_image
  glew110
  libidn
  tbb

  # Other things from runtime
  flac
  freeglut
  libjpeg
  libpng
  libpng12
  libsamplerate
  libmikmod
  libtheora
  libtiff
  pixman
  speex
  SDL_image
  SDL_ttf
  SDL_mixer
  SDL2_ttf
  SDL2_mixer
  libappindicator-gtk2
  libdbusmenu-gtk2
  libindicator-gtk2
  libcaca
  libcanberra
  libgcrypt
  libvpx
  librsvg
  xorg.libXft
  libvdpau
  # Some more libraries that I needed to run programs
  pango
  cairo
  atk
  gdk-pixbuf
  fontconfig
  freetype
  dbus
  alsa-lib
  expat
  # for blender
  libxkbcommon

  libxcrypt-legacy # For natron
  libGLU # For natron

  # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
  fuse
  e2fsprogs

  libkrb5
  krb5

  pavucontrol
  libjack2
  jack2
  qjackctl
  jack_capture
  nss_latest
  alsa-plugins
  libpulseaudio
  libtirpc
  pulseaudio

  winetricks
]
