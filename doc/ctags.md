
## ctags
ctags的功能：扫描指定的源文件，找出其中所包含的语法元素，并将找到的相关内容记录下来。

### ctags 简介
目前用的 ctags 是 Universal Ctags

    Universal Ctags 0.0.0, Copyright (C) 2015 Universal Ctags Team
    Universal Ctags is derived from Exuberant Ctags.
    Exuberant Ctags 5.8, Copyright (C) 1996-2009 Darren Hiebert
      Compiled: Jun 12 2019, 12:29:00
      URL: https://ctags.io/
      Optional compiled features: +wildcards, +regex, +iconv, +option-directory, +packcc


### ctags 安装

    $ ./autogen.sh
    $ ./configure --prefix=/where/you/want # defaults to /usr/local
    $ make
    $ make install # may require extra privileges depending on where to install

### 常用命令
* --list-languages     
查看识别哪些语言

* --list-maps      
可以根据文件的扩展名以及文件名的形式来确定该文件中是何种语言，从而使用正确的分析器。

* --langmap=c++:+.inl –R      
指定ctags用特定语言的分析器来分析某种扩展名的文件

* --list-kinds       
查看ctags可以识别的语法元素     
`--list-kinds=java` 单独查看可以识别的 java 的语法元素

### ctags 命令示例

    ctags -R 
        --languages=c++ 
        --langmap=c++:+.inl 
        -h +.inl 
        --c++-kinds=+px
        --fields=+aiKSz 
        --extra=+q 
        --exclude=lex.yy.cc --exclude=copy_lex.yy.cc
命令解释：

* -R

表示扫描当前目录及所有子目录（递归向下）中的源文件。并不是所有文件 ctags 都会扫描，如果用户没有特别指明，则 ctags 根据文件的扩展名来决定是否要扫描该文件，如果 ctags 可以根据文件的扩展名可以判断出该文件所使用的语言，则 ctags 会扫描该文件。

* --languages=c++

只扫描文件内容判定为`c++`的文件，即 ctags 观察文件扩展名，如果扩展名对应`c++`，则扫描该文件。反之如果某个文件叫 aaa.py（python文件），则该文件不会被扫描。

* --langmap=c++:+.inl

告知 ctags，以 inl 为扩展名的文件是`c++`语言写的，在加之上述2中的选项，即要求 ctags 以`c+`+语法扫描以 inl 为扩展名的文件。

* -h +.inl

告知 ctags，把以inl为扩展名的文件看作是头文件的一种（inl文件中放的是inline函数的定义，本来就是为了被include的）。这样ctags在扫描inl文件时，就算里面有static的全局变量，ctags在记录时也不会标明说该变量是局限于本文件的。

* --c++-kinds=+px

记录类型为函数声明和前向声明的语法元素。

* --fields=+aiKSz

控制记录的内容。

* --extra=+q

让ctags额外记录一些东西。

* --exclude=lex.yy.cc --exclude=copy_lex.yy.cc

告知ctags不要扫描名字是这样的文件。还可以控制ctags不要扫描指定目录，这里就不细说了。

* -f tagfile

指定生成的标签文件名，默认是tags. tagfile指定为 - 的话，输出到标准输出。

### Tag文件的作用
一般用于编辑器的代码跳转和查找，比如vim 和emacs。

### Tag文件格式
ctags生成的tag格式: 

    {tagname}<Tab>{tagfile}<Tab>{tagaddress}

示例：

    main    main.c  /^main(argc, argv)$/



### Vim 中使用 ctags

vim 支持的tag文件格式：

    {tagname}<Tab>{tagfile}<Tab>{tagaddress}
    {tagname}<Tab>{tagfile}<Tab>{tagaddress}[;"<Tab>{tagfield}..]
    
* {tagname}
Any identifier, not containing white space..

EXCEPTION: Universal Ctags violates this item of the proposal; tagname may contain spaces. However, tabs are not allowed.

* <Tab>
Exactly one TAB character (although many versions of Vi can handle any amount of white space).

* {tagfile}
The name of the file where {tagname} is defined, relative to the current directory (or location of the tags file?).

* {tagaddress}
Any Ex command. When executed, it behaves like ‘magic’ was not set.   

#### vim 中配置 ctags
生成 tags 文件：

    ctags –R ∗
在 vim 中指定 tags 文件。通常手动指定，在 vim 命令行输入：

    :set tags=$PATH/tags
若要引用多个不同目录的tags文件，可以用逗号隔开或者设置在配置文件中。在 ~/.vimrc 加入一行：

    set tags=./tags;,tags
"./" 会被替换成当前编辑文件的文件夹。注意第一个 tags后面有一个分号，代表 “向上搜索”，你需要搜索tag的时候，它会首先在你当前文件所在的文件夹（不是当前文件夹）里面搜索名为 tags的文件，没有的话，往上一级目录，再没有的话，再往上一级目录，直到搜索到根目录为止。第二个tags才是代表在 “当前文件夹” 而不是 “当前文件所属的文件夹"里面搜索。


如果经常在不同工程里查阅代码，那么可以在 ~/.vimrc 中添加：

    set tags=tags;
    set autochdir
> 注意第一个命令里的分号是必不可少的。


在~/.vimrc中加入 set tags+=./tags 这样vim就可以用当前路径下的tag文件来定位和跳转了 具体跳转方式，在vim中查看文档 :h tags

#### vim 快捷键

    :ts or :tselect         shows the list
    :tn or :tnext           goes to the next tag in that list
    :tp or :tprev           goes to the previous tag in that list
    :tf or :tfirst          goes to the first tag of the list
    :tl or :tlast           goes to the last tag of the lis  

    vi –t tag               (请把tag替换为您欲查找的变量或函数名)
    Ctrl+](:ta name)        跳转到变量或函数的定义处
    Ctrl+o/t                返回到跳转前的位置       
       
### 如何使用？
例如查阅 Linux 的内核代码。

1. 在 Linux 的源码目录 `/opt/linux-5.1.9` 下输入命令 `ctags -R *` 创建 tags 文件，这个就是索引文件。
2. 向 vim 注册索引文件 tags 的路径。打开 ~/.vimrc 文件，添加一行：

    set tags=/opt/linux-5.1.9/tags
然后重新打开终端。
3. 用 vim 在任意目录写一个test.c文件，内容如下:
```C
int main(void)
{
    printf("HelloWorld!");
    return 0;
}
```
写好保存后回到正常模式，把光标停留在 printf 函数上， 然后按 `Ctrl＋]`，vim 会自动跳到 Linux 系统函数 printf() 处，这时我们能查看printf()的源码了。按 `Ctrl＋o/` 回到上一步。

