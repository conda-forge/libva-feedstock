set -ex

# https://01.org/linuxgraphics/documentation/build-guide-0
touch Makefile.am
touch */Makefile.am
touch */*/Makefile.am
touch configure.ac

./autogen.sh --prefix=$PREFIX

make -j${CPU_COUNT}
make install
