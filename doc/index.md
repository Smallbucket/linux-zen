
- [Linux 基础知识](#base)                   
  - [Linux 启动过程](#startup)            
  - [Login shells 与 Nonlogin shells 执行过程](#base_shell)          
  - [linux 中变量的含义](#base_var)          
  - [cat <<[-]EOF 的含义](#base_eof)         
  - [initrd 和 initramfs 的区别](#base_initrd)              
  - [su 和 sudo](#base_su)          
- [Linux 基本目录规范(XDG)](#xdg)             
- [文件](./file.md)     
- [loop设备](./lodevice.md)                            
- [Linux 分区](./partition.md)         


# <a id="base">Linux 基础知识</a>

## <a id="startup">Linux 启动过程</a>
1. 读取 MBR 的信息,启动 Boot Manager。Windows 使用 NTLDR 作为 Boot Manager,如果您的系统中安装多个版本的 Windows,您就需要在 NTLDR 中选择您要进入的系统。Linux 通常使用功能强大,配置灵活的 GRUB 作为 Boot Manager。
2. 加载系统内核,启动 init 进程。init 进程是 Linux 的根进程,所有的系统进程都是它的子进程。
3. init 进程读取 /etc/inittab 文件中的信息,并进入预设的运行级别,按顺序运行该运行级别对应文件夹下的脚本。脚本通常以 start 参数启动,并指向一个系统中的程序。通常情况下, /etc/rcS.d/ 目录下的启动脚本首先被执行,然后是/etc/rcN.d/ 目录。例如您设定的运行级别为 3,那么它对应的启动目录为 /etc/rc3.d/ 。
4. 根据 /etc/rcS.d/ 文件夹中对应的脚本启动 Xwindow 服务器 xorg。Xwindow 为 Linux 下的图形用户界面系统。
5. 启动登录管理器,等待用户登录。Ubuntu 系统默认使用 GDM 作为登录管理器,您在登录管理器界面中输入用户名和密码后,便可以登录系统。(您可以在 /etc/rc3.d/ 文件夹中找到一个名为 S13gdm 的链接)

### <a id="base_shell">Login shells 与 Nonlogin shells 执行过程</a>

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

### <a id="base_var">linux 中变量的含义</a>

* $# 是传给脚本的参数个数
* $0 是脚本本身的名字
* $1 是传递给该shell脚本的第一个参数
* $2 是传递给该shell脚本的第二个参数
* $@ 是传给脚本的所有参数的列表
* $* 是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个
* $$ 是脚本运行的当前进程ID号
* $? 是显示最后命令的退出状态，0表示没有错误，其他表示有错误

SHLVL 是记录多个 Bash 进程实例嵌套深度的累加器，而 BASH_SUBSHELL 是记录一个 Bash 进程实例中多个子 Shell（subshell）嵌套深度的累加器。

[SHLVL 和 BASH_SUBSHELL 两个变量的区别](https://www.cnblogs.com/ziyunfei/p/4803832.html)           


### <a id="base_eof">cat <<[-]EOF 的含义</a>
这称为heredoc格式，用于将字符串提供给stdin。

从 `man bash` 中摘录：

**Here Documents**                     

This type of redirection instructs the shell to read input from the current source until a line containing only word (with no trailing blanks) is seen.

All of the lines read up to that point are then used as the standard input for a command.

The format of here-documents is:

          <<[-]word
                  here-document
          delimiter
No parameter expansion, command substitution, arithmetic expansion, or pathname expansion is performed on word. If any characters in word are quoted, the delimiter is the result of quote removal on word, and the lines in the here-document are not expanded. If word is unquoted, all lines of the here-document are subjected to parameter expansion, command substitution, and arithmetic expansion. In the latter case, the character sequence \<newline> is ignored, and \ must be used to quote the characters \, $, and \`.

If the redirection operator is <<-, then all leading tab characters are stripped from input lines and the line containing delimiter. This allows here-documents within shell scripts to be indented in a natural fashion.

**使用示例:**

Assign multi-line string to a shell variable

    $ sql=$(cat <<EOF
    SELECT foo, bar FROM db
    WHERE foo='baz'
    EOF
    )
The `$sql` variable now holds the new-line characters too. You can verify with `echo -e "$sql"`.

Pass multi-line string to a file in Bash

    $ cat <<EOF > print.sh
    #!/bin/bash
    echo \$PWD
    echo $PWD
    EOF
The `print.sh` file now contains:

    #!/bin/bash
    echo $PWD
    echo /home/user

Pass multi-line string to a pipe in Bash

    $ cat <<EOF | grep 'b' | tee b.txt
    foo
    bar
    baz
    EOF
The *`b.txt`* file contains *`bar`* and *`baz`* lines. The same output is printed to *`stdout`*.

### <a id="base_initrd">initrd 和 initramfs 的区别</a>
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


### <a id="base_su">su 和 sudo</a>
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

## <a id="xdg">Linux 基本目录规范 XDG</a>
XDG 基准目录规范（X Desktop Group Base Directory Specification）的目的就是为了解决主目录下被各种. 文件/文件夹（dotfiles）这类的隐藏文件充斥的问题。

该规范定义了一套指向应用程序的环境变量，这些变量指明的就是这些程序应该存储的基准目录。而变量的具体值取决于用户，若用户未指定，将由程序本身指向一个默认目录，该默认目录也应该遵从标准，而不是用户主目录。

### 环境变量清单：用户层面变量（User-Level Variables）
#### $XDG_DATA_HOME
`$XDG_DATA_HOME` 定义了应存储用户特定的数据文件的基准目录。默认值是 `$HOME/.local/share`。

使用场景：

* 用户下载的插件；
* 程序产生的数据库；
* 用户输入历史、书签、邮件等。

#### $XDG_CONFIG_HOME
`$XDG_CONFIG_HOME` 定义了应存储用户特定的配置文件的基准目录。默认值是 `$HOME/.config`。

使用场景：

* 用户配置。
> 一般来说，这个地方可以在程序初始化的时候存储一个默认的配置文件供加载和修改。

#### $XDG_CACHE_HOME
`$XDG_CACHE_HOME` 定义了应存储用户特定的非重要性数据文件的基准目录。默认值是 `$HOME/.cache`。

使用场景：

* 缓存的缩略图、歌曲文件、视频文件等。
> 程序应该做到哪怕这个目录被用户删了也能正常运行。

#### $XDG_RUNTIME_DIR
`$XDG_RUNTIME_DIR` 定义了应存储用户特定的非重要性运行时文件和一些其他文件对象。

使用场景：

* 套接字 (socket)、命名管道 (named pipes) 等。
> 该目录必须由用户拥有，并且该用户必须是唯一具有读写访问权限的。 目录的 Unix 访问模式必须是 0700。

### 环境变量清单：系统层面变量（System-Level Variables）
#### $XDG_CONFIG_DIRS
`$XDG_CONFIG_DIRS` 定义了一套按照偏好顺序的基准目录集，用来搜索除了 `$XDG_CONFIG_HOME` 目录之外的配置文件。该目录中的文件夹应该用冒号（:）隔开。默认值是 `/etc/xdg`。

使用场景：

* 可以被用户特定的配置文件所覆盖的系统层面的配置文件。
> 一般来说，应用程序安装的时候可以加载配置文件到这个目录。

#### $XDG_DATA_DIRS
`$XDG_DATA_DIRS` 定义了一套按照偏好顺序的基准目录集，用来搜索除了 `$XDG_DATA_HOME` 目录之外的数据文件。该目录中的文件夹应该用冒号（:）隔开。默认值是 `/usr/local/share/:/usr/share/`。

使用场景：

* 可以被所有用户使用的插件或者主题。
> 一般来说，应用程序安装的时候可以加载插件、主题等文件到这个目录。

### 参考资料：
[消灭泛滥的点文件：XDG 基准目录规范](https://songkeys.github.io/posts/xdc-spec/)           


## 服务
### rsync
rsync 是一款开源的、快速的、多功能的、可实现全量及增量的本地或远程数据同步备份的优秀工具。默认使用873端口


## Linux 源码安装
这些都是典型的使用 GNU 的 AUTOCONF 和 AUTOMAKE 产生的程序的安装步骤。


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


