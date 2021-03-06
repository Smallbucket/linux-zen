
# Debian/Ubuntu 使用
               
- [安装命令](#install_command)       
  - [deb 包安装方法](#command_deb)       
  - [apt 系统命令](#command_apt)               
  - [aptitude 命令](#command_aptitude)          
  - [列出上已安装的软件包](#command_list)          
- [系统服务](#service)            
- [Grub](#grub)         
  - [给 grub 设置密码](#grub_password)             
  - [密码保护启动项](#grub_option)           
  - [保护菜单项](#grub_menuentry)            
  - [警告和注意事项](#grub_warning)             
- [内核模块](#module)              
- [debian/ubuntu 软件源更新](#update)            
- [debian/Ubuntu 网络配置](#net)          
- [防火墙(ufw)](#ufw)           
  - [ufw 使用](#ufw_use)                        
  - [配置文件](#ufw_config)                    
  - [操作命令](#ufw_commond)              
  - [日志](#ufw_log)            
  - [问题](#ufw_question)            
- [基础使用](#base_use)               
  - [运行级别](#runlevel)                     
  - [快捷方式](#shortcut)              
- [搭建 C/C++ 开发环境](#cc++)               


Ubuntu 发布版本的官方名称是 `Ubuntu X.YY` ，其中 X 表示年份（减去2000），YY 表示发布的月份。Ubuntu 没有像其它软件一样有 1.0 版本，是因为其第一个版本是发布于 2004 年。Ubuntu中，每个版本都有一个更为特色的名字，这个名字由一个形容词和一个动物名称组成，并且，形容词和名词的首字母都是一致的。从D版本开始又增加了一个规则，首字母要顺延上个版本，如果当前版本是 D ，下个版本就要以 E 来起头。Ubuntu历史版本与代号查看[官网](https://wiki.ubuntu.com/DevelopmentCodeNames)。

查看当前版本及代号命令：

    root@host:~# lsb_release -a
    No LSB modules are available.
    Distributor ID:	Ubuntu
    Description:	Ubuntu 20.04 LTS
    Release:	20.04
    Codename:	focal

## <a id="install_command">安装命令</a>

### <a id="command_deb">deb 包安装方法</a>
 
    dpkg -i <package.deb>               安装一个 Debian 软件包
    dpkg -c <package.deb>               列出 <package.deb> 的内容
    dpkg -I <package.deb>               从 <package.deb> 中提取包裹信息
    dpkg -r <package>                   移除一个已安装的包裹
    dpkg -P <package>                   完全清除一个已安装的包裹。和 remove 不同的是，remove 只是删掉数据和可执行文件，purge 另外还删除所有的配制文件
    dpkg -l package-name-pattern        列出所有与模式相匹配的软件包。如果您不知道软件包的全名，您可以使用“*package-name-pattern*”。
    dpkg -L <package>                   列出 <package> 安装的所有文件清单。同时请看 dpkg -c 来检查一个 .deb 文件的内容
    dpkg -s <package>                   显示已安装包裹的信息。同时请看 apt-cache 显示 Debian 存档中的包裹信息，以及 dpkg -I 来显示从一个 .deb 文件中提取的包裹信息
    dpkg -S file                        这个文件属于哪个已安装软件包。
    dpkg-reconfigure <package>          重新配制一个已经安装的包裹，如果它使用的是 debconf (debconf 为包裹安装提供了一个统一的配制界面)
    dpkg –force-all –purge packagename  有些软件很难卸载，而且还阻止了别的软件的应用 ，就可以用这个，不过有点冒险。

### <a id="command_apt">apt 系统命令</a>

    apt-get update                      在修改/etc/apt/sources.list或者/etc/apt/preferences之後运行该命令。此外您需要定期运行这一命令以确保您的软件包列表是最新的。
    apt-get install packagename         安装一个新软件包
    apt-get remove packagename          卸载一个已安装的软件包（保留配置文件）
    apt-get –purge remove packagename   卸载一个已安装的软件包（删除配置文件）
    apt-get autoremove                  删除为了满足其他软件包的依赖而安装的，但现在不再需要的软件包。
    apt-get clean                       这个命令会把安装的软件的备份也删除，不过这样不会影响软件的使用的。
    apt-get autoclean                   apt 会把已装或已卸的软件都备份在硬盘上，所以如果需要空间的话，可以让这个命令来删除你已经删掉的软件
    apt-get upgrade                     更新所有已安装的软件包
    apt-get dist-upgrade                将系统升级到新版本
    
    apt-cache search string             在软件包列表中搜索字符串
    apt-cache showpkg pkgs              显示软件包信息。
    apt-cache dumpavail                 打印可用软件包列表。
    apt-cache show pkgs                 显示软件包记录，类似于dpkg –print-avail。
    apt-cache pkgnames                  打印软件包列表中所有软件包的名称。
    apt-cache stats                     查看当前 Ubuntu 不同类型包的统计及整体统计信息
    apt-cache depends build-essential   查看该软件包的依赖关系
    
    aptitude                            详细查看已安装或可用的软件包。
    apt-file search filename            查找包含特定文件的软件包（不一定是已安装的），这些文件的文件名中含有指定的字符串。

> apt-cache 是linux下的一个apt软件包管理工具，它可查询apt的二进制软件包缓存文件。

> apt-file是一个独立的软件包。您必须先使用apt-get install来安装它，然後运行apt-file update。如果apt-file search filename输出的内容太多，您可以尝试使用apt-file search filename | grep -w filename（只显示指定字符串作为完整的单词出现在其中的那些文件名）或者类似方法，例如：apt-file search filename | grep /bin/（只显示位于诸如/bin或/usr/bin这些文件夹中的文件，如果您要查找的是某个特定的执行文件的话，这样做是有帮助的）。

§ apt 和 apt-get 区别      

* 新版apt软件包提供了apt命令作为面向用户使用的工具。与传统apt-get和aptitude相比，它提供了进度条显示、彩色字符支持等用户友好的新功能。
* apt 命令的引入就是为了解决命令过于分散的问题，它包括了 apt-get 命令出现以来使用最广泛的功能选项，以及 apt-cache 和 apt-config 命令中很少用到的功能。
* apt = apt-get、apt-cache 和 apt-config 中最常用命令选项的集合。

### <a id="command_aptitude">aptitude 命令</a>

    aptitude update                     更新可用的包列表
    aptitude upgrade                    升级可用的包
    aptitude dist-upgrade               将系统升级到新的发行版
    aptitude install pkgname            安装包
    aptitude remove pkgname             删除包
    aptitude purge pkgname              删除包及其配置文件
    aptitude search string              搜索包
    aptitude show pkgname               显示包的详细信息
    aptitude clean                      删除下载的包文件
    aptitude autoclean                  仅删除过期的包文件

> aptitude与apt-get类似，aptitude可以通过命令行方式调用，但仅限于某些命令。最常见的有安装和卸载命令。由于aptitude比apt-get了解更多信息，可以说它更适合用来进行安装和卸载。

### <a id="command_list">列出已安装的软件包</a>
用 apt 命令显示已安装软件包

    apt list --installed
这个会显示使用 apt 命令安装的所有的软件包。同时也会包含由于依赖而被安装的软件包。也就是说不仅会包含你曾经安装的程序，而且会包含大量库文件和间接安装的软件包。

用 dpkg 命令显示已安装软件包

    dpkg-query -l

显示最近安装的软件包

    grep " install " /var/log/dpkg.log
这会显示所有的软件安装包，其中包括最近安装的过程中所依赖的软件包。

    grep " install " /var/log/apt/history.log
这个仅会显示用 apt 命令安装的的程序。但不会显示被依赖安装的软件包

### <a id="service">系统服务</a>
#### 列出当前服务

    service --status-all

#### 查询服务是否开机启动

    systemctl is-enabled xxxx.service

如果是enable开机自启动，如果是disable不开机启动

#### 设置开机运行服务

    systemctl enable *.service
这个命令会在/etc/systemd/system/目录下创建需要的符号链接，表示服务需要进行启动。通过stdout输出的信息可以看到，软连接实际指向的文件为/usr/lib/systemd/system/目录中的文件，实际起作用的也是这个目录中的文件。    

#### 取消设置开机运行

    systemctl disable *.service 
它实现的方法是将服务对应的软连接从/etc/systemd/system中删除，实际只是删除了软连接，并不会产生其他影响。

#### 屏蔽服务

    systemctl mask *.service 
执行后会屏蔽这个服务。它和`systemctl disable`的区别在于，前者只是删除了符号链接，后者会建立一个指向`/dev/null`的符号链接，这样，即使有其他服务要启动被mask的服务，仍然无法执行成功。

#### 取消屏蔽

    systemctl unmask *.service 
如果使用了mask，要想重新启动服务，必须先执行unmask将服务取消屏蔽。mask和unmask是一对操作，用来屏蔽和取消屏蔽服务。

#### 启动服务

    systemctl start *.service 

#### 停止服务

    systemctl stop *.service 

#### 重启服务

    systemctl restart *.service 

#### 重新加载服务配置文件

    systemctl reload *.service 

#### 查询服务运行状态

    systemctl status *.service 

### 查看系统架构
* uname 命令         
`uname -a` 命令可以直接显示 Linux 系统架构的命令，它几乎可以工作在所有 Linux/Unix 系统当中。

        Linux evasafe-lock 5.4.0-53-generic #59-Ubuntu SMP Wed Oct 21 09:38:44 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

* dpkg 命令        
`dpkg --print-architecture` 的命令可用于查看 Debian/ Ubuntu 操作系统是 32 位还是 64 位，此命令只适用于基于 Debian 和 Ubuntu 的 Linux 发行版。

        amd64

* getconf 命令      
`getconf LONG_BIT` 命令主要用于显示系统变量配置，我们也可使用如下参数来查看 Linux 系统架构：

        64

* arch 命令           
`arch` 命令主要用于显示操作系统架构类型，与 uname -m 命令非常类似。如果输出 x86_64 则表示为 64 位系统，如果输出 i686 或 i386 则表示为 32 位系统。

        x86_64

* file 命令    
file 命令可以配合 /sbin/init 这个特殊参数来查看系统架构类型（/sbin/init 在 Ubuntu 15.10 里面是链接到/lib/systemd/systemd 的）,输入`file /lib/systemd/systemd`：

        /lib/systemd/systemd: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=6f0d7528306f37ef94eb4fb1ba44a64e3b547c9a, for GNU/Linux 3.2.0, stripped


## <a id="grub">Grub</a>
`GRUB` 为其菜单和终端提供基本的密码保护。 用户可以设置密码来保护整个菜单或特定菜单项。 所有用户或仅选定用户都需要密码。 密码可以加密或未加密格式存储。 

查询 grub 版本

    grub-install --version

grub 的配置文件

* `/etc/default/grub` is where you can set simple options for many GRUB settings. It is parsed as a shell script.
* `/etc/grub.d` contains shell scripts which generate GRUB configuration (based on settings on /etc/default/grub). `update-grub` (aka grub-mkconfig) runs these scripts to generate actual GRUB configuration.
* `/boot/grub2/grub.cfg` is where the generated configuration is saved for GRUB to use.

> 通常，要设置GRUB选项，请编辑 `/etc/default/grub`。如果需要生成其他GRUB条目或更改生成的条目，请在`/etc/grub.d`中添加或更改脚本。不要手动编辑`/boot/grub2/grub.cfg`。

### <a id="grub_password">给 grub 设置密码</a>

启用Grub 2密码保护需要执行三个步骤。 

* 必须标识授权用户，
* 必须指定其密码，
* 并且必须标识要保护的菜单项。 
用户和密码被手动添加到`/etc/grub.d/00_header`文件中。由于该文件是系统文件，因此必须由具有管理权限（root）的Ubuntu用户进行编辑。 运行update-grub时，用户/密码信息会自动添加到GRUB 2菜单配置文件（grub.cfg）。

要编辑`/etc/grub.d/00_header`、`/etc/grub.d/10_linux`和`/etc/grub.d/30_os-prober`文件，请使用文本编辑器（例如gedit）以root身份打开它们：

超级用户/用户信息和密码不必包含在/etc/grub.d/00_header文件中。 该信息可以放在任何/etc/grub.d文件中，只要该文件已合并到grub.cfg中即可。 用户可能希望将此数据输入到自定义文件中，例如/etc/grub.d/40_custom，因此，如果更新Grub软件包，则不会覆盖该数据。 如果将信息放置在自定义文件中，请勿包含“cat << EOF”和“EOF”行，因为将从这些文件中自动添加内容。

首先我们为Grub的配置文件生成一个暗文密码。 输入命令：

    grub-mkpasswd-pbkdf2
它会提示您输入密码，并返回一个长字符串。

接着在 grub 的配置文件中配置用户和密码：

    sudo vim /etc/grub.d/40_custom

打开40_custom文件，在这里应该放置自己的自定义设置。 如果将它们添加到其他位置，则它们可能会被较新版本的Grub覆盖。

    set superusers=”name”
    password_pbkdf2 name [long string from earlier]

密码也可以用明文表示，只是这样就不安全了，例如：

    password jim insecure

保存后运行以下命令更改才会生效：

    sudo update-grub

配置了超级用户后，Grub会自动阻止人们编辑引导条目或在没有密码的情况下访问Grub命令行。



是否想用密码保护一个特定的启动项，以便没有提供密码就无法启动它？

### <a id="grub_option">密码保护启动项</a>

首先，我们需要确定包含要修改的启动项的文件。 键入`sudo ls /etc/grub.d/` 查看可用文件列表。

    00_header	        10_linux_zfs	30_os-prober	  41_custom
    05_debian_theme         20_linux_xen	30_uefi-firmware  README
    10_linux	        20_memtest86+	40_custo

假设我们要用密码保护我们的Linux系统。 Linux启动项是由10_linux文件生成的，因此我们将使用`sudo nano /etc/grub.d/10_linux`命令将其打开。 编辑此文件时要小心！ 如果您忘记了密码或输入了错误的密码，除非您从实时CD引导并首先修改Grub设置，否则您将无法引导至Linux。

这是一个很长的文件，其中包含许多内容，因此我们将按Ctrl-W搜索所需的行。 在搜索提示下键入menuentry，然后按Enter。 您会看到一行以printf开头的行。


如果将Grub设置为显示启动菜单，则在不输入超级用户密码的情况下，您将无法编辑启动项或使用命令行模式。

### <a id="grub_menuentry">保护菜单项</a>
GRUB 2菜单可以包含受保护和不受保护的项目。保护菜单项的格式包括将用户访问信息添加到菜单条目标题行。

* 存在 `--unrestricted` 选项会禁用密码保护。
* `--users` 选项可指定用户启用密码保护。超级用户始终具有访问权限。例如`--users ""`仅授权超级用户
* `--users Jane` 授权超级用户和 Jane
* `--users Jane,Sergio` 授权超级用户，Jane 和 Sergio
示例：

| 实现功能 | 代码 |
| -------- | ------------------------------------------------------------ |
| All Users (No menuentry protection): | menuentry 'Ubuntu, with Linux 3.2.0-24-generic' --class ubuntu -class os --unrestricted { |
| Superuser Only: | menuentry 'Ubuntu, with Linux 3.2.0-24-generic' --class ubuntu -class os --users "" { |
| Superuser + Jane: | menuentry 'Ubuntu, with Linux 3.2.0-24-generic' --class ubuntu -class os --users Jane { |
| Superuser + Jane + Sergio: | menuentry 'Ubuntu, with Linux 3.2.0-24-generic' --class ubuntu -class os --users Jane,Sergio { |


### <a id="grub_warning">警告和注意事项</a>
创建受密码保护的GRUB 2菜单时出错，可能会导致系统无法启动。 要使用破损的密码还原系统，请使用LiveCD或其他OS访问和编辑GRUB 2配置文件。

* 如果启用了密码保护，则只有指定的超级用户才能通过按“e”编辑Grub 2菜单项，或通过按“c”访问GRUB 2命令行。
* 如果将GRUB 2设置为自动启动到受密码保护的菜单项，则用户没有选择退出密码提示以选择另一个菜单项的选项。 在这种情况下，按住SHIFT键将不会显示菜单。用户必须输入正确的用户名和密码。如果不能，则必须通过LiveCD或其他方式来编辑配置文件以解决该问题。
* 使用GRUB 2密码进行试验的用户应保留至少一个不受保护的菜单项，并将超时设置为至少1秒，直到测试完成。这将允许启动以纠正有问题的设置。

### 参考资料
[GNU GRUB Manual 2.04](https://www.gnu.org/software/grub/manual/grub/grub.html#Simple-configuration)                    
[Ubuntu Grub2 Passwords](https://help.ubuntu.com/community/Grub2/Passwords)               
[An introduction to GRUB2 configuration for your Linux machine](https://opensource.com/article/17/3/introduction-grub2-configuration-linux)            
[How to Password Protect Ubuntu’s Boot Loader](https://www.howtogeek.com/102009/how-to-password-protect-ubuntus-boot-loader/)                       


## <a id="module">内核模块<a/>

### lsmod
列出内核已载入模块的状态。

lsmod 以美观的方式列出`/proc/modules`的内容。

### depmod
分析可加载模块的依赖性，生成modules.dep文件和映射文件。

Linux内核模块可以为其它模块提供提供服务(在代码中使用EXPORT_SYMBOL)，这种服务被称作”symbols”。若第二个模块使用了这个symbol，则该模块很明显依赖于第一个模块。这些依赖关系是非常繁杂的。
depmod读取在/lib/modules/version 目录下的所有模块，并检查每个模块导出的symbol和需要的symbol，然后创建一个依赖关系列表。默认地，该列表写入到`/lib/moudules/version`目录下的modules.dep文件中。若命令中的filename有指定的话，则仅检查这些指定的模块(不是很有用)。

若命令中提供了version参数，则会使用version所指定的目录生成依赖，而不是当前内核的版本(uname -r 返回的)。

### modprobe
Linux内核添加删除模块。

modprobe 命令智能地向内核中加载模块或者从内核中移除模块，可载入指定的个别模块，或是载入一组相依的模块。除了可选的`/etc/modprobe.conf`配置文件和`/etc/modprobe.d`目录外。
modprobe需要一个最新的modules.dep文件，modprobe会根据depmod所产生的依赖关系，决定要载入哪些模块。若在载入过程中出错，modprobe会卸载整组的模块。

在使用这个命令加载模块前先使用`depmod -a`命令生成`modules.dep`文件，该文件位于`/lib/modules/$(uname -r)`目录下。

载入模块的命令:

    (1) 载入指定的模块：modprobe drv.ko 
    (2) 载入全部模块：modprobe -a

卸载模块的命令：

    modprobe -r drv.ko

### modinfo
显示内核模块的信息。

modinfo列出Linux内核中命令行指定的模块的信息。若模块名不是一个文件名，则会在`/lib/modules/version`目录中搜索，就像modprobe一样。默认情况下，为了便于阅读，以下面的格式列出模块的每个属性：
    
    fieldname : value。

### insmod
向Linux内核中插入一个模块。

insmod是一个向内核插入模块的小程序：若文件名是一个连字符’-'，模块从标准输入输入。大多数用户使用modprobe，因为它比较智能化。

### rmmod
删除内核中的一模块。

rmmod是一个可以从内核中删除模块的小程序，大多数用户使用`modprobe -r`去删除模块。

§ 卸载驱动
查看加载的驱动列表

    lsmod

卸载已加载的驱动

    rmmod modname 

如果用以上命令无法卸载，先执行命令`modprobe -r modname`  


§ modprobe和insmod的区别是什么呢？

1.modprobe可以解决load module时的依赖关系，比如load moudleA就必须先load mouduleB之类的，它是通过/lib/modules/<kernel-version>/modules.dep文件来查找依赖关系的。而insmod不能解决依赖问题。

2.modprobe默认会去/lib/modules/<kernel-version>/下面查找module，而insmod只在给它的参数中去找module（默认在当前目录找）。这样，有时insmod也有它的有用之处，举个例子吧。

有/root/my-mod.ko这个module，cd /root/，然后用insmod my-mod.ko(insmod /root/my-mod.ko)就可以insert这个module了，但是用modprobe my-mod.ko(modprobe /root/my-mod.ko)却提示"FATAL: Module my-mod.ko not found"，这就是因为modprobe是到/lib/modules/`uname -r`/下去找module的，如果没找到就是这样了。

## <a id="update">debian/ubuntu 软件源更新</a>
修改 `/etc/apt/sources.list` 之后一般会运行下面两个命令进行更新升级：

        sudo apt-get update
        sudo apt-get dist-upgrade
其中 ：          
&emsp;&emsp; update       - 取回更新的软件包列表信息        
&emsp;&emsp; dist-upgrade - 发布版升级        
* 第一个命令仅仅更新的软件包列表信息，所以很快就能完成。     
* 第二个命令是全面更新发布版，一般会下载几百兆的新软件包。       
* 其实在运行完第一个命令后系统就会提示你进行更新升级。因为修改了源，所有这次更新的改动可能会很大，比如安装某个包可能会删除太多的其他包，所有系统会提示你运行“sudo apt-get dist-upgrade”进行全面升级或使用软件包管理器中的“标记全部软件包以便升级”功能进行升级。两者效果是一样的。

常用软件源：

中科大源

    ##中科大源
    deb https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
    deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
    deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
    deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

163源

    ##163源
    deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse

清华源

    ##清华源
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

### 参考资料
[debian软件源source.list文件格式说明](http://www.cnblogs.com/beanmoon/p/3387652.html)          


## <a id="net">debian/Ubuntu 网络配置<a/>
NetworkManager是一项系统网络服务，用于管理您的网络设备和连接，并在可用时尝试保持网络连接处于活动状态。 它管理以太网，WiFi，移动宽带（WWAN）和PPPoE设备，同时还提供与各种不同VPN服务的VPN集成。

默认情况下，Ubuntu Core上的网络管理由systemd的networkd和netplan处理。 但是，安装NetworkManager时，它将通过创建一个netplan配置文件来控制系统中的所有网络设备，在其中将其自身设置为默认网络渲染器。

Ubuntu Core中的默认netplan配置文件将网络设备的管理留给networkd。 但是，在安装network-manager时，它将创建新的netplan配置文件，将其自身设置为默认的网络渲染器并控制所有设备。

[NetworkManager 文档](https://wiki.gnome.org/Projects/NetworkManager)        

### Ubuntu 18.04 LTS 之前版本使用 ifupdown 配置网络
ubuntu 本身支持linux的网络底层设置命令：ifconfig,route,ip 等命令，但为了让网络设置更加简单,Debian 提供了一个标准的高级网络设置工具,包含 ifup 和ifdown 程序和 `/etc/network/interfaces` 文件。 如果你选择用 ifupdown 来配置你的网络,那么就不要同时使用底层工具去配置。这也意味着你不应该用其他高级配置工具,如whereami、divine、intuitively 等。他们调用的也是底层配置工具。ifupdown 程序在设计的时候,是假设仅有这样一个程序会被用来设置网络接口的。

配置网卡，修改 `/etc/network/interfaces` 添加如下:

    auto eth0 #开机自动激活
    iface eth0 inte static #静态IP
    address 192.168.0.56 #本机IP
    netmask 255.255.255.0 #子网掩码
    gateway 192.168.0.254 #路由网关
 
如果是用DHCP自动获取，请在配置文件里添加如下：

    auto eth0
    iface eth0 inet dhcp

设置DNS

    echo "nameserver 202.96.128.86" >> /etc/resolv.conf

重启一下网卡。

    /etc/init.d/networking restart

### Ubuntu 18.04 LTS以上版本 使用 Netplan 配置网络
Ubuntu 18.04 LTS 之后的版本都采用全新的 Netplan 来管理网络配置，所以如果我们需要修改 Ubuntu 18.04 LTS 的网络设置，需要配置 Netplan 并让其生效。

#### netplan 的工作方式
netplan 从配置文件 `/etc/netplan/*.yaml` 读取网络配置，启动后 netplan 在 /run 目录中生成特定网卡名称后缀的配置文件，然后将网卡设备的控制权移交给特定的网络守护程序。

netplan 目前支持以下两种服务：
* NetworkManager
* Systemd-networkd

#### Netplan 配置流程

1、查看配置文件

    ls /etc/netplan/

就可以看到配置文件名称。

2、打开配置文件

    vi /etc/netplan/*.yaml

3、修改配置文件，修改方法见后面详细介绍。

4、测试配置文件

    sudo netplan try

如果没问题，可以继续往下应用配置文件。

5、应用配置文件

    sudo netplan apply

6、验证 IP 地址

    ip a

#### Netplan 配置文件详解,修改netplan配置文件

netplan 支持两个 renderers，分别为

    Network Manager
    systemd.networkd

1、使用 DHCP：

    network:
      version: 2
      renderer: networkd
      ethernets:
        ens3://这里是你的网卡名字，可以通过sudo ifconfig -a 查看获得
          dhcp4: true

2、使用静态 IP：

    network:
      version: 2
      renderer: networkd
      ethernets:
        ens3:
          addresses:
            - 10.10.10.2/24
          gateway4: 10.10.10.1
          nameservers:
              search: [mydomain, otherdomain]
              addresses: [10.10.10.1, 1.1.1.1]

3、多个网卡 DHCP：

    network:
      version: 2
      ethernets:
        ens30://网卡一名字，可以通过sudo ifconfig -a 查看获得
          dhcp4: yes
          dhcp4-overrides:
            route-metric: 100
        ens31://网卡二名字，可以通过sudo ifconfig -a 查看获得
          dhcp4: yes
          dhcp4-overrides:
            route-metric: 200

4、连接开放的 WiFi（无密码）：

    network:
      version: 2
      wifis:
        wl0:
          access-points:
            opennetwork: {}
          dhcp4: yes

5、连接 WPA 加密的 WiFi：

    network:
      version: 2
      renderer: networkd
      wifis:
        wlp2s0b1:
          dhcp4: no
          dhcp6: no
          addresses: [192.168.0.21/24]
          gateway4: 192.168.0.1
          nameservers:
            addresses: [192.168.0.1, 8.8.8.8]
          access-points:
            "network_ssid_name":
              password: "**********"

6、在单网卡上使用多个 IP 地址（同一网段）：

    network:
      version: 2
      renderer: networkd
      ethernets:
        ens3:
         addresses:
           - 10.100.1.38/24 
           - 10.100.1.39/24
         gateway4: 10.100.1.1

7、在单网卡使用多个不同网段的 IP 地址：

    network:
      version: 2
      renderer: networkd
      ethernets:
        ens3:
         addresses:
           - 9.0.0.9/24
           - 10.0.0.10/24
           - 11.0.0.11/24
         #gateway4:    # 这里不用设置网关，因为后面用了路由配置。
         routes:
           - to: 0.0.0.0/0
             via: 9.0.0.1
             metric: 100
           - to: 0.0.0.0/0
             via: 10.0.0.1
             metric: 100
           - to: 0.0.0.0/0
             via: 11.0.0.1
             metric: 100

以上就是ubuntu18.04 LTS 下单网卡多 IP 地址、单网卡多网关多IP段、多网卡多 IP、静态 IP、DHCP 等的NETPLAN配置。如果有问题，肯定是没对齐。注意yaml文件格式对齐很重要。

[Ubuntu 禁用 Netplan 改用 ifupdown 配置网络](https://www.hostarr.com/disable-netplan-and-enable-ifupdown-in-ubuntu/)           

[How to configure networking with Netplan on Ubuntu](https://vitux.com/how-to-configure-networking-with-netplan-on-ubuntu/)                


§ 新旧版本对比

* Ubuntu 18.04的DNS解析设置改成了 `systemd-resolved`，不是在原先的配置文件 `/etc/resolv.conf` 设置了。
* Ubuntu 18.04默认情况下不再安装`ifupdown`，因此命令`ifup`和`ifdown`也不可用。可以使用`ip`命令来实现类似的功能，`ip link set device up` 和 `ip link set device down`。
* 之前Ubuntu16.04版本里的网卡配置文件 `/etc/network/interfaces` 不起作用了，改成了netplan方式。
* 如果新的 netplan 目前不能满足用户的网络使用需求，ifupdown 软件包仍然可以在Ubuntu 中使用和支持。ifupdown安装命令：`apt install ifupdown` 。

### 配置网络命令
启用禁用网卡可以使用以下 5 个方法来完成：
* ifconfig 命令：用于配置网卡。它可以提供网卡的很多信息。
* ifdown/up 命令：ifdown 命令用于禁用网卡，ifup 命令用于启用网卡。
* ip 命令：用于管理网卡，用于替代老旧的、不推荐使用的 ifconfig 命令。它和 ifconfig命令很相似，但是提供了很多 ifconfig 命令所不具有的强大的特性。
* nmcli 命令：是一个控制 NetworkManager 并报告网络状态的命令行工具。
* nmtui 命令：是一个与 NetworkManager 交互的、基于 curses 图形库的终端 UI 应用。

其他命令

networkctl           
networkctl status ens33

networkd.conf        networkd.conf.d      networkd-dispatcher  network_namespaces   networks

[polkit](https://www.freedesktop.org/software/polkit/docs/latest/polkit.8.html): Linux授权弹窗

pkaction 命令可以显示polkit操作的描述。

    pkaction --action-id org.freedesktop.NetworkManager.network-control --verbose


## <a id="ufw">防火墙(ufw)</a>
UFW(uncomplicated firewall)，即简单防火墙，是一个 Arch Linux、Debian 或 Ubuntu 中管理防火墙规则的前端。 UFW 通过命令行使用（尽管它有可用的 GUI），它的目的是使防火墙配置简单（即不复杂uncomplicated）。

### <a id="ufw_use">ufw 使用</a>
默认情况下，UFW 阻塞了所有进来的连接，并且允许所有出去的连接。这意味着任何人无法访问你的服务器，除非你打开端口。运行在服务器上的应用和服务可以访问外面的世界。

    sudo ufw default allow outgoing
    sudo ufw default deny incoming
    
如果你对ufw的使用还不太了解，看看[How To Set Up a Firewall with UFW on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-14-04)这篇文章，入门是没问题的。当然，ufw的功能远不止这些，这篇晋级的文章[UFW Essentials: Common Firewall Rules and Commands](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)会让你有个大的提升。

Linux 上的软件或应用基本上离不开配置文件，ufw 当然也不例外。

### <a id="ufw_config">配置文件</a>
ufw 常用的配置文件：

* /etc/default/ufw: The main configuration file with pre-defined rules.
* /etc/ufw/before[6].rules: In this file rules are calculated before adding via ufw command.
* /etc/ufw/after[6].rules: In this file rules are calculated after adding via ufw command.
* /etc/ufw/sysctl.conf: This file is used to tune kernel network.
* /etc/ufw/ufw.conf: This file enable the ufw on boot.

虽然可以通过命令行添加简单的规则，但仍有可能需要添加或删除更高级或特定的规则。在运行通过终端输入的规则之前，UFW 将运行一个文件 `before.rules`，它允许回环接口、ping 和 DHCP 等服务。要添加或改变这些规则，编辑 `/etc/ufw/before.rules` 这个文件。 同一目录中的 `before6.rules` 文件用于 IPv6 。还存在一个 `after.rule` 和 `after6.rule` 文件，用于添加在 UFW 运行你通过命令行输入的规则之后需要添加的任何规则。

默认的策略定义在 `/etc/default/ufw`。 从此处可以禁用或启用 IPv6，可以设置默认规则，并可以设置 UFW 以管理内置防火墙链。可以通过使用`sudo ufw default <policy> <chain>`命令来修改。

### <a id="ufw_commond">操作命令</a>
    
想要列举出你系统上所有的应用配置，输入：

    sudo ufw app list
想要查找更多关于指定配置和包含规则的信息，使用下面的命令：

    sudo ufw app info 'Nginx Full'

### <a id="ufw_log">日志</a>
启动日志命令：

    sudo ufw logging on
可以通过运行 `sudo ufw logging low|medium|high` 设计日志级别，可以选择 low、 medium 或者 high。默认级别是 low。

常规日志类似于下面这样，位于 /var/logs/ufw：

    Sep 16 15:08:14 <hostname> kernel: [UFW BLOCK] IN=eth0 OUT= MAC=00:00:00:00:00:00:00:00:00:00:00:00:00:00 SRC=123.45.67.89 DST=987.65.43.21 LEN=40 TOS=0x00 PREC=0x00 TTL=249 ID=8475 PROTO=TCP SPT=48247 DPT=22 WINDOW=1024 RES=0x00 SYN URGP=0
前面的值列出了你的服务器的日期、时间、主机名。剩下的重要信息包括：

* [UFW BLOCK]：这是记录事件的描述开始的位置。在此例中，它表示阻止了连接。
* IN：如果它包含一个值，那么代表该事件是传入事件
* OUT：如果它包含一个值，那么代表事件是传出事件
* MAC：目的地和源 MAC 地址的组合
* SRC：包源的 IP
* DST：包目的地的 IP
* LEN：数据包长度
* TTL：数据包 TTL，或称为 time to live。 在找到目的地之前，它将在路由器之间跳跃，直到它过期。
* PROTO：数据包的协议
* SPT：包的源端口
* DPT：包的目标端口
* WINDOW：发送方可以接收的数据包的大小
* SYN URGP：指示是否需要三次握手。 0 表示不需要。

### <a id="ufw_question">问题</a>
#### How ufw firewall deny outgoing but allow browser?[来源](https://askubuntu.com/questions/1005312/ufw-firewall-deny-outgoing-but-allow-browser)
The first thing you need to do is to change the default outgoing policy to deny. By default all outgoing traffic is allowed.

    sudo ufw default deny outgoing

Then you must allow outgoing traffic on both port 80 and 443 with these commands:

    sudo ufw allow out to any port 80
    sudo ufw allow out to any port 443

Finally, since web browsing require access to a DNS server you must also allow port 53:

    sudo ufw allow out to any port 53
    
Show number and deleted v6 by number:

    sudo ufw status numbered
    sudo ufw delete 3

Then reload the firewall rules:

    sudo ufw reload

Confirm the changes with: 

    sudo ufw status verbose
    
另外一种方法：

    sudo ufw deny out to any
    sudo ufw allow out 53,80,443/tcp
    sudo ufw allow out 53,80,443/udp

#### Allowing outgoing connections to a particular IP with ufw. [来源](https://serverfault.com/questions/649870/allowing-outgoing-connections-to-a-particular-ip-with-ufw)
Here's to anyone wondering how this can be done:
1) Open `/etc/ufw/before.rules` and insert this rule above `COMMIT` on the last line          
code:

    -A ufw-before-output -m owner --uid-owner {user} -p {protocol} --dport {port} -d {ip} -j ACCEPT
Fill in the values for each as so:

* {user} - user you want to allow this (www-data)
* {protocol} - udp or tcp
* {port} - on what port you want to allow it
* {ip} - IP Address you want to allow.

An example:

    # server
    -A ufw-before-output -m owner --uid-owner www-data -p udp --dport 6666 -d 255.255.255.255 -j ACCEPT # gameserver
    -A ufw-before-output -m owner --uid-owner www-data -p tcp --dport 3306 -d 255.255.255.255 -j ACCEPT # mysql

    # don't delete the 'COMMIT' line or these rules won't be processed
    COMMIT
2) Restart ufw           
code:

    service ufw restart

Should all correctly work after! Ensure you don't put two ports in one like like "-dport 6666,5555" - it usually errors!

#### UFW: Allow traffic only from a domain with dynamic IP address. [来源](https://unix.stackexchange.com/questions/91701/ufw-allow-traffic-only-from-a-domain-with-dynamic-ip-address)
I don't believe this is possible with ufw. ufw is just a frontend to iptables which also lacks this feature, so one approach would be to create a crontab entry which would periodically run and check if the IP address has changed. If it has then it will update it.

You might be tempted to do this:

    $ iptables -A INPUT -p tcp --src mydomain.dyndns.org --dport 22 -j ACCEPT
But this will resolve the hostname to an IP and use that for the rule, so if the IP later changes this rule will become invalid.

#### How UFW To Block Outgoing Ports Except Those Needed?[来源](https://ubuntuforums.org/showthread.php?t=1893751)

    sudo ufw deny out to any
    sudo ufw allow out 20,21,53,80,123,442/tcp
    sudo ufw allow out 20,21,53,80,123,442/udp
    
### 参考资料
[在 Ubuntu 中用 UFW 配置防火墙](https://linux.cn/article-8087-1.html)                     
[如何在 Ubuntu 20.04 上使用 UFW 来设置防火墙](https://zhuanlan.zhihu.com/p/139381645)               
[How to Enable, Deny, Allow, Delete Rules on Ubuntu UFW Firewall ](https://linoxide.com/firewall/guide-ufw-firewall-ubuntu-16-10/)
[ubuntu Firewall 官方文档](https://help.ubuntu.com/community/Firewall)                  
[ubuntu UFW 官方文档](https://help.ubuntu.com/community/UFW)            

## <a id="base_use">基础使用</a>

### <a id="runlevel">运行级别</a>
Linux 系统任何时候都运行在一个指定的运行级上，并且不同的运行级的程序和服务都不同，所要完成的工作和要达到的目的都不同，系统可以在这些运行级之间进行切换，以完成不同的工作。

debian/ubuntu 的 runlevel级别定义如下：

    0 – Halt，关机模式
    1 – Single，单用户模式
    2 - Full multi-user with display manager (GUI)
    3 - Full multi-user with display manager (GUI)
    4 - Full multi-user with display manager (GUI)
    5 - Full multi-user with display manager (GUI)
    6 – Reboot，重启
可以发现2~5级是没有任何区别的。他们为多用户模式，这和一般的linux不一样。

查看当前系统的运行级别：

    runlevel


切换运行级别：

    init [0123456Ss]

### <a id="shortcut">快捷方式</a>

#### 编写桌面启动程序
Ubuntu 的桌面程序保存在路径 `/uar/share/applications` 下，以 `.desktop` 为后缀名。所以要创建新的桌面程序，只需在该路径下创建对应的 `.desktop` 文件，再复制到桌面即可。当然，还需作一些设置，详见后文。

`.desktop` 文件可以新建也可以复制一份作一些修改。格式如下：

    [Desktop Entry]
    Name=Firefox Developer
    GenericName=Firefox Developer Edition
    Exec=/home/username/soft/firefox/firefox/firefox
    Terminal=false
    Icon=/home/username/soft/firefox/firefox/browser/chrome/icons/default/default64.png
    Type=Application
    Categories=Application;Network;X-Developer;
    Comment=Firefox Developer Edition Web Browser.

重点参数的说明：

| 参数 |	描述  |
| ---- | ------------------- |
|NAME|	桌面显示的名称|
|Exec|	应用的启动路径，和解压路径对应|
|Terminal|	是否启用命令行窗口，否|
|Icon|	应用的图标地址|
|Type|	设为Application，规定类型为应用程序|

#### 创建桌面快捷方式
* 在 `/uar/share/applications` 路径下，选中要创建快捷方式的文件，右击复制到桌面。
* 接着设置权限及其启动方式，“右键——>属性——>权限“:勾选允许文件作为程序执行。
* 设置好后关闭设置窗口，再“右键——>允许启动“，就得到一个桌面快捷启动方式了。

#### 添加到任务栏
按下 OPTIONS 键(ctrl 与 alt 中间的那个)，找到程序，拖拽到任务栏即可。

### 服务进程

sysv-rc-conf 是一个服务管理程序。

update-rc.d 类似与 RHEL 中的 chkconfig。

invoke-rc.d 类似与 RHEL 中的 service。


### 环境变量

历史记录数

    echo $HISTSIZE
可以修改该参数，但重启电脑后失效，如需长久有效，在 /etc/profile 文件中配置。


### 实用命令

查看内核版本
```
cat /etc/issue
cat /proc/version
uname -a
file /bin/bash
file /bin/bash
```

设置 root 密码

    sudo passwd
    
### Ubuntu 安全相关命令


#### 在Ubuntu中禁用 root 帐户

    sudo passwd -l root
    
如果root密码忘了就需要进入单用户模式。进入单用户模式：

    1，在开机引导到GRUB等待界面（GRUB loading, please wait…）这里的时候按下ESC键来进入启动菜单，选择相应内核版本的Recovery Mode，按e键进入编辑状态。
    2，移动光标，将”ro recovery nomodeset“修改为"rw single init=/bin/bash"以后 按ctrl+X就可以即进入单用户模式，
    3，然后我们就可以用命令 passwd 用户名来修改密码了。
    见到：root@(none):/#  马上输入”passwd“ 回车！
    见到：Enter new UNIX password:  马上输入”123“ 回车！
    见到：retype new UNIX password:马上输入”123“ 回车！
    新密码变成”123“了。
    4. 输入”reboot“ 回车！也可以Ctr Alt Del. 总之重启动就可以了！

#### 禁用 ssh root login
输入命令：

    grep -i "rootlogin" /etc/ssh/sshd_config
Root login is disabled, if the PermitRootLogin directive is commented out (# in front) or its value is not set to yes.

sshd_config 为 SSH 的配置文件。

启用 SSH 命令:

    vim /etc/ssh/sshd_config
Uncomment the line PermitRootLogin and set the value to yes:

    PermitRootLogin yes
To make the new setting take effect, restart the ssh server:

    systemctl restart sshd.service

#### 查看系统启动项
列出所有

    systemctl list-unit-files

查看服务状态及路径

    systemctl status xxx.service

禁用服务

    systemctl disable xxx.service

停止服务

    systemctl disable xxx.service


#### Ubuntu开机自动禁用无线网络
将无线网卡驱动加入黑名单，彻底禁用无线网络。

`lshw` 命令可以列出电脑硬件的详细信息，找到 `*-network`部分的，例如： 

    configuration: broadcast=yes driver=iwl3945 latency=0 multicast=

 无线网卡驱动名称是iwl3945（intel 3945abg无线网卡），将它加入到黑名单就可以了，具体操作如下：
 
    sudo gedit /etc/modprobe.d/blacklist.conf
 在文本最后加入 
 
    blacklist iwl3945
 重新启动

#### avahi-daemon
[avahi-daemon是什么](https://www.cnblogs.com/taosim/articles/2639520.html)               

Avahi允许程序在不需要进行手动网络配置的情况 下，在一个本地网络中发布和获知各种服务和主机。例如，当某用户把他的计算机接入到某个局域网时，如果他的机器运行有Avahi服务，则Avahi程式自 动广播，从而发现网络中可用的打印机、共享文件和可相互聊天的其他用户。这有点象他正在接收局域网中的各种网络广告一样。

如果你用不到 把该服务直接关闭

    /etc/init.d/avahi-daemon stop 
or 

    service avahi-daemon  stop

#### Ubuntu关闭cups
在/etc/init.d下新建一个脚本文件，例如：myInit.sh,文件的内容如下：

    #!/bin/bash  
    ### BEGIN INIT INFO  
    #  
    # Provides:  location_server  
    # Required-Start:   $local_fs  $remote_fs  
    # Required-Stop:    $local_fs  $remote_fs  
    # Default-Start:    2 3 4 5  
    # Default-Stop:     0 1 6  
    # Short-Description: ss-server  initscript  
    # Description:  This file should be used to construct scripts to be placed in /etc/init.d.  
    #  
    ### END INIT INFO  
上面的脚本文件中的注释也要有，不能省去。

然后再赋予权限：

    sudo chmod 755 myInit.sh
更新

    sudo update-rc.d myinit.sh defaults 90
这样再启动时，就会自动执行这个脚本文件关闭cups服务，关闭631端口。




sudo systemctl stop cups


### <a id="cc++">搭建 C/C++ 开发环境</a>
安装以下集合以在Ubuntu Linux上编译 c/c++ 程序，包括：

* libc6-dev C standard library.
* gcc C compiler.
* g++ C++ compiler.
* make GNU make utility to maintain groups of programs.
* dpkg-dev Debian package development tools

#### 如何在启动时禁用有线网卡 eth0 ?

使用 `lspci -vn` 查到网卡: 

    07:00.0 0200: 10ec:8168 (rev 07)
        Subsystem: 1028:0572
        Flags: bus master, fast devsel, latency 0, IRQ 43
        I/O ports at 2000 [size=256]
        Memory at c1404000 (64-bit, prefetchable) [size=4K]
        Memory at c1400000 (64-bit, prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: r8169
        
或者在终端中输入lshw命令可以列出电脑硬件的详细信息:      

    *-network
        description: Ethernet interface
        product: 82545EM Gigabit Ethernet Controller (Copper)
        vendor: Intel Corporation
        physical id: 1
        bus info: pci@0000:02:01.0
        logical name: ens33
        version: 01
        serial: 00:0c:29:f0:a3:31
        size: 1Gbit/s
        capacity: 1Gbit/s
        width: 64 bits
        clock: 66MHz
        capabilities: bus_master cap_list rom ethernet physical logical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
        configuration: autonegotiation=on broadcast=yes driver=r8169 driverversion=7.3.21-k8-NAPI duplex=full ip=192.168.116.130 latency=0 link=yes mingnt=255 multicast=yes port=twisted pair speed=1Gbit/s
        
在卸载或将任何模块列入黑名单之前，最好先查看其他模块是否依赖于该模块：

    modinfo -F depends usbcore
        
打开黑名单配置文件：

    vim /etc/modprobe.d/blacklist.conf
将网卡驱动添加到黑名单中:

    blacklist r8169

完成后，更新initramfs并重新启动系统：

    # update-initramfs -u
    # reboot
    
重新启动后使用lsmod查看是否存在模块。如果其他模块依赖于要尝试将其列入黑名单的模块，如上述示例，则需要将所有依赖的模块列入黑名单，否则，您已列入黑名单的初始模块仍然会加载。幸运的是，有一个技巧可以将所有模块(包括其依赖项)列入黑名单。

如果由于某些原因无法将模块及其所有依赖项列入黑名单，请使该模块无法加载，从而导致所有依赖模块停止加载。将以下行添加到您的/etc/modprobe.d/blacklist.conf，usbcore包括其所有相关模块完全列入黑名单：

    install usbcore /bin/true
更新initramfs并重新启动：

    # update-initramfs -u   

#### Ubuntu下关闭笔记本自带摄像头   
临时关闭

    # 禁用即卸载uvcideo驱动    
    sudo modprobe -rv uvcvideo
    # 启用即安装uvcvideo驱动
    sudo modprobe -v uvcvideo

永久关闭

    # 编辑
    sudo vim /etc/modprobe.d/blacklist.conf
    # 添加如下内容
        blacklist uvcvideo
        
#### 禁止 Babel 在用户目录生成 .babel.json 文件

通过在应用程序设置中设置环境变量

    BABEL_DISABLE_CACHE = 1
来禁用babel缓存来解决该问题。

或者 改变 package.json 的设置:

    ...
    "start": "babel-node ./src/index.js",
to

    ...
    "start": "BABEL_DISABLE_CACHE=1 babel-node ./src/index.js",

参见：         
[Babel 环境变量](https://babeljs.io/docs/en/babel-register#environment-variables)         
[why babel stores .babel.json in USERPROFILE path](https://stackoverflow.com/questions/32757306/why-babel-stores-babel-json-in-userprofile-path)           
[Clearing Node.js' cache when loading non-js files e.g. graphql language defenitions](https://stackoverflow.com/questions/42781043/clearing-node-js-cache-when-loading-non-js-files-e-g-graphql-language-defeniti)                   


### Ubuntu 安装后操作步骤

* 安装中文简体、繁体语言
* 安装中文输入法

        sudo apt-get install ibus-pinyin
* 安装 vim

        sudo apt install vim
        考入配置文件.vimrc、插件.vim/，研究.viminfo
* 安装 npm（指定版本）
* 卸载 snapd 

        sudo apt autoremove --purge snapd
* 安装网络工具

        sudo apt install net-tools
* 下载安装 sublime
* 安装 Chrome

        https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
设置 Chrome

> 预先安装 sysv-rc-conf 测试，点一下个工具，查看下历史。数据库，Nginx，黑名单

## 问题
#### `.sudo_as_admin_successful` 文件是干什么用的？
在用户的家目录下有个`.sudo_as_admin_successful`文件，这是个隐藏文件，通常看不到，执行命令`ls -a`可看到，那么，这个文件是怎么生成的？有什么作用？

看看这个论坛[Is it possible to stop .sudo_as_admin_successful being created?](https://askubuntu.com/questions/813942/is-it-possible-to-stop-sudo-as-admin-successful-being-created)的说明，另外提到了[Getting rid of .sudo_as_admin_successful](https://shallowsky.com/blog/linux/sudo_as_admin_spew.html)这篇文章，看了之后会有所启发。


## 参考资料：      
* [Linux中apt与apt-get命令的区别与解释](https://www.sysgeek.cn/apt-vs-apt-get/)      
* [Linux软件包管理基本操作入门](https://www.sysgeek.cn/linux-package-management/)        
* [Linux 中如何启用和禁用网卡？](https://zhuanlan.zhihu.com/p/65480107)                 
* [Ubuntu 20.04 手动实现 rc.local](https://blog.csdn.net/lk_luck/article/details/108361857)                            
* [Ubuntu 20.04 —添加开机启动(服务/脚本)](https://www.cnblogs.com/Areas/p/13439000.html)                   
* [Ubuntu 设置开机启动命令/脚本](https://blog.csdn.net/MakerCloud/article/details/81257953)                          
* [如何停止和禁用Linux系统中的不需要的服务](https://www.cnblogs.com/liushui-sky/p/9442187.html)                
* [ubuntu加速（关闭不必要的服务）](https://blog.csdn.net/weixin_33753845/article/details/92929572)                       
* [怎么禁止/开启Ubuntu自动更新升级](https://blog.csdn.net/davidhzq/article/details/102651588)                   
* [systemd-resolve占用53端口的解决方法](https://www.moeelf.com/archives/270.html)                   
* [如何在Ubuntu/Debian Linux上将模块列入黑名单](https://ubuntuqa.com/article/9930.html) 
* [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)            
* [GNU Textinfo manual](https://www.gnu.org/software/texinfo/manual/texinfo)                             
    
