mkdir build
cd build

meson setup %MESON_ARGS% ..

ninja
ninja install
