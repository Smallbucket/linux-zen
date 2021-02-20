# C语言

## C语言介绍

C是一种过程编程语言。它最初由丹尼斯·里奇（Dennis Ritchie）于1972年开发。它主要是作为用于编写操作系统的系统编程语言而开发的。C语言的主要功能包括对内存的低级访问，一组简单的关键字以及简洁的样式，这些功能使C语言适用于诸如操作系统或编译器开发之类的系统编程。

许多后来的语言都直接或间接地从C语言中借用了语法/功能。像Java，PHP，JavaScript和许多其他语言的语法一样，它们主要基于C语言。 C ++几乎是C语言的超集（很少有程序可以用C编译，而不能用C ++编译）。

##### 表：C 语言发展时间表

| 年份 |	C Standard |
| ---- | ------------- |
|1972|	Birth|
|1978|	K&R C|
|1989/1990|	ANSI C and ISO C and C89|
|1999|	C99|
|2011|	C11|
|2017|	C17|
|TBD|	C2x|


Benefits of C language

* As a middle-level language, C combines the features of both high-level and low-level languages. It can be used for low-level programming, such as scripting for drivers and kernels and it also supports functions of high-level programming languages, such as scripting for software applications etc.
* C is a structured programming language which allows a complex program to be broken into simpler programs called functions. It also allows free movement of data across these functions.
* Various features of C including direct access to machine level hardware APIs, the presence of C compilers, deterministic resource use and dynamic memory allocation make C language an optimum choice for scripting applications and drivers of embedded systems.
* C language is case-sensitive which means lowercase and uppercase letters are treated differently.
* C is highly portable and is used for scripting system applications which form a major part of Windows, UNIX, and Linux operating system.
* C is a general-purpose programming language and can efficiently work on enterprise applications, games, graphics, and applications requiring calculations, etc.
* C language has a rich library which provides a number of built-in functions. It also offers dynamic memory allocation.
* C implements algorithms and data structures swiftly, facilitating faster computations in programs. This has enabled the use of C in applications requiring higher degrees of calculations like MATLAB and Mathematica.

Riding on these advantages, C became dominant and spread quickly beyond Bell Labs replacing many well-known languages of that time, such as ALGOL, B, PL/I, FORTRAN, etc. C language has become available on a very wide range of platforms, from embedded microcontrollers to supercomputers.


## C程序的结构
经过以上讨论，我们可以正式评估C程序的结构。 通过结构，意味着任何程序都只能以这种结构编写。 因此，以任何其他结构编写C程序都将导致编译错误。

C程序的结构如下：

##### 表：C 语言程序结构

| 结构名称 | 代码示例 |
| --------- | ---------------------- |
| Header | #include <stdio.h> |
| main() | int main() <br>{ |
| Variable Declaration | &nbsp;&nbsp;&nbsp;&nbsp;int a = 10; |
| Body | &nbsp;&nbsp;&nbsp;&nbsp;printf("%d", a) |
| Return | &nbsp;&nbsp;&nbsp;&nbsp;return 0;<br>} |


结构说明：

1) 包含头文件：第一个也是最重要的组成部分是C程序中包含头文件。

头文件是扩展名为.h的文件，其中包含C函数声明和宏定义，这些声明将在多个源文件之间共享。

常用的一些C头文件：

* stddef.h –定义几个有用的类型和宏。
* stdint.h –定义精确的宽度整数类型。
* stdio.h –定义核心输入和输出功能
* stdlib.h –定义数字转换函数，伪随机网络生成器，内存分配
* string.h –定义字符串处理函数
* math.h –定义常见的数学函数

2) Main方法声明：C程序的下一部分是声明 `main()` 函数。

3) 变量声明：任何C程序的下一部分都是变量声明。 它指的是要在函数中使用的变量。请注意，在C程序中，未经声明就不能使用任何变量。同样，必须在函数中的任何操作之前声明变量。

4) 主体：C程序中函数的主体，指的是在函数中执行的操作。 它可以是诸如操纵，搜索，排序，打印等任何内容。

5) 返回语句：任何C程序的最后一部分是返回语句。 return语句是指从函数中返回值。 该返回语句和返回值取决于函数的返回类型。 例如，如果返回类型为void，则将没有return语句。 在任何其他情况下，将有一个return语句，并且返回值将是指定的返回类型的类型。

## C 语言的预处理器和宏
在C程序中，以＃开头的所有行均由预处理器处理，预处理器是由编译器调用的特殊程序。用一个非常基本的术语来说，预处理器使用一个C程序生成另一个没有任何＃的C程序。

C中预处理器的一些有趣事实：

1）当使用`include`指令时，包含的头文件（经过预处理）的内容被复制到当前文件中。尖括号`<`和`>`指示预处理器查看包含所有头文件的标准文件夹。 用双引`"`和`"`指示预处理器查看当前文件夹（当前目录）。

2）当我们对常量使用define时，预处理器会生成一个C程序，在其中搜索定义的常量，并将匹配的标记替换为给定的表达式。 


#### 简单的值替换
```C
#include<stdio.h>
#define max 100
int main()
{
  printf("max is %d", max);
  return 0;
}
```

#### 宏函数替换
只是简单的替换，不考虑语法
```C
#include <stdio.h>
#define INCREMENT(x) ++x
int main()
{
  char *ptr = "GeeksQuiz";
  int x = 10;
  printf("%s ", INCREMENT(ptr));
  printf("%d", INCREMENT(x));
  return 0;
}
```

替换时也不考虑原始结构
```C
#include <stdio.h>
#define MULTIPLY(a, b) a*b
int main()
{
  // The macro is expanded as 2 + 3 * 3 + 5, not as 5*8
  printf("%d", MULTIPLY(2+3, 3+5));
  return 0;
}
// Output: 16
```
宏定义改为以下声明就对了
```C
#define MULTIPLY(a, b) (a)*(b)
```

#### 字符串连接
使用 `##` 符号连接
```C
#include <stdio.h>
#define merge(a, b) a##b
int main()
{
  printf("%d ", merge(12, 34));
}

```

#### 转为字符串
```C
#include <stdio.h>
#define get(a) #a
int main()
{
  // GeeksQuiz is changed to "GeeksQuiz"
  printf("%s", get(GeeksQuiz));
}

```

#### 宏定义占用多行
```C
#include <stdio.h>
#define PRINT(i, limit) while (i < limit) \
                        { \
                          printf("GeeksQuiz "); \
                          i++; \
                        }
int main()
{
  int i = 0;
  PRINT(i, 3);
  return 0;
}
```

#### 使用内联函数代替有参数的宏函数      
定义有参数的宏函数，有时替换会出现问题。例如：
```C
#include <stdio.h>

#define square(x) x*x
int main()
{
  // Expanded as 36/6*6
  int x = 36/square(6); 
  printf("%d", x);
  return 0;
}
//36
```
输出的结果不是我们想要的，改为：
```C
#include <stdio.h>

static inline int square(int x) { return x*x; }
int main()
{
int x = 36/square(6);
printf("%d", x);
return 0;
}
//`
```

#### 带条件的宏
```C
int main()
{
#if VERBOSE >= 2
  printf("Trace Message");
#endif
}
```

#### 移除宏
```C
#include <stdio.h>
#define LIMIT 100
int main()
{
  printf("%d",LIMIT);
  //removing defined macro LIMIT
  #undef LIMIT
  //Next line causes error as LIMIT is not defined
  printf("%d",LIMIT);
  return 0;
}
//This code is contributed by Santanu
```

头文件可能被直接或间接包含多次，这导致重新声明相同变量/函数的问题。 为避免此问题，使用了诸如`define`，`ifdef`和`ifndef`之类的指令。

有一些标准宏可用于打印程序文件（`__FILE__`），编译日期（`__DATE__`），编译时间（`__TIME__`）和C代码中的行号（`__LINE__`）。
```C
#include <stdio.h>

int main()
{
  printf("Current File :%s\n", __FILE__ );
  printf("Current Date :%s\n", __DATE__ );
  printf("Current Time :%s\n", __TIME__ );
  printf("Line Number :%d\n", __LINE__ );
  return 0;
}
```

## C语言编译过程
编译器将C程序转换为可执行文件。 C程序成为可执行文件有四个阶段：

* 预处理(Pre-processing)
* 编译(Compilation)
* 汇编(Assembly)
* 链接(Linking)

通过执行以下命令，我们将获得当前目录中的所有中间文件以及可执行文件。
```SHELL
$ gcc –Wall –save-temps filename.c –o filename
```

### 预处理

这是从源代码编译的第一阶段，此阶段包括：

* 删除注释
* 扩展宏
* 扩展包含的文件。
* 条件编译

预处理的输出存储在filename.i中。在上面的输出中，源文件充满了很多信息，但是最后我们的代码得以保留。`#include<stdio.h>`之类的引用变成不很多代码，这表明头文件已经被展开了。

### 编译
下一步是编译 `filename.i` 并生成一个中间编译输出文件`filename.s`。 该文件在汇编级说明中。

### 汇编
在此阶段，将`filename.s`用作输入，并由汇编程序将其转换为`filename.o`。 该文件包含机器级别的说明。 在此阶段，仅将现有代码转换为机器语言，无法解析诸如printf（）之类的函数调用。 

### 链接
这是最后一个阶段，其中完成了所有函数调用及其定义的链接。 链接器知道所有这些功能的实现位置。 链接器还会做一些额外的工作，它会在程序中添加一些额外的代码，这些代码在程序开始和结束时都需要。 例如，有一个代码需要设置环境，例如传递命令行参数。 使用`$ size filename.o`和`$ size filename`可以轻松验证此任务。通过这些命令，我们知道输出文件如何从目标文件增加到可执行文件。这是因为链接器在我们的程序中添加了额外的代码。

## C 语言函数

函数是一组语句，这些语句接受输入，进行一些特定的计算并产生输出。

我们的想法是将一些通常或重复完成的任务放在一起，并创建一个函数，这样我们就可以调用该函数，而不是为不同的输入一次又一次地编写相同的代码。

函数语法：       
```C
    return_type function_name([ arg1_type arg1_name, ... ]) { code } 
```
我们为什么需要函数？

* 函数可帮助我们减少代码冗余。 如果函数是在软件中的多个位置执行的，则不是一次又一次地编写相同的代码，而是创建一个函数并在任何地方调用它。 这也有助于维护，因为如果将来对函数进行更改，则必须在一处进行更改。
* 函数使代码模块化。 考虑一个具有多行代码的大文件。 如果将代码划分为函数，那么阅读和使用代码将变得非常简单。
* 函数提供抽象。 例如，我们可以使用库函数而不必担心它们的内部工作。

### 函数声明
函数声明告诉编译器函数需要使用的参数数量，参数的数据类型和函数的返回类型。 在函数声明中将参数名称放在函数声明中是可选的，但有必要将其放入定义中。 始终建议在使用函数之前先声明一个函数（有关详细信息，请参见[此](https://www.geeksforgeeks.org/what-is-the-purpose-of-a-function-prototype/)，[此](https://www.geeksforgeeks.org/g-fact-95/)和[此](https://www.geeksforgeeks.org/importance-of-function-prototype-in-c/)）。

在C语言中，我们可以在同一位置进行声明和定义。C还允许分别声明和定义函数，这在库函数的情况下尤其需要。 库函数在头文件中声明，并在库文件中定义。 


### 函数的参数传递
传递给函数的参数称为实际参数。函数接收的参数称为形式参数。

有两种最流行的传递参数的方法。

* 按值传递：在这种参数传递方法中，将实际参数的值复制到函数的形式参数中，并将两种类型的参数存储在不同的存储位置中。 因此，函数内部所做的任何更改都不会反映在调用者的实际参数中。
* 按引用传递:实际参数和形式参数都指向相同的位置，因此在函数内部所做的任何更改实际上都会反映在调用者的实际参数中。

> C中的参数始终按值传递。

以下是有关C函数的一些重要点。
1）每个C程序都有一个名为main（）的函数，当用户运行该程序时，操作系统会调用该函数。

2）每个函数都有一个返回类型。如果函数不返回任何值，则将void用作返回类型。此外，如果函数的返回类型为void，我们仍然可以在函数定义的主体中使用return语句，方法是不指定常数，变量等，而只需提及“ return;”语句即可。

3）在C语言中，函数可以返回除数组和函数之外的任何类型。我们可以通过返回指向数组的指针或指向函数的指针来解决此限制。
4）C中的参数列表为空表示未指定参数列表，并且可以使用任何参数调用函数。
5）如果在C程序中，在声明函数之前调用了该函数，则C编译器将以以下方式自动采用该函数的声明：`int函数名称();`，在这种情况下，如果该函数的返回类型与INT不同，则编译器将显示错误。

### main 函数
main 函数是特殊函数。每个C程序都必须包含一个名为main的函数。它充当程序的入口点。 计算机将从`main` 函数开头开始运行代码。

main 函数允许传入参数，其作用是获取从命令行输入的值。当您将main函数与参数一起使用时，它将程序名之后的每组字符（用空格分隔）保存为名为argv的数组中的元素。
```C
int main(int argc, char * const argv[]) 
{ 
   ... 
   return 0; 
} 
```
由于main函数具有int的返回类型，因此程序员必须在代码中始终具有return语句。 返回的数字用于通知调用程序该程序执行的结果是什么。返回0表示没有问题。



## GCC 提供的一些额外特性

* Type Referencing with typeof

typeof运算符使您可以通过变量本身来引用变量的类型。 它类似于sizeof运算符，该运算符返回给定变量的大小（以字节为单位）。 考虑以下声明片段：
```C
int i;
typeof(i) j;
```

* Case Ranges

GCC允许在 switch语句的case中指定连续范围。
```C
int array1[8]={0, 0, 1, 1, 1, 2, 2, 2};

int array1[8]={[2 ... 4]=1, [5 ... 7]=2};
```
“...”两边的空格是必需的。

* Designated Initializers

标准C要求数组初始化完整且按顺序指定。 ISO C和GNU扩展允许指定数组并以任何顺序出现。例如，这两个初始化是相同的：
```C
int array1[8]={0, 0, 0, 3, 0, 5, 0, 0};

int array1[8]={[3]=3, [5]=5};
```

## 参考资料
[GNU's C Language Extensions](https://www.drdobbs.com/gnus-c-language-extensions/184401956)              
[C programming tutorial](https://linuxconfig.org/c-programming-tutorial)                 
[C Programming Language](https://www.geeksforgeeks.org/c-programming-language/)            

