
## Debian/Ubuntu 命令
### deb 包安装方法  
 
    dpkg -i <package.deb>               安装一个 Debian 软件包
    dpkg -c <package.deb>               列出 <package.deb> 的内容
    dpkg -I <package.deb>               从 <package.deb> 中提取包裹信息
    dpkg -r <package>                   移除一个已安装的包裹
    dpkg -P <package>                   完全清除一个已安装的包裹。和 remove 不同的是，remove 只是删掉数据和可执行文件，purge 另外还删除所有的配制文件
    dpkg -L <package>                   列出 <package> 安装的所有文件清单。同时请看 dpkg -c 来检查一个 .deb 文件的内容
    dpkg -s <package>                   显示已安装包裹的信息。同时请看 apt-cache 显示 Debian 存档中的包裹信息，以及 dpkg -I 来显示从一个 .deb 文件中提取的包裹信息
    dpkg-reconfigure <package>          重新配制一个已经安装的包裹，如果它使用的是 debconf (debconf 为包裹安装提供了一个统一的配制界面)
    dpkg –force-all –purge packagename  有些软件很难卸载，而且还阻止了别的软件的应用 ，就可以用这个，不过有点冒险。
    dpkg -l package-name-pattern        列出所有与模式相匹配的软件包。如果您不知道软件包的全名，您可以使用“*package-name-pattern*”。
    dpkg -S file                        这个文件属于哪个已安装软件包。
    dpkg -L package                     列出软件包中的所有文件。

### 系统命令

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
    aptitude                            详细查看已安装或可用的软件包。与apt-get类似，aptitude可以通过命令行方式调用，但仅限于某些命令。最常见的有安装和卸载命令。由于aptitude比apt-get了解更多信息，可以说它更适合用来进行安装和卸载。
    apt-file search filename            查找包含特定文件的软件包（不一定是已安装的），这些文件的文件名中含有指定的字符串。

> apt-cache 是linux下的一个apt软件包管理工具，它可查询apt的二进制软件包缓存文件。

> apt-file是一个独立的软件包。您必须先使用apt-get install来安装它，然後运行apt-file update。如果apt-file search filename输出的内容太多，您可以尝试使用apt-file search filename | grep -w filename（只显示指定字符串作为完整的单词出现在其中的那些文件名）或者类似方法，例如：apt-file search filename | grep /bin/（只显示位于诸如/bin或/usr/bin这些文件夹中的文件，如果您要查找的是某个特定的执行文件的话，这样做是有帮助的）。

### aptitude 命令

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

§ apt 和 apt-get 区别      

* 新版apt软件包提供了apt命令作为面向用户使用的工具。与传统apt-get和aptitude相比，它提供了进度条显示、彩色字符支持等用户友好的新功能。
* apt 命令的引入就是为了解决命令过于分散的问题，它包括了 apt-get 命令出现以来使用最广泛的功能选项，以及 apt-cache 和 apt-config 命令中很少用到的功能。
* apt = apt-get、apt-cache 和 apt-config 中最常用命令选项的集合。


## [debian 软件源更新](http://www.cnblogs.com/beanmoon/p/3387652.html)
修改 /etc/apt/sources.list 之后一般会运行下面两个命令进行更新升级：

        sudo apt-get update
        sudo apt-get dist-upgrade
其中 ：          
&emsp;&emsp; update       - 取回更新的软件包列表信息        
&emsp;&emsp; dist-upgrade - 发布版升级        
* 第一个命令仅仅更新的软件包列表信息，所以很快就能完成。     
* 第二个命令是全面更新发布版，一般会下载几百兆的新软件包。       
* 其实在运行完第一个命令后系统就会提示你进行更新升级。因为修改了源，所有这次更新的改动可能会很大，比如安装某个包可能会删除太多的其他包，所有系统会提示你运行“sudo apt-get dist-upgrade”进行全面升级或使用软件包管理器中的“标记全部软件包以便升级”功能进行升级。两者效果是一样的。

## debian 网络配置

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

## Debian 系统基本知识

### 运行级别
debian 的 runlevel级别定义如下：

    0 – Halt，关机模式
    1 – Single，单用户模式
    2 - Full multi-user with display manager (GUI)
    3 - Full multi-user with display manager (GUI)
    4 - Full multi-user with display manager (GUI)
    5 - Full multi-user with display manager (GUI)
    6 – Reboot，重启
可以发现2~5级是没有任何区别的。他们为多用户模式，这和一般的linux不一样。

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


## 参考资料：      
* [Linux中apt与apt-get命令的区别与解释](https://www.sysgeek.cn/apt-vs-apt-get/)      
* [Linux软件包管理基本操作入门](https://www.sysgeek.cn/linux-package-management/)     



    
