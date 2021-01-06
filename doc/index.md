
- [Linux 基础知识](#base)                   
  - [Linux 启动过程](#startup)              
- [文件](./file.md)     
- [loop设备](./lodevice.md)                            
- [Linux 分区](./partition.md)         


## <a id="base">Linux 基础知识</a>

### <a id="startup">Linux 启动过程</a>
1. 读取 MBR 的信息,启动 Boot Manager。Windows 使用 NTLDR 作为 Boot Manager,如果您的系统中安装多个版本的 Windows,您就需要在 NTLDR 中选择您要进入的系统。Linux 通常使用功能强大,配置灵活的 GRUB 作为 Boot Manager。
2. 加载系统内核,启动 init 进程。init 进程是 Linux 的根进程,所有的系统进程都是它的子进程。
3. init 进程读取 /etc/inittab 文件中的信息,并进入预设的运行级别,按顺序运行该运行级别对应文件夹下的脚本。脚本通常以 start 参数启动,并指向一个系统中的程序。通常情况下, /etc/rcS.d/ 目录下的启动脚本首先被执行,然后是/etc/rcN.d/ 目录。例如您设定的运行级别为 3,那么它对应的启动目录为 /etc/rc3.d/ 。
4. 根据 /etc/rcS.d/ 文件夹中对应的脚本启动 Xwindow 服务器 xorg。Xwindow 为 Linux 下的图形用户界面系统。
5. 启动登录管理器,等待用户登录。Ubuntu 系统默认使用 GDM 作为登录管理器,您在登录管理器界面中输入用户名和密码后,便可以登录系统。(您可以在 /etc/rc3.d/ 文件夹中找到一个名为 S13gdm 的链接)

#### Login shells 与 Nonlogin shells 执行过程

Login shells

    /etc/profile
        /etc/profile.d
    ~/.bash_profile
        ~/.bashrc
            /etc/bashrc

Non-login shells

        ~/.bashrc
            /etc/bashrc
                /etc/profile.d

.bash_logout 在每次登陆shell退出时被读取并执行。

#### linux 中变量的含义

* $# 是传给脚本的参数个数
* $0 是脚本本身的名字
* $1 是传递给该shell脚本的第一个参数
* $2 是传递给该shell脚本的第二个参数
* $@ 是传给脚本的所有参数的列表
* $* 是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个
* $$ 是脚本运行的当前进程ID号
* $? 是显示最后命令的退出状态，0表示没有错误，其他表示有错误


sudo 免密码    
```shell
your_user_name ALL=(ALL) NOPASSWD: ALL
```
注意： 有的时候你的将用户设了nopasswd，但是不起作用，原因是被后面的group的设置覆盖了，需要把group的设置也改为nopasswd。

su 免密码

切换到root权限，创建group为wheel，`groupadd wheel`，将用户加入wheel group中，命令为`usermod -G wheel your_user_name`，修改su的配置文件/etc/pam.d/su,增加下列项：
```shell
auth       required   pam_wheel.so group=wheel 
# Uncomment this if you want wheel members to be able to
# su without a password.
auth       sufficient pam_wheel.so trust use_uid
```

SHLVL 是记录多个 Bash 进程实例嵌套深度的累加器，而 BASH_SUBSHELL 是记录一个 Bash 进程实例中多个子 Shell（subshell）嵌套深度的累加器。

[SHLVL 和 BASH_SUBSHELL 两个变量的区别](https://www.cnblogs.com/ziyunfei/p/4803832.html)           

***


***
## Linux 源码安装
这些都是典型的使用 GNU 的 AUTOCONF 和 AUTOMAKE 产生的程序的安装步骤。

***
## initrd和initramfs的区别
首先要介绍 `kernel` 启动 init 的两种方案。
* 第一种是 ramdisk，就是把一块内存（ram）当做磁盘（disk）去挂载，然后找到ram里的init进行执行。
* 第二种是 ramfs，直接在ram上挂载文件系统，执行文件系统中的init。

initrd（init ramdisk）就是ramdisk的实现，initramfs就是ramfs的实现。
> Note：tmpfs，是ramfs的增强版方案。rootfs，是ramfs/tmpfs的一个特殊实例。

所以initramfs也可以是tmpfs/rootfs的实现。


kernel 2.6 以来都是 initramfs 了，只是很多还沿袭传统使用 initrd 的名字。

initramfs 的工作方式更加简单直接一些，启动的时候加载内核和 initramfs 到内存执行，内核初始化之后，切换到用户态执行 initramfs 的程序/脚本，加载需要的驱动模块、必要配置等，然后加载 rootfs 切换到真正的 rootfs 上去执行后续的 init 过程。

initrd 是2.4 及更早的用法（现在你能见到的 initrd 文件实际差不多都是 initramfs 了），运行过程大概是内核启动，执行一些 initrd 的内容，加载模块啥的，然后交回控制权给内核，最后再切到用户态去运行用户态的启动流程。

从格式看，老的 initrd 是一个压缩的内存文件系统。现在的 initramfs 是一个 gzip 压缩的 cpio 文件系统打包，如果遇到什么紧急情况需要处理的时候，你可以建立一个临时目录，把 initramfs 解压之后，直接 cpio -idv 解压出来，改之后再用 cpio 和 gzip 封上即可。虽然大家都喜欢用 tar 打包，但掌握点 cpio 在关键时刻还是可以救命的。

***


## 常见问题
* error: watch ENOSPC     

Run the below command:      

    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


* linux ssh 配置取消禁止root用户直接登陆
打开文件

    etc/ssh/sshd_config
    设置
    PermitRootLogin no
    重启sshd服务
    sservice sshd restart


