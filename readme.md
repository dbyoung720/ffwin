ffwin
=============
# Building a compiled open-source source code system using Scoop + VS2022
- [中文](readmeCN.md)

## Primary condition:
* VS2022 must be installed first; 
* Scoop  must be installed first;

## Instructions for use:
* Before executing zx86.cmd / zx64.cmd, it is necessary to configure the network proxy: proxy.cmd; 
* Double click zx86.cmd / zx64.cmd to start compiling the source code; 
* Compile source code using cmake. The VC sln project file will be generated in the directory vs2022\vsbuild; 
* Compiled is a vs2022 MT type static library; 

### Catalog Description:
* Vs2022\source : Store the source code directory; 
* Vs2022\vsbuild: vs2022 compiles temporary directory; 
* Vs2022\vssdk  : vs2022 sdk installation directory; 

### Development Description:
*  blog : https://blog.csdn.net/dbyoung/article/details/142689195?spm=1001.2014.3001.5502
