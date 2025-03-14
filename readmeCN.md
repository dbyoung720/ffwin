ffwin
=============
# 使用 scoop + vs2022 打造编译开源源代码系统
- [English](readme.md)

## 首要条件：
* vs2022 必须首先安装好.
* scoop  必须首先安装好；

## 使用说明：
* 执行 zx86.cmd / zx64.cmd 前，必须配置网络代理：proxy.cmd.
* 双击 zx86.cmd / zx64.cmd, 开始编译源代码.  
* 使用 cmake 编译源代码。在目录 vs2022\vsbuild 下会生成 vc sln 工程文件.
* 编译的是 vs2022 MT 类型静态库；

### 目录说明：
* vs2022\source  : 存放源代码目录.
* vs2022\vsbuild : vs2022 编译临时目录.
* vs2022\vssdk   : vs2022 sdk 安装目录.

### 开发说明：
* 博客地址：https://blog.csdn.net/dbyoung/article/details/142689195?spm=1001.2014.3001.5502
