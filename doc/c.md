
- [C语言](#c)        
  - [C语言介绍](#c_intro)       
  - 

# <a id="c">C语言</a>

## <a id="c_intro">C语言介绍</a>

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

### printf函数
`printf`函数是一个标准库函数，它的函数原型在头文件“stdio.h”中。`printf`称为格式输出函数，其关键字最末一个字母f即为“格式”(format)之意。其功能是按用户指定的格式，把指定的数据显示到显示器屏幕上。

`printf`函数调用的一般形式为：

    printf(“格式控制字符串”, 输出表列)
其中格式控制字符串用于指定输出格式。格式控制串可由*格式字符串*和*非格式字符串*两种组成。格式字符串是以%开头的字符串，在%后面跟有各种格式字符，以说明输出数据的类型、形式、长度、小数位数等。如：
* “%d”表示按十进制整型输出；
* “%ld”表示按十进制长整型输出；
* “%c”表示按字符型输出等。

非格式字符串原样输出，在显示中起提示作用。

### 格式字符串
在Turbo C中格式字符串的一般形式为：

    [标志][输出最小宽度][.精度][长度]格式字符。

**表:格式字符**

|格式字符|	意义    |
|----|-------------------|
|d	|以十进制形式输出带符号整数(正数不输出符号)|
|o	|以八进制形式输出无符号整数(不输出前缀0)|
|x,X	|以十六进制形式输出无符号整数(不输出前缀Ox)|
|u	|以十进制形式输出无符号整数|
|f	|以小数形式输出单、双精度实数|
|e,E	|以指数形式输出单、双精度实数|
|g,G	|以%f或%e中较短的输出宽度输出单、双精度实数|
|c	|输出单个字符|
|s	|输出字符串|
|p  |pointer, void \*, implementation-dependent, standard between Linux distros|

**表:标志**

|标 志|  意义  |
|----|----------------|
|-	|结果左对齐，右边填空格|
|+	|输出符号(正号或负号)|
|空格|输出值为正时冠以空格，为负时冠以负号|
|#	|对c、s、d、u类无影响；对o类，在输出时加前缀o；对x类，在输出时加前缀0x；对e、g、f 类当结果有小数时才给出小数点。|

输出最小宽度:用十进制整数来表示输出的最少位数。若实际位数多于定义的宽度，则按实际位数输出，若实际位数少于定义的宽度则补以空格或0。

精度:精度格式符以“.”开头，后跟十进制整数。本项的意义是：如果输出数字，则表示小数的位数；如果输出的是字符，则表示输出字符的个数；若实际位数大于所定义的精度数，则截去超过的部分。

长度:长度格式符为h、l两种，h表示按短整型量输出，l表示按长整型量输出。
```C
#include <stdio.h>
int main(void){
   int a=15;
   float b=123.1234567;
   double c=12345678.1234567;
   char d='p';
   printf("a=%d\n", a);
   printf("a(%%d)=%d, a(%%5d)=%5d, a(%%o)=%o, a(%%x)=%x\n\n",a,a,a,a);  // %% 可以输出 %
   printf("a=%f\n", b);
   printf("b(%%f)=%f, b(%%lf)=%lf, b(%%5.4lf)=%5.4lf, b(%%e)=%e\n\n",b,b,b,b);
   printf("c=%f\n", c);
   printf("c(%%lf)=%lf, c(%%f)=%f, c(%%8.4lf)=%8.4lf\n\n",c,c,c);
   printf("d=%c\n", d);
   printf("d(%%c)=%c, d(%%8c)=%8c\n",d,d);
   return 0;
}
```

### sprintf函数
`sprintf`函数用于将格式化的数据写入字符串，其原型为：

    int sprintf(char *str, char * format [, argument, ...]);

参数:
* str为要写入的字符串；
* format为格式化字符串，与printf()函数相同；
* argument为变量。

除了前两个参数类型固定外，后面可以接任意多个参数。而它的精华，显然就在第二个参数格式化字符串上。 

`printf()`和`sprintf()`都使用格式化字符串来指定串的格式，在格式串内部使用一些以“%”开头的格式说明符（format specifications）来占据一个位置，在后边的变参列表中提供相应的变量，最终函数就会用相应位置的变量来替代那个说明符，产生一个调用者想要的字符串。

`sprintf()`最常见的应用之一莫过于把整数打印到字符串中，如：

    sprintf(s, "%d", 123);  //把整数123打印成一个字符串保存在s中
    sprintf(s, "%8x", 4567);  //小写16进制，宽度占8个位置，右对齐

`sprintf`的作用是将一个格式化的字符串输出到一个目的字符串中，而`printf`是将一个格式化的字符串输出到屏幕。`sprintf`的第一个参数应该是目的字符串，如果不指定这个参数，执行过程中出现 "该程序产生非法操作,即将被关闭...."的提示。
```C
#include <stdio.h>
main()
{
    char a = 'a';
    char buf[80];
    sprintf(buf, "The ASCII code of a is %d.", a);
    printf("%s", buf);
}
```

sprintf()会根据参数format 字符串来转换并格式化数据，然后将结果复制到参数str 所指的字符串数组，直到出现字符串结束('\0')为止。关于参数format 字符串的格式请参考printf()。

返回值：成功则返回参数str 字符串长度，失败则返回-1，错误原因存于errno 中。

## 指针
指针是一个变量，其值为另一个变量的地址，即，内存位置的直接地址。

指针变量声明的一般形式为：

    type *var-name;
例如：
```C
int    *ip;    /* 一个整型的指针 */
double *dp;    /* 一个 double 型的指针 */
float  *fp;    /* 一个浮点型的指针 */
char   *ch;    /* 一个字符型的指针 */
```
所有实际数据类型，不管是整型、浮点型、字符型，还是其他的数据类型，对应指针的值的类型都是一样的，都是一个代表内存地址的长的十六进制数。

不同数据类型的指针之间唯一的不同是，指针所指向的变量或常量的数据类型不同。

### 如何使用指针？
使用指针时会频繁进行以下几个操作：定义一个指针变量、把变量地址赋值给指针、访问指针变量中可用地址的值。这些是通过使用一元运算符 \* 来返回位于操作数所指定地址的变量的值。下面的实例涉及到了这些操作：
```C
#include <stdio.h>
 
int main ()
{
   int  var = 20;   /* 实际变量的声明 */
   int  *ip;        /* 指针变量的声明 */
 
   ip = &var;  /* 在指针变量中存储 var 的地址 */
 
   printf("var 变量的地址: %p\n", &var  );
 
   /* 在指针变量中存储的地址 */
   printf("ip 变量存储的地址: %p\n", ip );
 
   /* 使用指针访问值 */
   printf("*ip 变量的值: %d\n", *ip );
 
   return 0;
}
```
C 中的 NULL 指针
在变量声明的时候，如果没有确切的地址可以赋值，为指针变量赋一个 NULL 值是一个良好的编程习惯。赋为 NULL 值的指针被称为空指针。

NULL 指针是一个定义在标准库中的值为零的常量。请看下面的程序：
```C
#include <stdio.h>
 
int main ()
{
   int  *ptr = NULL;
 
   printf("ptr 的地址是 %p\n", ptr  );
 
   return 0;
}
```
在大多数的操作系统上，程序不允许访问地址为 0 的内存，因为该内存是操作系统保留的。然而，内存地址 0 有特别重要的意义，它表明该指针不指向一个可访问的内存位置。但按照惯例，如果指针包含空值（零值），则假定它不指向任何东西。

如需检查一个空指针，您可以使用 if 语句，如下所示：
```C
if(ptr)     /* 如果 p 非空，则完成 */
if(!ptr)    /* 如果 p 为空，则完成 */
```

### 指针的算术运算
指针是一个用数值表示的地址。因此，可以对指针进行四种算术运算：++、--、+、-。
* 指针的每一次递增，它其实会指向下一个元素的存储单元。
* 指针的每一次递减，它都会指向前一个元素的存储单元。
* 指针在递增和递减时跳跃的字节数取决于指针所指向变量数据类型长度，比如 int 就是 4 个字节。

例子：
```C
#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int  i, *ptr;
 
   /* 指针中第一个元素的地址 */
   ptr = var;
   i = 0;
   while ( ptr <= &var[MAX - 1] )
   {
 
      printf("存储地址：var[%d] = %p\n", i, ptr );
      printf("存储值：var[%d] = %d\n", i, *ptr );
 
      /* 指向上一个位置 */
      ptr++;
      i++;
   }
   return 0;
}
```
### 指针数组
指针数组是指让数组存储指向 int 或 char 或其他数据类型的指针。

例子：
```C
#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int i, *ptr[MAX];
 
   for ( i = 0; i < MAX; i++)
   {
      ptr[i] = &var[i]; /* 赋值为整数的地址 */
   }
   for ( i = 0; i < MAX; i++)
   {
      printf("Value of var[%d] = %d\n", i, *ptr[i] );
   }
   return 0;
}
```

### 指向指针的指针
指向指针的指针是一种多级间接寻址的形式，或者说是一个指针链。通常，一个指针包含一个变量的地址。当我们定义一个指向指针的指针时，第一个指针包含了第二个指针的地址，第二个指针指向包含实际值的位置。

声明时在变量名前放置两个星号。例如，下面声明了一个指向 int 类型指针的指针：

    int **var;
例子：
```C
#include <stdio.h>
 
int main ()
{
   int  V;
   int  *Pt1;
   int  **Pt2;
 
   V = 100;
 
   /* 获取 V 的地址 */
   Pt1 = &V;
 
   /* 使用运算符 & 获取 Pt1 的地址 */
   Pt2 = &Pt1;
 
   /* 使用 pptr 获取值 */
   printf("var = %d\n", V );
   printf("Pt1 = %p\n", Pt1 );
   printf("*Pt1 = %d\n", *Pt1 );
   printf("Pt2 = %p\n", Pt2 );
   printf("**Pt2 = %d\n", **Pt2);
 
   return 0;
}

```

### 传递指针给函数
传递指针给函数，只需要简单地声明函数参数为指针类型即可。
例子：
```C
#include <stdio.h>
#include <time.h>
 
void getSeconds(unsigned long *par);

int main ()
{
   unsigned long sec;


   getSeconds( &sec );

   /* 输出实际值 */
   printf("Number of seconds: %ld\n", sec );

   return 0;
}

void getSeconds(unsigned long *par)
{
   /* 获取当前的秒数 */
   *par = time( NULL );
   return;
}
```

能接受指针作为参数的函数，也能接受数组作为参数，如下所示：
```C
#include <stdio.h>
 
/* 函数声明 */
double getAverage(int *arr, int size);
 
int main ()
{
   /* 带有 5 个元素的整型数组  */
   int balance[5] = {1000, 2, 3, 17, 50};
   double avg;
 
   /* 传递一个指向数组的指针作为参数 */
   avg = getAverage( balance, 5 ) ;
 
   /* 输出返回值  */
   printf("Average value is: %f\n", avg );
   
   return 0;
}

double getAverage(int *arr, int size)
{
  int    i, sum = 0;      
  double avg;          
 
  for (i = 0; i < size; ++i)
  {
    sum += arr[i];
  }
 
  avg = (double)sum / size;
 
  return avg;
}
```
### 从函数返回指针
函数返回指针必须声明一个返回指针的函数:
```C
int * myFunction()
{

}
```
C 语言不支持在调用函数时返回局部变量的地址，除非定义局部变量为 static 变量。
* 因为局部变量是存储在内存的栈区内，当函数调用结束后，局部变量所占的内存地址便被释放了，因此当其函数执行完毕后，函数内的变量便不再拥有那个内存地址，所以不能返回其指针。
* 除非将其变量定义为 static 变量，static 变量的值存放在内存中的静态数据区，不会随着函数执行的结束而被清除，故能返回其地址。

例子：
```C
#include <stdio.h>
#include <time.h>
#include <stdlib.h> 
 
/* 要生成和返回随机数的函数 */
int * getRandom( )
{
   static int  r[10];
   int i;
 
   /* 设置种子 */
   srand( (unsigned)time( NULL ) );
   for ( i = 0; i < 10; ++i)
   {
      r[i] = rand();
      printf("%d\n", r[i] );
   }
 
   return r;
}
 
/* 要调用上面定义函数的主函数 */
int main ()
{
   /* 一个指向整数的指针 */
   int *p;
   int i;
 
   p = getRandom();
   for ( i = 0; i < 10; i++ )
   {
       printf("*(p + [%d]) : %d\n", i, *(p + i) );
   }
 
   return 0;
}
```

## GCC 提供的一些扩展特性

* Type Referencing with typeof

typeof运算符使您可以通过变量本身来引用变量的类型。 它类似于sizeof运算符，该运算符返回给定变量的大小（以字节为单位）。 考虑以下声明片段：
```C
int i;
typeof(i) j;
```
创建一个名为i的整数变量，然后使用typeof创建了一个与i变量类型相同的新变量j。

以下示例中使用typeof声明了一个局部变量作为临时交换变量，并引用了一个宏参数。 该例程可用作在任何算术类型（char，int，float，unsigned int等）上运行的通用交换函数。 否则，每种基本类型都需要多个功能。
```C
#define swap( x, y )		   \
        ({ typeof(x) temp  = (x);  \
           x = y; y = temp;	   \
        })
```

* Case Ranges

GCC允许在 switch语句的case中指定连续范围。
```C
char ch;
 ...
switch( ch ) {
  case 'a' ... 'z':
    printf("lowercase\n"); break;
  case '0' ... '9':
    printf("number\n"); break;
}
```


* Designated Initializers

标准C要求数组初始化完整且按顺序指定。 ISO C和GNU扩展允许指定数组并以任何顺序出现。例如，这两个初始化是相同的：
```C
int array1[8]={0, 0, 0, 3, 0, 5, 0, 0};

int array1[8]={[3]=3, [5]=5};
```

初始化也可以使用范围来完成（如case语句所示）。 这些示例是相同的：
```C
int array1[8]={0, 0, 1, 1, 1, 2, 2, 2};

int array1[8]={[2 ... 4]=1, [5 ... 7]=2};
```
“...”两边的空格是必需的。

* Variable-Length Arrays

GCC允许使用非常量表达式声明数组。 在ISO C99中可行，但在C89中则不可行。 典型的数组声明具有以下形式：
```C
int array[ 10 ];
```

但也可以指定非恒定长度，例如：
```C
int array [func（）];
```

其中数组的大小是func的返回值。 也可以将非恒定大小数组声明为函数的参数。 例如：
```C
void check（int len，int array [len]）
```

创建一个可变长度数组，其长度基于参数列表的第一个参数。

* Zero-Length Arrays

标准C要求所有数组至少包含一个元素，但是在GNU C中，您可以声明零长度数组。 这在需要动态调整数组大小的应用程序中非常有用。 
例如：
```C
typedef struct {
  int len;
  char data[0];
} payload_t;

payload_t *getPayload( int len )
{
  payload_t *payload = (payload_t *)0;

  payload = (payload_t *)malloc( sizeof(payload_t) + len );
  if (payload) payload->len = len;

  return payload;
}
```


## Using Attributes使用属性
使用属性，可以指示编译器根据所使用的属性来特别对待函数或变量。传统上，属性已用于标识中断处理程序或强制命名部分中的函数。但是GNU提供了其他一些有用的功能和变量属性。

* Inline control(内联控制)。

内联函数是帮助提高应用程序性能的常用技术。通过避免调用/返回指令和附加的帧管理，可以提高性能。给定功能大小阈值（并启用了适当的优化级别），GCC可以自动执行此操作，但是在某些情况下，您确切知道要内联什么以及不应该内联什么。为此，可以使用属性noinline和always_inline。

指定每个属性是通过函数原型执行的：
```C
void smallFunction( void ) __attribute__ 
  ((always_inline));

void largeFunction( void ) __attribute__ 
  ((noinline));
```

也可以使用内联函数修饰符，但需要启用优化。无论是否启用优化，这些属性都在功能上显式起作用。

* Warning of Unused Return Value Usage(未使用返回值使用情况的警告)。

每当使用函数属性warn_unused_result忽略函数的返回值时，都可以指示编译器发出警告。指定为：
```C
int getTemperature( int sensor) 
__attribute__ ((warn_unused_result));
```

随后，编译器将在编译阶段为任何不使用返回值的调用方生成警告消息。

功能参数为空的警告。使用函数属性和编译器选项，可以指示编译器在函数传递了NULL参数时发出警告。您可以使用nonnull函数属性和参数列表来指定哪些参数不能为NULL。在此示例中，可能不会为第一个或第二个参数传递NULL：
```C
int sendPacket( void *header, void *payload, int payload_len )
   __attribute__ ((nonnull (1, 2)));
```

为了进行此检查，必须在编译器中启用警告选项-Wnonnull。

* Mapping Functions to Sections(将函数映射到节)。
 
默认情况下，所有函数都映射到一个称为文本的部分。有时有必要创建可以将函数映射到的新部分。嵌入式域中的一个示例是函数路径功能到缓存内存的映射，非函数功能到未缓存内存的映射。第一步是确定将放置这些函数的部分。这是通过section函数属性完成的：
```C
int routePacket( packet_t *packet )
   __attribute__ ((section ("fastpath")));
```

这会将功能routePacket放入称为fastpath的部分中。然后，可以使用GNU链接程序将此部分映射到具有所需属性的特定内存区域。

* Mapping Variables to Sections(将变量映射到节)。

您还可以更改变量的默认部分，如功能所示。尽管编译器会将变量放在data节或bss（未初始化的数据）节中，但在某些情况下，您需要提供进一步的映射。例如，如果在性能路径中使用了数据，则需要将其映射到缓存的区域。对于DMA引擎使用的数据，您需要一个未缓存的区域。将变量映射到节类似于函数映射：
```C
taskList_t *taskList
   __attribute__ ((section ("cached"))) = (taskList_t *)0;
```

请注意，在此示例中，变量初始化遵循属性规范。然后，您可以依靠链接器使用链接器脚本将这些部分放在其适当的内存HASH（0x80bdec）中。

## Function Hooks(钩子函数)

GCC可以出于各种目的将钩子插入应用程序。我在这里查看三种此类用途。

* Instrument Functions(工具函数)。

一个有趣的GCC扩展是对函数的选择性检测，以在运行时识别其进入和退出点。这可以提供正在运行的应用程序的地址调用跟踪，以及一些其他工具，函数名称和行号信息。

首先，GNU提供了钩子，可以在以下情况下捕获捕获的函数：
```C
void __cyg_profile_func_enter 
   ( void *func_address, void *call_site );

void __cyg_profile_func_exit  
   ( void *func_address, void *call_site );
```

在每种情况下，`func_address`参数都是正在输入或正在退出的函数的地址。可以在映射文件中找到给定可执行文件的地址。 `call_site`变量是调用函数的地址（用于_enter）或函数返回的地址（在_exit情况下）。为此，您可以将func_address用于简单的调用跟踪。

要启用功能检测，请使用`-finstrument-functions`编译源文件（与-g一起使用，以确保存在调试数据）：

    gcc -g -o test test.c -finstrument-functions

您可以通过提供或省略`instrument-functions`选项来定义哪些文件具有检测功能，哪些文件没有检测功能。您也可以在已指定工具功能的文件中有选择地禁用该功能的工具。

如下示例中要注意的第一件事是分析函数的属性规范。在这种情况下，您指示编译器不要执行此功能（这将导致递归分析）。性能分析功能（仅适用于入门案例）仅将功能的地址发送到stdout。接下来，创建一些函数来说明样本跟踪。
```C
  #include <stdio.h>

  void __cyg_profile_func_enter( void *, void * )
         __attribute__ ((no_instrument_function));

  void __cyg_profile_func_enter(void *this, void *callsite)
  {
    printf("%p\n", (int)this);
  }


  void func_c( void )
  {
    return;
  }

  void func_b( void )
  {
    func_c();

    return;
  }

  void func_a( void )
  {
    func_b();

    return;
  }


  int main()
  {
    func_a();
    func_c();
  }
```

如果现在运行此应用程序，则结果是打印到stdout的地址流，这并不完全有用。您可以使用addr2line实用程序增加其值，该实用程序可以获取图像和地址并将其转换为函数名称和源代码行号。要获取地址流并将其与addr2line实用程序一起使用，请使用xargs将应用程序的输出作为addr2line的命令行参数进行定向；如下示例中，您现在看到addr2line生成的输出。由检测的应用程序发出的每个地址都转换为函数名称以及该函数文件中的源行。这表示使用简单功能和单个标志启用的示例应用程序的调用跟踪。只需多做一些工作，就可以生成调用树。
```C
$ ./instrument | xargs addr2line -e instrument -f
main
/home/mtj/gnu-ext/instrument.c:33
func_a
/home/mtj/gnu-ext/instrument.c:25
func_b
/home/mtj/gnu-ext/instrument.c:18
func_c
/home/mtj/gnu-ext/instrument.c:13
func_c
/home/mtj/gnu-ext/instrument.c:13
$
```

* Wrapping Functions(包装函数)。

使用GNU的内置函数，您可以将现有的函数调用与您自己的函数包装在一起，同时保留参数列表和返回值。三个内置函数提供此功能：
```C
void *__builtin_apply_args();

void *__builtin_apply( void (*func)(), void *args, size_t size );

void *__builtin_return( void *result );
```

`__builtin_apply_args`函数返回传递给该函数的参数列表的空指针。 `__builtin_apply`函数应用保存在args中的参数（来自`__builtin_apply_args`）并将其传递给函数func。 size参数用于计算压入堆栈的数据量。最后，`__ builtin_return`将值从`__builtin_apply`返回到原始调用方。

以下示例中`printf`调用由一个名为`newprintf`的新函数包装。函数newprintf接受格式字符串和变量参数列表（由椭圆“ ...”指示）。使用内置函数，您可以确定参数列表，将其应用于要包装的函数（printf），然后针对原始调用者调整包装函数的返回值。
```C
  #include <stdio.h>

  int newprintf( char *fmt, ... )
  {
    void *args, *ret;

    args = __builtin_apply_args();
    ret = __builtin_apply( (void *)printf, args, 1024 );

    __builtin_return( ret );
  }

  int main()
  {
    newprintf( "A %s of the new %s function.\n", "test", "printf" );
    return 0;
  }
```

* Main Function Constructor/Destructor(Main函数的构造函数/析构函数)。

您可以使用C扩展为主要函数提供类似于构造函数和析构函数的函数。这些由两个特殊的函数属性提供，分别称为构造函数和析构函数。通过将构造函数属性应用于函数，可以在C程序的主函数之前调用该函数。相反，使用析构函数功能属性，在C应用程序退出时，将调用析构函数。这些功能可以创建为：
```C
void myConstructor( void ) __attribute__ ((constructor));

void myDestructor( void ) __attribute__ ((destructor));
```


## 参考资料
[GNU's C Language Extensions](https://www.drdobbs.com/gnus-c-language-extensions/184401956)              
[C programming tutorial](https://linuxconfig.org/c-programming-tutorial)                 
[C Programming Language](https://www.geeksforgeeks.org/c-programming-language/)            
[C 语言教程](https://www.runoob.com/cprogramming/c-tutorial.html)             

