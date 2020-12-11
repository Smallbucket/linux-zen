
## Debian/Ubuntu 命令
### deb 包安装方法  
 
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
    apt-cache stats                     查看当前 Ubuntu 不同类型包的统计及整体统计信息
    
    aptitude                            详细查看已安装或可用的软件包。
    apt-file search filename            查找包含特定文件的软件包（不一定是已安装的），这些文件的文件名中含有指定的字符串。

> apt-cache 是linux下的一个apt软件包管理工具，它可查询apt的二进制软件包缓存文件。

> apt-file是一个独立的软件包。您必须先使用apt-get install来安装它，然後运行apt-file update。如果apt-file search filename输出的内容太多，您可以尝试使用apt-file search filename | grep -w filename（只显示指定字符串作为完整的单词出现在其中的那些文件名）或者类似方法，例如：apt-file search filename | grep /bin/（只显示位于诸如/bin或/usr/bin这些文件夹中的文件，如果您要查找的是某个特定的执行文件的话，这样做是有帮助的）。

> aptitude与apt-get类似，aptitude可以通过命令行方式调用，但仅限于某些命令。最常见的有安装和卸载命令。由于aptitude比apt-get了解更多信息，可以说它更适合用来进行安装和卸载。

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


### ufw
默认情况下，UFW 阻塞了所有进来的连接，并且允许所有出去的连接。这意味着任何人无法访问你的服务器，除非你打开端口。运行在服务器上的应用和服务可以访问外面的世界。

    sudo ufw default allow outgoing

    sudo ufw default deny incoming

默认的策略定义在`/etc/default/ufw`文件中，并且可以通过使用`sudo ufw default <policy> <chain>`命令来修改。

想要列举出你系统上所有的应用配置，输入：

    sudo ufw app list
想要查找更多关于指定配置和包含规则的信息，使用下面的命令：

    sudo ufw app info 'Nginx Full'

    
#### How ufw firewall deny outgoing but allow browser?
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
        
打开黑名单配置文件：

    vim /etc/modprobe.d/blacklist.conf
将网卡驱动添加到黑名单中:

    blacklist r8169
    
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

#### Ubuntu 18.04 LTS以上版本 使用 Netplan 配置网络
Ubuntu 18.04 LTS 之后的版本都采用全新的 Netplan 来管理网络配置，所以如果我们需要修改 Ubuntu 18.04 LTS 的网络设置，需要配置 Netplan 并让其生效。本文详细讲解 Netplan 的配置流程，包括单网卡多 IP 地址、单网卡多网关、多网卡多 IP、静态 IP、DHCP 等的配置。

一、Netplan 配置流程

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

二、Netplan 配置文件详解,修改netplan配置文件

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

#### 相关配置文件

    vim /etc/default/ufw
    vim /etc/ufw/ufw.conf
    vim /etc/netplan/*.yaml

[如何在 Ubuntu 20.04 上使用 UFW 来设置防火墙](https://zhuanlan.zhihu.com/p/139381645)               
[How to Enable, Deny, Allow, Delete Rules on Ubuntu UFW Firewall ](https://linoxide.com/firewall/guide-ufw-firewall-ubuntu-16-10/)               
[How to configure networking with Netplan on Ubuntu](https://vitux.com/how-to-configure-networking-with-netplan-on-ubuntu/)                
[HowTo: UFW ) Block Outgoing Ports Except Those Needed + More](https://ubuntuforums.org/showthread.php?t=1893751)                



### Ubuntu 安装后操作步骤

* 安装中文简体、繁体语言
* 安装中文输入法

        sudo apt-get install ibus-pinyin
* 安装 vim

        sudo apt install vim
* 安装 npm
* 卸载 snapd 

        sudo apt autoremove --purge snapd
* 安装网络工具 

        sudo apt install net-tools
* 下载安装 sublime
* 安装 Chrome

        https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb



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




    
