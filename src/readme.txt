1：libmfx 必须修改版本号；
2：ffnvcodec 必须和 cuda 版本对应；ffnvcodec 版本不得低于 cuda sdk 版本；
3：zlib zonf.h unistd.h
4：sdl2 关闭自动侦测
5：lzma (xz) 手动复制 liblzma.pc, 静态编译 --extra-cflags=-DLZMA_API_STATIC
