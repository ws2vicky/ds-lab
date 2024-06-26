#import "template.typ": *

= 绪论 <sum:chapter>

本书文本及配套代码的开源网站：https://github.com/ClazyChen/ds-lab。

作为一本新的《数据结构》教材和实验指导书，本书的目标是帮助读者掌握数据结构的基本概念和常用算法，以及如何用C++语言实现它们。本书的特点是：

+ 本书详细介绍了各种数据结构和算法的原理和设计思想，帮助读者理解数据结构和算法的本质，而不是仅仅学会使用它们。对于正在准备考试的读者，本书能够有效减少应对闭卷考试所需要的记忆量，是一本很好的复习资料。
+ 本书发扬了工程学科特色，设计了大量的数据结构实验，并为每个实验搭建了用户友好的实验环境。在经典教材中通过理论推导引出的结果，本书总是以实验的方式进行验证。读者可以很方便地根据自己的理解修改实验代码，在训练自己编程能力的同时加深对数据结构和算法的理解。
+ 本书提供了完整的、可运行的代码，读者可以使用GCC、Clang或MSVC（推荐使用Visual Studio 2022）直接编译代码。对编程不感兴趣、只想学习数据结构和算法的读者，可以直接跳过代码部分。观察、理解代码运行的结果，也足以对数据结构的理论学习起到很好的辅助作用。
+ 本书的所有数据结构和算法都是用C++20 @gregoire2021professional 实现的，而且是用现代C++的编程范式实现的。这些范式包括：面向对象编程、泛型编程、函数式编程、元编程等（考虑到GCC和Clang目前的支持程度，没有采用模块化编程）。这些范式是现代C++的核心特性，也是C++与其他编程语言的重要区别。对编程感兴趣的读者可以从本书中学到现代C++的编程方法，提高自己的编程能力。

== 对象  <sum:object>
本书采用现代C++的编程范式 @gregoire2021professional。
作为一门面向对象编程（Object Oriented Programming，OOP）的编程语言，C++程序总是从类和对象起步。我们从定义`Object`类作为本书中所有数据结构和算法的基类开始。

```cpp
// Object.hpp
#pragma once
#include <string>
namespace dslab::framework {
    class Object {
    public:
        virtual std::string type_name() const {
            return "Undefined Object Name";
        }
    };
}
```


#graybox[【C++学习】#linebreak()
#h(2em)
本书中关于C++的部分，以灰色背景的方块展示，以方便读者将这些部分和数据结构知识作区分。本书将默认读者了解C++的基本知识 @吴文虎2017程序设计基础 @郑莉2020C。

本书采用和Java相似的命名规则。头文件后缀名采用`.hpp`，每个公共类的实现放在与其同名的`.hpp`文件中，同一个命名空间的所有类放在同一个目录下，目录的路径为命名空间的名称。比如，上面的文件位于`dslab/framework/Object.hpp`，其中`dslab`为母空间，`framework`为子空间，`Object`为类名。@sum:chapter 里的所有头文件都会位于`dslab/framework`目录下，类似地，本章的实验都会位于`lab/framework`目录下。介绍实验时会用#bluetxt[蓝色黑体字]高亮标注其所在文件，读者可以按照自己的习惯进行实验。
在`Object`类中，我们定义了一个用于输出类名的虚函数。这个函数在后面的章节中会被重载，用于输出各个数据结构和算法的名称。

为了方便引入整个子命名空间内的类，在`dslab`文件夹下，我们加入了一个`framework.hpp`文件，用于导入`dslab::framework`命名空间。该文件的内容如下：

```cpp
// framework.hpp
#pragma once
#include "framework/Object.hpp"
namespace dslab {
    using namespace framework;
}
```

#h(2em)#bluetxt[实验`case.cpp`。]当一个包含了`framework.hpp`的文件需要使用上面定义的类`dslab::framework::Object`时，如果它在`dslab`命名空间下，就可以直接使用`Object`作为类名；如果它在`dslab`命名空间之外，则可以使用`dslab::Object`作为类名，或者`using namespace dslab`之后，使用`Object`作为类名。
]

// 在旧标准C++中，通常在头文件（.h）里写定义，而在源文件（.cpp）里写实现。C++20里引入了*模块*（module）的概念，用模块接口文件（.ixx）代替头文件。模块的引入大大提高了大型C++项目的编译速度，因为相同的模块只需要编译一次，而被不同源文件`#include`的同一个头文件会引入大量的重复编译工作。本书中的所有代码都使用模块。

// 在上述文件的开始，我们通过`export module`语句指定了模块的名称。本书采用了和Java一样的命名规则，将模块名和文件名保持一致。模块接口文件的名称是`Object.ixx`，位于Framework目录下，因此模块名是`Framework.Object`。本书定义的所有内容定义在命名空间`dslab`下，因此，我们总是采用`export namespace dslab`的方式导出`dslab`中的所有内容。如果我们需要导出特定的类或函数，则需要将关键字`export`移动到对应的类或函数之前。

// `Object`类本身的内容平平无奇。我们仅仅定义了一个虚函数用于输出类名。这个函数在后面的章节中会被重载，用于输出各个数据结构和算法的名称。

// 当我们需要使用`Object`类时，只需要在源文件中`import`它即可。下面是一个使用`Object`类的例子：

// ```cpp
// import Framework.Object;
// import std;
// using namespace std;
// dslab::Object obj;
// int main() {
//     cout << obj.type_name() << endl;
//     return 0;
// }
// ```

// #h(2em)
// 在源文件（.cpp）中，可以通过`import`关键字来导入定义的模块。特别地，`import std`可以一次性引入整个C++的标准库。_一次性引入整个标准库看起来很吓人，但在模块的支持下，它比旧标准C++里单独`include`每个头文件更快。_
// 类似于其他高级语言，我们可能希望`import Framework`提供一次性引入模块`Framework`中所有子模块的功能。此时，我们可以建立一个新的模块接口文件，用来实现这个功能。

// ```cpp
// // Framework.ixx
// export module Framework;
// export import Framework.Object;
// ```

// #h(2em)
// 其中，混合使用`export import`表示，将子模块`Framework.Object`导入之后，作为亲模块`Framework`的一部分导出。未来增加其他的子模块，只需要在Framework.ixx里增加对应的一行，就能使其一并作为`Framework`的一部分被导出。

== 数据结构 <sum:ds>

=== 数据结构的定义 <sum:ds:definition>

*数据结构*（data structure）是什么？这是一个很多初学者都不会思考的问题。简单期间，可以把“数据结构”这个词拆分为“数据”和“结构”，即：数据结构是计算机中的数据元素以某种结构化的形式组成的集合。

您可能会觉得这种定义过于草率，或者和在教材上看到的定义不同。这是因为计算机是一门工程学科，对于不涉及工程实现的问题，都不存在标准化的定义。比如，“数据结构”和“算法”，甚至“计算机”这样的基本概念，都不存在标准化的定义。一些教材会把算盘甚至算筹划归“计算机”的范畴，并把手工算法（如尺规作图，甚至按照菜谱烹饪食物）划归“算法”的范畴@邓俊辉2013数据结构。这种概念和定义的争议在计算机领域广泛存在，它主要来自以下几个原因：

+ 为了叙述简便，有些概念会借用一个已经存在的专有名词，从而引发歧义。如*树*（tree）这个词在计算机领域就有常用但迥然不同的两个概念。图论中的“树”出现得比较早，但没有人愿意将工程界经常出现的“树”称为“有限有根有序有标号的树” @knuth1968art ——英文里这些词并不能缩写为“四有树”。
+ 研究人员各执一词，从而引发歧义。这个现象的典型例子是“计数时从0开始还是从1开始”。从0开始经常能造成数学上的间接性，避免一些公式出现突兀的“+1”余项 @邓俊辉2013数据结构 ；但从1开始计数更符合自然习惯 @严蔚敏1997数据结构 。这个问题直接导致在有些问题（如“树的高度”）上，不同教材的说法不同。
+ 随着计算机领域的快速发展，一些概念的含义会发生变化。如众所周知，*字节*（byte）表示8个二进制位；但在远古时代，不同计算机采用的“字节”定义互不相同，有些计算机甚至是十进制的，那个时候一个字节可能表示2个十进制位 @knuth1968art。
+ 受计算机科学家的意识形态影响，同一概念的用词有所不同。如“树上的上层邻接和下层邻接节点”这一概念，现在普遍使用的词是parent和child；但思想保守的学者可能还在用father和son @reingold1981tidier，进步主义者则可能会用mother和daughter @blackburn1994linguistics。
+ 计算机领域的大多数成果来自英文文献。在将英文翻译为中文时，不同译者可能采用不同的译法。如robustness有音译的*鲁棒性* @王红梅2005数据结构 和意译的*健壮性* @彭波2002数据结构，hash有音译的*哈希* @严蔚敏1997数据结构 和意译的*散列* @邓俊辉2013数据结构。
+ 从业人员为了销售产品或取得投资，存在滥用、炒作部分计算机概念的情况。如“人工智能”“大数据”“云计算”“区块链”“元宇宙”“大模型”等概念是这个现象的重灾区。

#h(2em)
对于理解概念的专业人员来说，不同的定义方式总是能导出相同的工程实现。对于初学者而言，则需要更加简明、精准、切中要害的定义。因此，试图枚举所有的定义方式，是百害而无一利的教材写法；试图找出一个“正确的”定义，也是百害而无一利的学习方法。本书会将书中的定义和一些经典的教材进行比较 @邓俊辉2013数据结构 @严蔚敏1997数据结构 。对使用其他参考书籍备考的读者，希望您能在理解概念的基础上，自行分析和比较不同教材的定义。

=== 有限性和互异性 <sum:ds:finite>

关于数据结构，我们需要认识到：
数据结构是计算机中的数据元素以某种结构化的形式组成的集合。

数据结构中的数据是存储在*计算机*中的数据。在解题时，往往会在纸上画出数据结构的图形，这是为了让自己更好地理解数据在计算机中的组织方式，并非数据结构能够脱离具体的计算机而存在。
计算机中的数据和纸上的数据会有很多的不同，
不同的计算机所支持的数据结构也有所差异。比如，计算机处理数据时存在大小不一的高速缓存（cache，参见《组成原理》），这会使算法的局部性对算法性能造成重大影响。

本书中提到的计算机都是二进制计算机，这意味着数据结构的数据元素总是一个二进制数码串。程序会将这些二进制数据转换为有意义的数据类型，比如`char`、`int`、`double`或某个自定义的类。因为一台计算机存储的二进制串不能无限长，所以讨论整数或浮点数组成的数据结构时，其元素的真正取值范围并不会是数学上的$ZZ$或者$RR$。另一方面，数据结构的*规模*，即存放的元素个数，也是有限的。

通常情况下，一个数据结构中的数据元素具有相同的类型，比如，一个数据结构不能既存储`int`又存储`std::string`。一些情况下，编程者可能希望元素具有多个可能的类型（`std::variant`），甚至希望元素是任意类型的（`std::any`）。这种特殊的情况更多地被视为一种_编程技巧_，而非_数据结构_中研究的理论问题。#linebreak()
#graybox[
【C++学习】#linebreak()
#h(2em)#bluetxt[实验`voa.cpp`。]C++标准库提供的一些*容器*模板，实际上是一些数据结构的封装。这些容器模板的第一个模板参数通常就是数据结构中的元素类型，比如`std::vector<int>`表示元素是`int`类型的一个向量（见 @vec:chapter）。如果用户希望表示任意类型的元素组成的向量，可以使用`std::vector<std::any>`。在访问一个具体元素的时候，需要使用`std::any_cast<T>`来将其转换成实际的元素类型`T`。这种方法相比于C语言的`void*`具有类型安全的优点。

但是，`std::vector<std::any>`也可以看成是`std::any`类型的元素组成的向量。从向量的角度看，`std::any`和某个特定的数据类型（比如`int`）没有不同，甚至不需要做模板*特化*（specialization）。因此在数据结构的视角下，不需要考虑元素具有多个可能类型的情况。
]

在计算机中不可能存在两个完全_相同_（注意不是相等）的数据，因为至少它们的_地址_不同。所以，数据结构中的元素互不相同，组成了一个*集合*。这种互异性是算法设计和实现中需要注意的。比如，如果将序列$(a_1,b,c)$修改为了$(a_2,b,c)$，其中$a_1$和$a_2$的值相同、地址不同，看起来好像修改前后这个序列没有什么区别，但实际上可能会引起内存泄漏等严重错误。

=== 数据结构的实现 <sum:ds:implementation>

回到数据结构的实现中来：继承上一节中实现的`Object`，设计一个数据结构的基类。作为数据结构这一概念的抽象，需要从数据结构的定义中挖掘共性。

+ 数据结构总是存储相同的类型。对于支持泛型编程的C++来说，我们可以使用模板参数作为数据结构中的元素类型。
+ 数据结构是有限多个元素组成的，因此任何数据结构都具有`size`方法。

#graybox[【C++学习】#linebreak()
#h(2em)在C++中，表示规模（size）的类型是`std::size_t`，它通常是一个无符号整数类型，可能是`uint16_t`、`uint32_t`或`uint64_t`。使用`std::size_t`可以_语义明确_地表示一个变量存储的是大小或长度，有助于提高代码的可读性和可维护性。

类似于熟知的后缀`f`表示`float`类型的浮点数，从C++23开始，可以在整数字面量后面加上`uz`来表示`std::size_t`类型的整数。比如，`auto a { 42uz };`会自动推导出一个`std::size_t`类型的变量`a`，它的值是42。
]

```cpp
template <typename T>
class DataStructure : public Object {
public:
    virtual std::size_t size() const = 0;
    virtual bool empty() const {
        return size() == 0;
    }
};
```

#h(2em)
读者可能会认为，数据结构作为数据元素的集合，它理应支持增加元素（insert）、删除元素（remove）、查找元素（find）这样的方法，然而事实却并非如此。有一些数据结构，它们可能一旦建立之后就无法添加或删除元素，或者只能添加和删除特定的元素，即*写受限*。同样地，另一些数据结构可能内部对用户不透明，用户只被允许访问特定的元素，并不能在数据结构中自由查找，即*读受限*。在本书的后续部分，您将看到写受限和读受限的具体例子。

== 算法 <sum:algorithm>

=== 算法的定义和实现 <sum:algorithm:definition>

和数据结构经常同时出现的另一个名词是*算法*（algorithm）。算法通常指接受某些*输入*（input），在*有限*（finite）步骤内可以产生*输出*（output）的计算机计算方法 @knuth1968art。

输出和输入的关系可以理解为算法的功能。对于同一功能，可能存在多种算法，对于相同的输入，它们通过不同的步骤可以得到*等价*的输出。这里并不一定要求得到相同的输出，比如我们要求一个数的倍数，输入$a$的情况下，输出$2a$和$3a$都是正确的输出，在“倍数”的观点下，这两个输出等价。

通常，算法的定义除了上述的三个要素：输入、输出和有限之外，还包括*可行*（effective）和*确定*（definite）@邓俊辉2013数据结构。比如，算法中如果包含了“如果哥德巴赫猜想正确，则$...$”，则在当前不满足可行性；如果包含了“任取一个$...$”，则不满足确定性（对同一算法，同样的输入必须产生同样的输出）。在计算机上用代码写成的算法，通常都具有可行性和确定性，所以一般不讨论它们。有限性则可以通过白盒测试和黑盒测试评估。#linebreak()
#graybox[
【C++学习】#linebreak()
#h(2em)众所周知，C++有一个概念同样具有输入和输出：函数（function）。但是，直接用函数来表示一个算法并不OOP，因此我们采用*仿函数*（functor）而不是普通的全局函数。仿函数是一种_类_，它重载了括号运算符`operator()`。仿函数对象可以像一个普通的函数一样被调用，并且可以被转换为`std::function`。和普通的全局函数相比，仿函数具有两方面的优势：

+ 仿函数可以有成员变量。比如，可以定义一个`m_count`来统计一个仿函数对象被调用的次数。而普通的全局函数则无法做到这一点，非`static`的变量会在函数结束后被释放，而`static`的变量又强制被全局共享。

+ 仿函数可以有成员函数（方法）。当仿函数的功能非常复杂时，它可以将功能拆解为大量的成员函数。因为这些成员函数都处在仿函数内部，所以不会污染外部的命名空间，并且可以清楚地看到它们和仿函数之间的关系。必要的时候，还可以通过嵌套类显式地指明其中的关系。而普通的全局函数，则无法在函数内嵌套一个没有实现的子函数。

```cpp
template <typename OutputType, typename... InputTypes>
class Algorithm;

template <typename OutputType, typename... InputTypes>
class Algorithm<OutputType(InputTypes...)> : public Object {
public:
    using Output = OutputType;
    template <std::size_t N>
    using Input = std::tuple_element_t<N, std::tuple<InputTypes...>>;
    virtual OutputType operator()(InputTypes... inputs) = 0;
};
```
#h(2em)
这个类只定义了一个纯虚的括号运算符重载，使用可变参数模板（以`...`表示）以处理不同输入的算法。另一方面，借用了`std::function`的表示形式，要求用户使用`OutputType(InputTypes...)`的方式给出模板参数表。比如，一个输入两个整数、输出一个整数的算法可以继承于`Algorithm<int(int, int)>`。`Input<N>`用来表示第`N`个输入的类型，而`Output`用来表示输出类型。

像`Input`和`Output`这样可以反过来获得模板参数的技术，称为*类型萃取*（type traits）。它是模板元编程所使用的重要技术之一。类型萃取可以帮助开发人员在编译器就进行一些决策和判断，从而优化代码或者选择适当的算法。比如，可以通过`if constexpr (std::is_integral_v<A::Input<0>>) { ... }`来判断算法`A`的第一个输入参数是否是整数类型，并执行后面的操作。这个判断在编译期就会被执行，不会产生运行时的开销。
]

=== 算法的评价 <sum:algorithm:evaluation>

作为一种解决问题的方法，算法的评价是多维度的。本节将简要介绍算法的几个典型的评价维度。

第一，*正确性*。正确性检验通常分为两个方面：

+ *有限性检验*。如前所述，有限性是算法定义的组成部分之一。有限性检验，主要用于判断带有无限循环，如`while(true)`、强制跳转（`goto`）和递归的算法是否必定会终止。这一方面对应着算法定义中的*有限性*要求。

+ *结果正确性检验*。即验证输出的结果满足算法的需求。在算法有确定的正确结果时，这一检验是“非黑即白”的；而在算法没有确定的正确结果时，可能需要专用的检验程序甚至人工打分（如较早的象棋AI，往往是以高手对一些局面的形势打分作为基础训练数据的）。这一方面对应着算法定义中的*输入*和*输出*。

#h(2em)
算法定义中的另外两点，*可行性*和*确定性*，正如之前所讨论的那样，通常都可以被直接默认，而不需要进行检验。

第二，*效率*。评价算法效率的标准可以简单地概括为_多、快、好、省_ @鞠文飞2007多快好省。在《数据结构》中，通常只研究“快”和“省”这两个方面，而《网络原理》则需要考虑全部的四个方面。_在《网络原理》中，“多”代表网络流量，“好”代表网络质量。_

    + *时间效率*（快）。在计算机上运行算法一定会消耗时间，时间效率高的算法消耗的时间比较短。
    + *空间效率*（省）。在计算机上运行算法一定会消耗空间（硬件资源），空间效率高的算法消耗的硬件资源比较少。如果需要的空间太多以至于超过了计算机的内存，则外存缓慢的读写也会对算法的时间效率造成重创。

#h(2em)
在不同的计算机、不同的操作系统、不同的编程语言实现下，同一算法消耗的时间和空间可能大相径庭。为了抵消这些变量对算法效率评价的干扰作用，在《数据结构》这门学科里进行算法评价时，往往不那么注重真实的时间、空间消耗，而倾向于做*复杂度分析*。关于复杂度的讨论参见后文。

第三，*稳健性*（robustness，又译健壮性、鲁棒性；在看到英文之前，我曾一度认为“鲁棒性”这个词来源于山东小伙身体棒的地域刻板印象）。即算法面对意料之外的输入的能力。

第四，*泛用性*。即算法是否能很方便地用于设计目的之外的其他场合。

在上述4个评价维度中，正确性和效率是《数据结构》学科研究的主要内容。对简单算法的正确性检验和复杂度分析，是数据结构的基本功之一。这两个问题留到后面的节里展开讨论。而稳健性和泛用性，则在课程设置上属于《软件工程》讨论的内容，在下一小节会用一个实验展示它，后续不再赘述。

=== 累加问题 <sum:algorithm:sum>

算法和实现它的代码（code）或程序（program）有本质区别 @kowalski1979algorithm。按照通常意义的划分，算法更接近于理科的范畴，而实现它的代码更接近工科的范畴。一些人员可能很擅长设计出精妙绝伦的算法，但需要耗费巨大的精力才能实现它，并遗留不计其数的错误或隐患；另一些人员可能在设计算法上感到举步维艰，但如果拿到已有的设计方案，可以轻松完成一份漂亮的代码。算法设计和工程实现对于计算机学科的研究同等重要。参加过语文高考的同学可能会很有感受：自己有一个绝妙的构思，但没有办法在有限的时间下把它说清楚。如果专精算法设计而忽略工程实现，就会有类似的感觉。

上一小节中介绍的算法评价维度中，*稳健性*和*泛用性*是高度依赖于算法的实现的（当然，也有少数情况和算法本身的设计相关）。在本小节将通过一个实验作为例子，向读者展示：对于相同的算法，代码实现的不同会影响这两个评价维度。

#bluetxt[实验`sum.cpp`。]本小节讨论一个非常简单的例子：从$1$加到$n$的求和。输入一个正整数$n$，输出$1+2+...+n$的和。
```cpp
using Sum = Algorithm<int(int)>;
```

#graybox[
#h(2em)
作为实验的一部分，您可以自己实现一个类，继承`Sum`，并重载`operator()`，和本书提供的示例程序做对比。
如果您不熟悉编程，可以先再阅读后文的分析，再自己实现；如果您熟悉编程，可以先自己实现，再阅读后文的分析。当然，如果您不打算自己实现，也可以只阅读本书的理论部分。]

在这个实验的示例程序里，设计了几个`Sum`的派生类来完成这个算法功能。
最容易想到的办法，自然是简单地把每个数字加起来，就像这样：
```cpp
// SumBasic
int operator()(int n) override {
    int sum { 0 };
    for (int i { 1 }; i <= n; ++i) {
        sum += i;
    }
    return sum;
}
```
#h(2em)
上面的这个算法显然称不上好。著名科学家高斯（Gauss）在很小的时候就发现了等差数列求和的一般公式。我们可以使用公式，得到另一个可行的算法。

```cpp
// SumAP
int operator()(int n) override {
    return n * (n + 1) / 2;
}
```

#h(2em)
由于这个算法的正确性十分显然，您或许觉得这个程序毫无问题，直到您发现了另外一个程序：
```cpp
// SumAP2
int operator()(int n) override {
    if (n % 2 == 0) {
        return n / 2 * (n + 1);
    } else {
        return (n + 1) / 2 * n;
    }
}
```

#h(2em)
通过对比SumAP和SumAP2，您会立刻意识到SumAP存在的问题：对于某个区间内的$n$，$n(n+1) / 2$的值不会超过`int`的最大值，但$n(n+1)$会超过这个值。比如，当$n=50,000$的时候，SumAP2和SumBasic都能输出正确的结果，而算法SumAP则会因为数据溢出返回一个负数（本书默认`int`为32位整数）。

但SumAP2也很难称之为无可挑剔，比如说，如果$n$更大一些，比如取$100,000$，则它也无法输出一个正确的值。这种情况下，甚至最朴素的SumBasic也无法输出正确的值。一些典型值下三种实现的结果如 @tab:sum1 所示。

#figure(
    table(
    columns: 5,
    align: horizon,
    [$n$], [], [SumBasic], [SumAP], [SumAP2],
    [10], [普通值], [√], [√], [√],
    [0], [边界值], [√], [√], [√],
    [50,000], [临界值], [√], [×], [√],
    [100,000], [溢出值], [×], [×], [×],
    [-10], [非法值], [√], [×], [×],
),
    caption: "求和算法的正确性检验",
) <tab:sum1>

那么，上述的三个实现，哪些是_正确_的？

在实际进行代码实现的时候，通常会倾向于SumAP2，因为它既有较高的效率（相对于SumBasic而言），又保证了在数据不溢出的情况下能输出正确的结果（相对于SumAP而言）。但在进行算法评估的时候，通常认为这三个实现都是正确的，并且SumAP和SumAP2实质上是_同一种_算法。也就是说，数据溢出这种问题并不在评估模型之内：算法虽然执行在计算机上，但又是_独立_于计算机的；算法虽然需要代码去实现，但又是_独立_于实现它的代码的。在《数据结构》这门学科中的研究对象，通常和体系结构、操作系统、编程语言等因素都没有关系。

在本节的末尾，您可以思考一个有趣的问题：SumAP2在$n$非常大的时候也会出现溢出问题。
当然，这超过了`int`所能表示的上限。但是，这种情况下，返回什么样的值是合理的？SumAP2返回的值（有可能是一个负数）真的合理吗？_这是纯粹的工程问题，并不在《数据结构》研究的范围内。_

#graybox[【C++学习】#linebreak()#h(2em)
一种可能的方案是，在溢出的时候返回`std::numeric_limits<int>::max()`。这种方案称为“饱和”。饱和保证了数值不会因为溢出而变为负值，当数值具有实际意义时，一个不知所云的负值可能会引发连锁的负面反应。比如，路由器可能会认为两个节点之间的距离为负（事实上应当是$infinity$），从而完全错误地计算路由。因此，如果实现了饱和，在泛用性上可以得到一定的提升。

还有一个问题是，如果$n$为负数，则应该如何输出？当然，题目要求$n$是正整数，负数是非法输入；但有时也会希望程序能输出一个有意义的值。按照朴素的想法（也就是SumBasic），这个时候应该输出0，然而SumAP和SumAP2都做不到这一点。在示例程序中给出了一个考虑了负数输入和饱和的实现，您也可以独立尝试实现这个功能。
]

== 正确性检验 <sum:correctness>

在上一节已经说明，正确性检验可以拆解为两个方面：有限性检验和结果正确性检验。在实际解题的过程中，这两项检验往往可以一并完成，即检验算法_是否能在有限时间内输出正确结果_。

解决正确性检验的一般方法是*递降法*。它的思想基础是在计算机领域至关重要、并且是《数据结构》学科核心的*递归*思维方法；它的理论依据则是作为在整数公理系统中举足轻重的*数学归纳法*。本节将从数学归纳法的角度出发介绍递降法的原理。

=== 数学归纳法 <sum:correctness:induction>

在高中理科数学中介绍了数学归纳法的经典形式。由于各省教材不同，您可能接触到过两种表述不太一样的数学归纳法，如 @tab:induction 所示。

#figure(table(
    columns: 2,
    [*第一归纳法*], [*第二归纳法*],
    [
        令$P(n)$是一个关于正整数$n$的命题，
        若满足：
        + $P(1)$
        + $forall n >= 1, P(n) -> P(n+1)$
        则$forall n, P(n)$。
    ],
    [
        令$P(n)$是一个关于正整数$n$的命题，
        若满足：
        + $P(1)$
        + $forall n > 1, (forall k < n, P(k)) -> P(n)$
        则$forall n, P(n)$。
    ],
),
    caption: "数学归纳法的两种表述",
) <tab:induction>


其中，第一归纳法是皮亚诺（Piano）公理体系的一部分，第二归纳法是第一归纳法的直接推论。另一方面，第二归纳法的*归纳假设*$(forall k <= n, P(k))$，显然比第一归纳法的归纳假设$P(n)$更强。所以实际应用数学归纳法进行证明时，通常都使用第二归纳法，而不使用第一归纳法。

_在上面的表述中，归纳的过程是从1开始的，这比较符合数学研究者的工作习惯。_
在计算机领域，归纳法常常从0开始。显然，这并不影响它的正确性。本节后续对“正整数”相关问题的讨论，一般替换成“非负整数”也同样可用。

我们将第二归纳法称为*经典归纳法*。经典归纳法可以用来处理有关_正整数_的命题。相应地，对于输入是_正整数_的算法，可以使用与经典归纳法相对应的*经典递降法*：

  令$A(n)$是一个输入正整数$n$的算法，若满足：
      + $A(1)$可在有限时间输出正确结果。
      + $forall n>1, A(n)$可在有限时间正确地将问题化归为有限个$A(k_j)$，其中$k_j < n$。
#v(-0.5em)
#h(2em)
则$forall n, A(n)$可在有限时间输出正确结果。

经典递降法的正确性由经典归纳法保证。显然，经典递降法的应用范围非常狭小：只能用来处理输入是正整数的算法。对于实际的算法，它的输入数据通常是多个数、乃至于数组和各种数据结构，而非孤零零的一个正整数。因此，需要对经典归纳法进行推广，从而使其可以应用到更广的范围中，并使其相对应的递降法能够处理更加多样的输入数据。

=== 良序关系 <sum:correctness:well-order>

为了将经典归纳法推广到更广的范围，需要提炼出$NN$使归纳法成立的性质：*良序性*（well-ordered）。如果集合上的一个关系$prec.eq$满足：

    + *完全性*。$x prec.eq y $和 $y prec.eq x$至少有一个成立。
    + *传递性*。如果$x prec.eq y$且$y prec.eq z$，那么$x prec.eq z$。
    + *反对称性*。如果$x prec.eq y$和$y prec.eq x$均成立，那么$x=y$。
    + *最小值*。对于集合$S$的任意非空子集$A$，存在最小值$min A=x$。即对于$A$中的其他元素$y$，总有$x prec.eq y$。

#h(2em)
那么称$prec.eq$是$S$上的一个*良序关系*，同时称$S$为*良序集*。类似于数值的小于等于“$<=$”和小于“$<$”关系，对于关系$prec.eq$，如果$x prec.eq y$且$x eq.not y$，则可以记为$x prec y$。

根据上述定义，熟知的小于等于关系“$<=$”在$NN$上是良序的，而在$ZZ$上不是良序的。当然，可以通过定义“绝对值小于等于”让整数集$ZZ$成为良序集（因此，$ZZ$上的命题可以通过对绝对值归纳证明）。同时，熟知的小于等于关系“$<=$”在正实数集$RR^+$上不是良序的，因为它不满足最小值条件（任取一个开区间作为它的子集，都没有最小值）。

和正整数集$NN$相比，一般的良序集具有下面的相似性质（*无穷递降*）：

  在良序集$S$中，不存在无穷序列$\{x_n\}$，使得$x_(j+1) prec x_j$对$forall j$成立。

_您可以用反证法证明上述命题_。据此，可以得到一般形式的递降法。

    令$S$是一个良序集，如果$S$上的算法$A(n)$满足：
        + $A(min S)$可在有限时间输出正确结果。
        + $forall x, A(x)$可在有限时间正确地将问题化归为有限个$A(y_j)$，其中$y_j prec x$。
#v(-0.5em)
#h(2em)
    则$forall x in S, A(x)$可在有限时间输出正确结果。

递降法和*递归*（recursion）是密不可分的。在上述递降法的表述中，条件（1）对应了*递归边界*，条件（2）则对应了*递归调用*。边界情况通常对应的是最简单的情况，而递归调用则用来将复杂问题拆解成简单问题。只要您有一定的递归编程的经验，那么递降法是非常容易理解的。

递降用于分析算法，而递归用于设计算法，二者思路上相似，只是侧重点不同。
在设计算法时，$A(x)$是一个待解决的算法问题，因此尝试将它拆解为有限个规模较小的子问题$A(y_j)$，递归地解决这些子问题，直到到达平凡情况（$min S$）。而在分析算法时，首先证明平凡情况下算法是有限、正确的，然后再证明非平凡情况下，将$A(x)$化归为有限个$A(y_j)$的过程是有限、正确的。
由于二者的相似性，后文将不再区分。

=== 最大公因数 <sum:correctness:gcd>

#bluetxt[实验`gcd.cpp`。]本节以求最大公因数为例，展示如何证明递归算法的正确性。
如果您没有编程基础，可以参考下面的实现，这是大名鼎鼎的最大公因数算法：欧几里得（Euclid）辗转相除法的_递归形式_。

```cpp
// GcdEuclid
int operator()(int a, int b) override {
    if (b == 0) {
        return a;
    } else {
        return (*this)(b, a % b);
    }
}
```

#graybox[【C++学习】#linebreak()#h(2em)
在《数据结构》中，通常会将上面这样的代码当做递归算法来分析。
但在实际的C++编译器中，上面的代码会被自动优化为非递归形式，所以实际上不需要刻意去做这样的转换。这是C++编译器的一种*尾递归优化*（tail recursion optimization）。一些其他语言（比如Python）没有这样的优化，因此在这些语言中，递归算法的效率可能会比较低。
]

在这个算法中，递归边界是$(a, 0)$，因此可以定义$f(a, b) = min(a, b)$，将输入数据映射到熟知的良序集$NN$。接着就可以用递降法处理这个问题了。

    + 如果$a<b$，那么通过1次递归，可变换为等价的$"gcd"(b, a)$。
    + 如果$a>= b>0$，那么由于$b > a\%b$对一切正整数$a,b$成立，所以通过1次递归，可变换为$f(dot)$更小的$(b, a\%b)$。接下来只要证$"gcd"(a, b) = "gcd"(b, a\%b)$。_您可以自己完成这一证明_。下面提供了一种比较简单的证法。\
     设$a = k b + l$，其中$l = a \% b$。
     那么，对于$a$和$b$的公因数$d$，设$a = A d$，$b = B d$，则$l = (A-k B)d$。
     因此$d$也是$b$和$l$的公因数。反之，对于$b$和$l$的公因数$d’$，也可推出$d’$也是$a$和$b$的公因数。
     因此$a$和$b$的公因数集合，与$b$和$l$的公因数集合相同；它们的最大值（即最大公因数）显然也相同。
   + 如果$b=0$，到达边界，$"gcd"(a, 0) = a$正确。

#h(2em)
=== 数组求和 <sum:correctness:array-sum>

递降法的条件2允许在一个递归实例中，调用自身_有限次_。在上一节中，一个$"gcd"$只会调用一次自身；这一小节展示了一个多次调用自身的例子。

#bluetxt[实验`asum.cpp`。]作为第一章的实验我们仍然讨论一个简单的求和问题：给定一个规模为$n$的数组$A$，求$A_0+A_1+...+A_(n-1)$的和。

```cpp
using ArraySum = Algorithm<int(std::span<const int>)>;
```

#graybox[【C++学习】#linebreak()#h(2em)
`std::span`是C++标准库提供的模板类，是对连续内存区域的一种视图抽象，可以安全、高效的操作连续的内存区域。它可以用来表示`std::array`、`std::vector`、C风格数组等连续内存区域的一个切片（slice）。这个切片可以使用迭代器、下标运算符等方法，像一个独立数组一样使用，而不需要实际将切片中的内存复制到一个新的独立数组。
]


经典的数组求和方法，是定义一个累加器，把每个数逐一加到累加器上。

```cpp
// ArraySumBasic
int operator()(std::span<const int> data) override {
    return std::accumulate(data.begin(), data.end(), 0);
}
```
#graybox[
#h(2em)
在C++标准库中还存在另外两个函数可以用来求和，分别在C++17和C++23引入。这三种函数都可以用于归约（如使用乘、异或等代替求和中的加），不同编译器对于这三种函数的优化程度不同，其中一些编译器有可能应用了SIMD技术来提高执行效率，这大约会带来数倍的时间差距。
```cpp
std::reduce(data.begin(), data.end(), 0); // C++17
std::ranges::fold_left(data, 0, std::plus{}); // C++23
```
]

下面回到递归话题来。一个基于经典递降法的朴素思路是：要求$n$个元素的和，可以先求前$n-1$个元素的和，然后将它和最后一个元素相加。这是一个递归算法，如下所示。

```cpp
// ArraySumRnC
int operator()(std::span<const int> data) {
    if (data.size() == 0) {
        return 0;
    }
    return (*this)(data.first(data.size() - 1)) + data.back();
}
```

#h(2em)
这种将待解决问题分拆为一个规模减小的问题$+$有限个平凡的问题的思想，被称为*减治*（reduce-and-conquer，或decrease-and-conquer）@邓俊辉2013数据结构。在《数据结构》中使用减治思想，通常是将数据结构（这里是数组）分拆成几个部分，其中只有一个部分的规模和原数据结构的规模相关（减治项），其他部分的规模都是有界的（平凡项）。在上面的例子中，数组被分拆成了两个部分，前$n-1$个元素组成的部分是减治项，而最后一个元素是平凡项。// 虽然这个算法的正确性非常显然，但作为练习，您还是可以借助之前介绍的递降法去证明它的正确性。

*循环*可以被看成是减治的一种特殊形式。我们可以认为循环的第一次执行是平凡项（起始处减治），此后的执行是减治项；或者，我们也可以认为循环的最后一次执行是平凡项（结尾处减治），此前的执行是减治项。在下面的循环代码的结尾处减治，就对应了刚刚介绍的减治算法。

```cpp
// ArraySumIterative
int operator()(std::span<const int> data) override {
    int sum { 0 };
    for (int x : data) {
        sum += x;
    }
    return sum;
}
```

#h(2em)
下面介绍另一种不同的思路。我们可以设计这样的算法：先算出数组前一半的和，再算出数组后一半的和，最后把这两部分的和相加（这个算法成立的基础是加法结合律）。这也是一个递归算法，如下所示。

```cpp
// ArraySumDnC
int operator()(std::span<const int> data) override {
    if (auto sz { data.size() }; sz == 0) {
        return 0;
    } else if (sz == 1) {
        return data.front();
    } else {
        auto mid { sz / 2 };
        return (*this)(data.first(mid)) + (*this)(data.subspan(mid));
    }
}
```

#h(2em)
上述算法设计中，我们将待解决问题拆分为多个规模减小的问题，这种思想称为*分治*（divide-and-conquer）。在《数据结构》中使用分治思想，通常是将数据结构（这里是数组）分拆为几个部分，每个部分的规模都和原数据的规模相关（分治项）。广义的分治也可以包含若干个平凡项。在上面的例子中，数组被分拆为了两个部分，每个部分的规模大约是原规模的一半。减治和分治是设计算法的重要思路，在本书中将广泛使用。这两种思想也能为您解决自己遇到的算法问题提供强大的助力。

#figure(table(
    columns: 7,
    $n$, [迭代], [`accumulate`], [`reduce`], [`fold_left`], [减治递归], [分治递归],
    $10^4$, [0], [0], [0], [0], [0], [0],
    $10^6$, [0], [0], [0], [0], [栈溢出], [0],
    $10^7$, [3], [3], [3], [3], [栈溢出], [12],
    $10^8$, [33], [31], [28], [31], [栈溢出], [169],
    $10^9$, [315], [316], [267], [308], [栈溢出], [2093]
),
    caption: "数组求和算法的时间",
) <tab:sum2>

#graybox[#h(2em)
    本书中的表格和图像都是通过实验得到的（GCC 13.2.0；单位为毫秒），其他编译器可能会使得实验结果和@tab:sum2 有所不同，尤其是使用标准库函数的三列。请读者在自己的环境中进行实验，以得到更加准确的结果，并和本书中的结果对比分析。
]

分治算法和普通的迭代算法相比，只是修改了加法的运算次序；但测试结果显示，它竟然远远不如普通的迭代算法。这是因为_递归调用_本身存在不小的开销。如果等价的迭代方法（在后续章节中，将介绍递归和迭代的相互转换）并不复杂，那么通常用迭代替换递归，以免除递归调用本身的性能开销。

=== 函数零点 <sum:correctness:zero-point>

#bluetxt[实验`zerop.cpp`。]以上两个例子都是建立在递归上的算法。很多算法可能并不包含递归；对这些算法做有限性检验，不是要排除无穷递归，而是要排除无限循环。下面展示了一个循环的例子。

我们考虑一个函数的零点，给定一个函数$f(x)$和区间$(l,r)$，保证$f(x)$在$(l,r)$上连续，并且$f(l)dot f(r) <0$。根据_介值定理_，我们知道$f(x)$在$(l,r)$上存在至少一个零点。由于计算机中的浮点数计算有精度限制，我们只需要保证绝对误差不超过给定的误差限$epsilon$。为了简单起见，我们现在统一给定$l=-1,r=1,epsilon=10^(-6)$。

```cpp
class ZeroPoint : public Algorithm<double(std::function<double(double)>)> {
    static constexpr double limit_l { -1.0 };
    static constexpr double limit_r { 1.0 };
protected:
    static constexpr double eps { 1e-6 };
    using funcdd = std::function<double(double)>;
    virtual double apply(funcdd f, double l, double r) = 0;
public:
    double operator()(funcdd f) override {
        return apply(f, limit_l, limit_r);
    }
};
```
#graybox[
#h(2em)
上面的例子展示了我们将`Algorithm`定义为仿函数的优势，我们可以在零点问题的基类中定义私有（private）成员来表示给定的初值$l$和$r$；另一个给定的初值$epsilon$在算法的实现中需要用到，则可以定义为受保护的（protected）成员。]

函数的零点可以通过*二分*（bisect）的方法取得，这个方法在高中的数学课程中介绍过。_如果您熟悉编程，应该可以自己实现一个版本。_

```cpp
// ZeroPointIterative
double apply(funcdd f, double l, double r) override {
    while (r - l > eps) {
        double mid { l + (r - l) / 2 };
        if (f(l) * f(mid) <= 0) {
            r = mid;
        } else {
            l = mid;
        }
    }
    return l;
}
```

#h(2em)
// 尽管是经典的算法，但您仍然可以关注其中的一些细节。一个细节是赋值`mid`为$l+(r-l)/2$而不是$(l+r)/2$。这两种写法都是推荐的写法。在整数的情况下，前者的优点是不会溢出，并保证结果接近$l$（后者存在负数时无法保证，而这一点在写二分算法时有时很致命）；后者的优点是少一次减法计算。浮点数的情况比整数简单很多，两种写法，甚至$l/2 + r/2$（在整数的情况下不应该使用）都是可以的。
// 另一个细节是我们的判断条件为$f(l)dot f("mid") <= 0$，而没有用严格小于号。_您可以思考或实验，讨论严格小于的场景。_
分析循环问题的手段，和分析递归问题是相似的。递归函数的_参数_，在循环问题里就变成了_循环变量_。在处理上面的迭代算法时，首先找到循环的_停止条件_：$r – l < epsilon$。这个条件里，$epsilon$作为输入数据，在循环中是_不变量_，而$l$和$r$是循环中的_变量_。因此，使用递降法的时候可以将$epsilon$看成常量，而$l$和$r$作为_递归参数_。

定义映射$f(l,r) = floor( (r-l)/epsilon )$就可以将问题映射到$NN$，从而使用递降法进行正确性检验。请注意在证明结果正确性时要留意$f("mid") = 0$的情况。从这个映射中，我们可以发现规定$epsilon$是必要的，即使不考虑`double`的位宽限制，计算机也无法保证在有限时间里找到_精确解_，只能保证找到满足精度条件的_近似解_。

这种“将循环视为递归”然后用递降法处理的方法，等价于将上面的迭代算法改写为以下与其等价的递归算法。

```cpp
// ZeroPointRecursive
double apply(funcdd f, double l, double r) override {
    if (r - l <= eps) {
        return l;
    } else {
        double mid { l + (r - l) / 2 };
        if (f(l) * f(mid) <= 0) {
            return apply(f, l, mid);
        } else {
            return apply(f, mid, r);
        }
    }
}
```

#h(2em)
其通用做法是：_找到循环的停止条件，然后将条件中出现的、在循环内部被改变的变量视为递归的参数，以此将循环改写为递归。_当然，实际遇到问题不需要显式地将其改写为递归，只要在分析算法的正确性时，将循环视为递归即可。

== 复杂度分析 <sum:complexity>

*复杂度*（complexity）*分析*的技术被用于评价一个算法的效率。在考试中它出现的频率比正确性检验更高。在上文中提到过，一个算法的真实效率（运行时间、占用的硬件资源）会受到所用计算机、操作系统以及其他条件的影响，因此无法用来直接进行比较。因此，进行复杂度分析时通常不讨论绝对的时间（空间）规模，而是采用*渐进复杂度*来表示其_大致的增长速度_。

=== 复杂度记号的定义 <sum:complexity:notation>


假设问题规模为$n$时，算法在某一计算机上执行的绝对时间单元数为$T(n)$。
    + 对充分大的$n$，如果$T(n) <=  C dot f(n)$，其中$C > 0$是和$n$无关的常数，那么记$T(n) = O(f(n))$。
    + 对充分大的$n$，如果$C_1 dot f(n) <= T(n) <=  C_2 dot f(n)$，其中$C_2 >= C_1 > 0$是和$n$无关的常数，那么记$T(n) = Theta(f(n))$。
    + 对充分大的$n$，如果$C dot f(n) <= T(n)$，其中$C > 0$是和$n$无关的常数，那么记$T(n) = Omega(f(n))$。

#h(2em)
用$O(dot)$、$Theta(dot)$和$Omega(dot)$记号表示的时间随输入数据规模的增长速度称为*渐进复杂度*，或简称*复杂度*。类似可以定义空间复杂度。

从上述定义中可以得到，当$T(n)$关于$n$单调递增并趋于无穷大时，$f(n)$是阶不比它低的无穷大量，$h(n)$是阶不比它高的无穷大量，而$g(n)$是和它同阶的无穷大量。
当然$T(n)$并不一定单调递增趋于无穷大。一般而言，复杂度记号是在问题规模充分大的前提下，从增长速度的角度对算法效率的定性评价。

在“充分大的$n$”和“忽略常数”两个前提下，复杂度记号里的函数往往特别简单。比如，多项式$limits(sum)_(i=0)^k a_i n^i$（$a_k>0$）可以被记作$Theta(n^k)$，因为充分大的$n$下，次数较低的项都可以被省略，忽略常数又使我们可以省略系数$a_k$。

一些教材为简略起见，只介绍了$O(dot)$一个符号，这非常容易引起理解错误或混淆 @严蔚敏1997数据结构。在下一小节中会展示很多错误理解的例子。在本书中这三种复杂度记号都会使用。在只使用$O(dot)$的文献里，$O(dot)$常常用来实际上表达$Theta(dot)$；而在严谨的文献里，除了$O(1)$和$Theta(1)$没有区别外，其他情况下这两者都是被严格区分的。除了这三种复杂度记号之外，还有少见的两种复杂度记号：$o(dot)$和$omega(dot)$。因为在科研生活里也极少使用，所以不进行介绍。

// 因此，即使您准备参加的考试中不要求另外两种复杂度记号，也希望您理解这些记号。
// _此外，一些错误的理解甚至可能成为部分考试的标准答案，这种情况造成的失分是无法避免的。_
// 其中，$Theta(dot)$记号包含了比$O(dot)$更多的信息，如果您准备参加的考试只要求$O(dot)$这一个记号，您可以在不引起歧义的前提下，在作答时将书中的$Theta(dot)$用$O(dot)$代替。



在上面的定义中，引入了_时间单元_和_空间单元_的概念。因为渐进复杂度的记号表示中不考虑常数，所以这两个单元的大小是可以任取的。

例如，一个时间单元可以取成：
- 一秒（毫秒，微秒，纳秒，分钟，小时等绝对时间单位）。
- 一个CPU周期。
- 一条汇编语句。
- 一次基本运算（如加减乘除）。
- 一次内存读取。
- 一条普通语句（不含循环、函数调用等）。
- 一组普通语句。

#h(2em)
又例如，一个空间单元可以取成：
- 一个比特（字节、半字、字、双字等绝对单位）。
- 一个结构体（固定大小）所占空间。
- 一个页（参见《操作系统》）。
- 一个栈帧（参见《操作系统》）。

#h(2em)
这些单位并不一定能直接地相互转换。比如，即使是同一台计算机，它的“一个CPU周期”对应的绝对时间也可能会发生变化（CPU过热时降频）。但是这些单位在转换时，_转换倍率必然存在常数的上界_。比如通常情况下，能正常工作的内存绝不可能需要多于$10^9$个CPU周期才能完成读取。

这个常数级别的差距，在复杂度分析里被纳入到了$C$、$C_1$、$C_2$中，而_不会影响到渐进复杂度_。因此，复杂度分析成功回避了硬件、软件、环境条件等“算法外因素”对算法效率的影响。

#h(2em)
=== 复杂度记号的常见理解误区 <sum:complexity:misunderstanding>

这一小节单独开辟出来，讨论和复杂度记号（尤其是$O(dot)$）有关的注意点 @knuth1968art。由于复杂度记号总是作为一门学科的背景知识出现，您可能会没有意识到这是一个相当容易混淆的概念，从而陷入某些误区而不自知。

第一，
*不可交换*。设$n^3 = O(n^4)$，$n^2 = O(n^4)$，那么，是否有$n^3=O(n^4)=n^2$呢？显然是不可能的。
等于号“$=$”的两边通常都是可以交换的，但在复杂度记号这里并非如此。在进行复杂度的连等式计算时，始终需要记住：

+ *等式左边包含的信息不少于右边。*（最基本的性质）

+    复杂度记号本身损失了常数的信息。因此复杂度记号只能出现在等式的右侧。如果出现在左侧，那么右侧也必须是复杂度记号。

+   从$Theta(dot)$转换成$O(dot)$或$Omega(dot)$，会损失一侧的信息。因此连等式中，$Theta(dot)$只能出现在$O(dot)$或$Omega(dot)$的左侧。只有一种情况除外，就是$O(1)=Theta(1)$。

#h(2em)
例如，$2n^2=Theta(n^2)=O(n^3)=O(n^4)$是正确的。

第二，
*不是所有算法都可以用$Theta(dot)$评价*。这个问题很容易从数学角度看出来，例如$T(n)=n (sin (n pi)/2+1)$，就不存在“与它同阶的无穷大量”。正是因为这个原因，我们更多地使用表示上界的$O(dot)$，而不是看起来可以精确描述增长速度的$Theta(dot)$。

第三，
*只有$Theta(dot)$才可以进行比较*。已知算法A的复杂度是$O(n)$，算法B的复杂度是$O(n^2)$，那么，算法A的复杂度是否一定低于算法B？

这是最容易误解的一处，我们可以说$O(n)$的复杂度低于$O(n^2)$，但切不能想当然认为算法A的复杂度低于算法B。这是因为，尽管已知条件告诉我们“算法B的复杂度是$O(n^2)$”，但已知条件并没有排除“算法B的复杂度同时也是$O(n)$甚至$O(1)$”的可能。类似地，$Omega(dot)$也不可比较，只有表示同阶无穷大量的$Theta(dot)$有比较的意义。考试中也可能遇到需要比较复杂度的情况，这是纯粹的数学问题，因此不做展开。

计算机工程师对数学严谨性并不敏感。在相当大规模的人群中，对$O(dot)$形式的复杂度进行比较已经成为了一种习惯。作为一门工程学科，当一种做法被人们普遍接受、成为共识的时候，通常就被认为是合理的，以至于人们忽视了，只有当$O(dot)$事实上在表达$Theta(n)$的语义时，这样的比较才是成立的。
如上一点所说，并非所有复杂度分析都能用$Theta(dot)$形式的结果，只有了解了严谨的说法，才能避免在阅读文献时理解上出现混淆。

第四，*不满足对减法、除法的分配律*。
不论是三种复杂度记号中的哪一种，都不服从对减法、除法的分配律。对加法和乘法，分配律是_单向_成立的（直观地理解是，复杂度记号包裹的范围越大，就会损失越多的信息）。
比如，公式$O(f(n))dot O(g(n))=O(f(n)dot g(n))$是成立的，反过来则不成立。//_您可以自己证明这些公式_。

// 从这一点可以看出，形如
// $O(H_n)-O(ln n) =O(H_n-ln n)=O(1)$这样的推导是错误的。这里记号$H_n=limits(sum)_{i=1}^n 1/i$用来表示_调和级数的部分和_，在$n -> infinity$时，$H_n-ln n -> gamma$，其中$gamma$是Euler常数。这一性质在复杂度分析的领域非常重要，之后还会再次遇到。

第五，*复杂度记号和情况的好坏无关*。也就是说，尽管表示上下界，但$O(dot)$和$Omega(dot)$不代表“_最坏情况_（worst case）”和“_最好情况_（best case）”。

*情况*（case）表示和问题规模$n$无关的输入数据特征。
比如说，我们想要在规模为$n$的整数数组$A$中，寻找_第一个_偶数（找不到时返回0），可以使用如下算法。
```cpp
int operator()(std::span<const int> data) override {
    for (auto a : data) {
        if (a % 2 == 0) {
            return a;
        }
    }
    return 0;
}
```

#h(2em)
容易发现，除了问题规模$n$之外，这$n$个整数自身的特征也会影响找到第一个偶数的时间。如果$A_0$就是偶数，则只进行了一次奇偶判断，可以认为$T(n)=1$；如果$A$中每一个元素都是奇数，则需要对每个元素都进行奇偶判断，可以认为$T(n)=n$。对于同样的$n$，不同情况的输入数据会得到不同的$T(n)$。

如果情况会对算法的性能造成影响，$T(n)$就不再是一个准确的值，变成了一个范围，它的下限对应了最好情况，上限对应了最坏情况。如果设$T(n)$在最好情况下为$g(n)$，最坏情况下为$h(n)$，那么对$g(n)$和$h(n)$可以分别做复杂度分析，得到它在最好情况和最坏情况下的复杂度。在这个复杂度分析的过程中，三种符号都是可以使用的。
也正是因为情况和复杂度记号无关，所以在只使用$O(dot)$的书上，无论是最好、最坏还是平均都可以使用这个记号。

#figure(
    image("images/sum1.svg", width: 100%),
    caption: "最好情况和最坏情况的评估",
) <fig:sum1>

不同的符号表达的侧重点是不同的。如@fig:sum1 所示，当我们使用$O(dot)$描述最好情况时，可以体现出“最好”究竟有多好，而$Omega(dot)$描述最好情况则做不到这一点。相应地，$Omega(dot)$才可以体现出“最坏”有多坏。因此，在无法用准确的$Theta(n)$表达时，我们通常使用$O(dot)$描述最好，用$Omega(dot)$描述最坏。

=== 判断 2 的幂次 <sum:complexity:power2>

#bluetxt[实验`power2.cpp`。]下面几个小节，将通过一些简单的算法，介绍复杂度分析的基本方法。更多的复杂度分析将穿插在整本书中。本节讨论判断一个正整数是否为2的幂次的算法。

```cpp
using IsPower2 = Algorithm<bool(int)>;
```

#h(2em)
这个问题并不难，一种常规的实现是：
```cpp
// IsPower2Basic
bool operator()(int n) override {
    return (n & (n - 1)) == 0;
}
```

#graybox[【C++学习】#linebreak()
#h(2em)
标准库提供了一个专门的函数`std::has_single_bit`，用于判断一个二进制数据是否恰好只有一个非0比特位（对于整数来说，这等价于2的幂次）。`<bit>`中还包括很多其他常用的位操作函数，编译器通常会将这些函数优化为目标平台上的对应汇编指令。
```cpp
// IsPower2SingleBit
bool operator()(int n) override {
    return std::has_single_bit(static_cast<unsigned int>(n));
}
```
]

上述两种简单的检查方法只需要常数次的计算，时间复杂度和空间复杂度都是$O(1)$。对于既不熟悉二进制位运算，又不了解标准库的程序员，可能会写出下面的算法来解决这个问题：

```cpp
// IsPower2Recursive
bool operator()(int n) override {
    if (n % 2 == 1) {
        return n == 1;
    } else {
        return (*this)(n / 2);
    }
}
```

#h(2em)
这个算法涉及递归，显然它的时间复杂度不再是$O(1)$。为了证明上述算法的有限性，可以采用前述的递降法，如构造$f(n) = max(d | n % 2^d = 0)$为满足$2^d$整除$n$的最大的$d$，使其映射到$NN$上的良序关系。当$n$为奇数的时候，$f(n)=0$到达边界值。但对这种简单的问题，也可以直接显式计算$T(n)$，即函数体的执行次数。计算出有限的$T(n)$，也就在复杂度分析的同时“顺便”证明了算法的有限性。

设$n=k dot 2^d$，其中$k$为正奇数，$d$为自然数。则

$T(n) &= T(k dot 2^d) = 1 + T(k dot 2^(d-1)) = 2 + T(k dot 2^(d-2)) \
&=...= d + T(k) = d + 1 = O(d) = O(log(n/k)) \
&= O(log n)$

另一边的$Omega(1)$是显然的。

上面这个$T(n)$的计算过程，本质上仍然是使用了递降法，将$T(dot)$的参数不断递降到递归边界（正奇数$k$），思路和正确性检验的递降法是一致的。它利用了$T(dot)$的递归式去显式地计算这个值。这里注明一点：因为计算机领域广泛使用二进制，所以未指定底数的对数符号“$log$”，_底数默认_为2。// 而因为换底公式的存在，在复杂度记号下无论使用什么底数都没有区别。_您可能会发现，这个算法在给定错误值，如0和-1的时候会陷入无限递归，这属于稳健性问题，您可以自己改正它。_

同样，可以显式地计算下面这个算法的$T(n)$。

```cpp
// IsPower2Iterative
bool operator()(int n) override {
    int m { 1 };
    while (m < n) {
        m *= 2;
    }
    return m == n;
}
```

#h(2em)
上面的两个实现，并不是同一算法的迭代形式和递归形式。这两个算法的区别在两个方面。第一，迭代版本的迭代方向是“递增”而不是“递降”；第二，递归边界和循环终止条件不对应。第二点是更加本质的区别，它使得两种算法的时间复杂度有所不同。递归算法的时间复杂度为$O(log n)$和$Omega(1)$，而迭代算法为$Theta(log n)$。 // ，_您可以自己证明这一点_。_此外，这个迭代算法也存在一定程度的稳健性问题，如当输入_$n = 2^31-1$_时，就会陷入无限循环，您可以想办法改正它。_

// 如果您掌握了对循环和递归相互转换，您可以实现IsPower2Recursive的迭代版本，以及IsPower2Iterative的递归版本。

另一方面，二者的空间复杂度也有所不同。在迭代算法中，只引入了1个临时变量$m$，因此空间复杂度是$O(1)$。而在递归算法中，看似一个临时变量都没有引入，空间复杂度也应该是$O(1)$，实则不然。递归算法在达到递归边界之前，每一次递归调用的函数都在等待内层递归的返回值。到达递归边界、判断完成后，这一结果被一级一级传上去，途中调用函数占据的空间才会被销毁（参见《操作系统》）。因此，对于递归算法，递归所占用的空间在复杂度意义上等于_最大递归深度_。IsPower2Recursive的空间复杂度同样是$O(log n)$和$Omega(1)$的。

考试时往往更加重视_时间复杂度_，因为现代计算机的内存通常足够普通的程序使用，而且《数据结构》中涉及的大多数算法，空间复杂度要么显而易见、要么能在计算时间复杂度的时候顺便算出来。
但空间效率仍然是衡量数据结构的重要指标。这个空间效率不单指空间复杂度，也包含被复杂度隐藏下去的和数据结构相关的_常数_。比方说，如果在同一计算机上，数据结构A比数据结构B的常数低10倍，那么它就能存放10倍的数据，这个优势是非常大的——即使二者的空间复杂度一致。

=== 快速幂 <sum:complexity:power>

在上一小节，如果认为$n$是“问题规模”，那么就不能说奇数的情况是“最好情形”，因为此时没有“情形”的概念；从而不能说最好$O(1)$和最坏$Omega(log n)$。但如果认为$n$的_位宽_$log n$是“问题规模”，则可以这么说。这一现象反映了用位宽，也就是“输入规模”来表示问题规模的好处。经典教材@邓俊辉2013数据结构 也建议这样表示问题规模，并使用了快速幂作为举例阐述这个问题。

#bluetxt[实验`power.cpp`。]
快速幂是一个解决求幂问题的算法。求幂问题中，我们输入两个正整数$a$和$b$，输出$a^b$。

```cpp
using PowerProblem = Algorithm<int(int, int)>;
```

#h(2em)
基本的求幂算法，和求和类似：

```cpp
// PowerBasic
int operator()(int a, int b) override {
    int result { 1 };
    for (int i { 0 }; i < b; ++i) {
        result *= a;
    }
    return result;
}
```

#h(2em)
您可以毫不费力地看出这个算法的时间复杂度是$Theta(b)$。当$b$比较大时，这个算法的时间效率很低。这是因为，在计算$a^b$的时候，采用的递推式是$a^b = (a(a(a(a(a ...(a dot a)...)))))$，像普通的$b$个数相乘一样简单地循环，没有利用$a^b$的在计算上的自相似性。

事实上，可以将这$b$个$a$两两分组。如果$b$是偶数，那么恰好可以分成$b/2$组，于是只需要计算$(a^2)^(b/2)$。奇数的情形需要乘上那个没能进组的$a$。这样，通过1到2次乘法，将$b$次幂问题化归到了$b/2$次幂问题。

```cpp
int operator()(int a, int b) override {
    if (b == 0) {
        return 1;
    } else if (b % 2 == 1) {
        return a * (*this)(a * a, b / 2);
    } else {
        return (*this)(a * a, b / 2);
    }
}
```

#h(2em)
容易证明这个算法的时间、空间复杂度均为$Theta(log b)$。示例代码还提供了它的迭代版本，_您也可以试着自己将它改为迭代_。通常，$Theta(log b)$复杂度的求幂算法都称为快速幂，除了上面介绍的这种实现（借助$a^b=(a^2)^(b/2)$），还有另一种实现（借助$a^b = (a^(b/2))^2$），_您也可以试着去实现它_。

那么，这个算法的_问题规模_是什么？

最自然的想法是，它的问题规模是$b$。上述两种算法的复杂度都可以用这个问题规模表示；至于$a$的值，则被归入“情况”的范畴，并且它也不会影响到这两个算法的复杂度。

另一种学说认为，它的问题规模是$log b$。这一学说的依据是：_问题规模_应当是描述这一问题的输入需要的数据量（即_输入规模_）。在这个问题中，要描述问题中的$b$，在二进制计算机中需要$log b$个比特的数据，所以问题规模是$log b$。

这两种方法各有利弊。第一种学说的优点在于形象直观，容易理解；第二种学说的优点则在于有迹可循，定义统一。比如，如果让快速幂中的$b$允许超出`int`限制，比如使用Java中的`BigInteger`，那么$b$势必用数组或者类似的数据结构表示（注意，此时不能认为两数相乘是$O(1)$的，因此复杂度的形式会有所不同）。这个时候，因为实质上输入的是一个数组，即使是“直观派”也会倾向于将“数组的大小”也就是$log b$作为问题规模。于是，“直观派”无法让问题规模的定义在扩展的情况下保持统一，而“输入规模派”可以做到这一点。

在大多数情况下，这两种学说并无分歧。大部分教材支持“输入规模派” @邓俊辉2013数据结构，而较早的书上没有讨论这个问题 @严蔚敏1997数据结构，通常这个问题对解题也没有任何影响。

=== 复杂度的积分计算 <sum:complexity:integral>

#bluetxt[实验`integral.cpp`。]递归算法的复杂度分析在之后还会讨论更多技术。一类比较简单的复杂度问题是每层循环的迭代次数都很直观的多重循环问题。比如前面的IsPower2Iterative，可以一眼就看出来迭代的次数是$Theta(log n)$。这种问题通常可以用积分计算，而不需要用递降法。下面是一个没什么实际意义的例子。

```cpp
int f(int n) {
    int result = 0;
    for (int i { 1 }; i <= n; ++i) {
        for (int j { 1 }; j <= i; ++j)
            for (int k { 1 }; k <= j; ++k)
                for (int l { 1 }; l <= j; l *= 2)
                    result += k * l;
    }
    return result;
}
```

#h(2em)
很容易看出，要分析该算法的时间复杂度，只需要算循环体被执行了几次，也就是计算：
$
T(n)=sum_(i=1)^n sum_(j=1)^i sum_(k=1)^j (1+floor(log j))
= sum_(i=1)^n sum_(j=1)^i j dot (1+floor( log j))
$

#h(2em)
要显式地求出这个和式非常困难。幸运的是，需要求出的是复杂度而不是精确的值，常数和小项都可以在求和过程被省略掉。这给了您解决它的手段：
离散的_求和_问题可以直接转换成连续的_积分_问题。

如果我们只需要一个渐进复杂度，那么积分也不需要真的去求，每次积的时候直接乘上一个线性量就可以。
如果想要估算常数，则求积分的时候可以每一步只保留最高次项。

比如，上面的求和式可以计算如下：
$
T(n)&=sum_(i=1)^n sum_(j=1)^i j dot (1+floor(log j))=O(integral_0^n integral_0^x y(1+log y) "d" y "d" x) \
&=O(integral_0^n integral _0^x y log y "d" y "d" x)=O(integral_0^n x^2 log x "d" x)=O(n^3 log n)
$

#h(2em)
其中，第一步是将求和符号转换成积分；消去积分符号的过程是做了两次“乘上一个线性量”的操作。可以看出对于$l$的分析来说，可以直接使用更简单的$log j$代替实际执行次数$1+floor(log j )$。如@fig:sum2 所示，该函数的实际执行时间确实和$n^3 log n$近似成线性关系。

#figure(
    image("images/sum2.svg", width: 80%),
    caption: "复杂度验证结果",
) <fig:sum2>

// TODO: 在GCC上重新生成这个图

// \begin{figure}
//   \centering
//   \includegraphics[width=0.7\linewidth]{figures/sum2.pdf}
//   \caption{复杂度验证结果}
//   \label{fig:sum2}
// \end{figure}

如果想要估算常数，只需要：
$
T(n)&=sum_(i=1)^n sum_(j=1)^i j dot (1+floor(log j)) tilde integral_0^n integral_0^x y(1+ log y) "d" y "d" x \
& tilde integral_0^n integral_0^x y log y "d" y "d" x tilde integral_0^n 1/2 x^2 log x "d" x tilde 1/6 n^3 log n
$

#h(2em)
这里最后的$1/6$就是常系数。

=== 多重循环复杂度的简单估算 <sum:complexity:trick>

上面这种积分的方法是计算此类循环算法的时间复杂度及其常数的一般方法。在熟练之后，可以用一些小技巧来处理。下面介绍一些小技巧；当然，如果时间充足，还是建议用积分方法去严格地进行计算。

在这类循环算法中，每一层循环主要有下面这几种典型的形式：

```cpp
for (int i { 1 }; i <= n; ++i)    { /* (1) */ } 
for (int i { 1 }; i <= n; i *= 2) { /* (2) */ }
for (int i { 2 }; i <= n; i *= i) { /* (3) */ }
```

+ 线性增长的循环，无论它出现在什么位置，都会为复杂度增加一个线性项$n$。
+ 指数增长的循环，如果它出现在最内层（或可以被交换到最内层，下同），那么会为复杂度增加一个对数项$log n$；如果它不出现在最内层，_通常_不会影响复杂度。
+ 幂塔增长的循环，如果它出现在最内层，那么会为复杂度增加一个迭代对数项$log^* n$（关于迭代对数，您不需要了解更多）；如果它不出现在最内层，_通常_不会影响复杂度。

#h(2em)
当（2）（3）出现在非最内层时，通常不会影响复杂度。这一点看起来没有那么显然，甚至很容易被忘记。下面用一个典型的例子来说明上面的（2）。（3）的情况是类似的。

```cpp
int f(int n) {
    int result = 0;
    for (int i { 1 }; i <= n; i *= 2) {
        for (int j { 1 }; j <= i; ++j)
            for (int k { 1 }; k <= j; ++k)
                for (int l { 1 }; l <= j; l *= 2)
                    result += k * l;
    }
    return result;
}
```

#h(2em)
上面的这个程序，和上一小节展示的例子相比，只有最外层$i$的循环，从线性递增改成了指数递增。以下通过积分方法解决此问题的方法。

$
T(n)&=sum_(i=1)^(floor(log n)) sum_(j=1)^(2^i) j dot (1+ floor(log j))=O(integral_0^(log n)integral_0^(2^x) y(1+log y) "d" y "d" x) \
&=O(integral_0^(log n) integral_0^(2^x) y log y "d" y "d" x )=O(integral_0^(log n) 4^x dot x "d" x) \
&=O(integral_0^n t^2 dot log t dot ( "d" t)/t) = O(n^2 log n)
$

#h(2em)
可以发现，在最后一步进行换元$t = 2^x$时，由于$"d" x = ("d" t)/(t ln 2)$会引入一个分母（一次项），该分母和积分引入的、同样是一次的分子会抵消，抵消的结果就是这一层积分并不会升幂。换句话说，在上面这个程序中，指数递增的外层循环$i$是否存在，对时间复杂度没有影响。


== 本章习题

本书的习题按照小节排列，以黑体标注题目难度。#easy 表示基础知识，#medium 表示一般知识，#hard 表示需要思考，#veryhard 是有一定难度的拓展题。

在 @sum:algorithm:sum 中：#linebreak()
+ #easy SumBasic的时间复杂度是多少？
+ #easy SumAP和SumAP2各自在$n$处于什么区间时可以输出正确的值？#linebreak()
+ #medium 如果输入输出范围不是32位的`int`，而是`W`位的带符号整型，则这两种实现各自在$n$处于什么区间时可以输出正确的值？并分析`W` $ arrow.r infinity$时的情况。

#h(2em)
在 @sum:correctness:gcd 中：#linebreak()
+ #easy 分析朴素的最大公因数算法GcdBasic（见`gcd.cpp`）和欧几里得算法的时间复杂度和空间复杂度。
+ #medium 使用减治法推广欧几里得算法，使其能够计算多个数的最大公因数。
// + #hard 狄利克雷（Dirichlet）定理表明，如果`a, b`是随机选择的整数，则`a, b`的最大公因数是1的概率是$6/pi^2$。在此基础上，分析第2题设计的算法的时间复杂度。
+ #easy 假设$m$位整数的乘法和带余数除法时间复杂度为$O(m log m)$@knuth1997artv2 @david2021multiplication，分析在输入数据的位宽为$m$时，朴素的最大公因数算法和欧几里得算法的最坏时间复杂度。
+ #medium 对中国古典名著《九章算术》里介绍的中华更相减损术@邓俊辉2013数据结构 GcdCN（见`gcd.cpp`）做正确性检验，并分析其在`int`和$m$位整数两种情形下的最坏时间复杂度。请注意除以2的操作在计算机中只需要移位就可以完成，因此其时间复杂度和移位一致，是$O(m)$而非$O(m log m)$。
+ #medium 将中华更相减损术转换为递归算法，并分析其空间复杂度。
+ #hard 不考虑最坏情况而讨论一种特殊的情形。狄利克雷（Dirichlet）定理表明，如果`a, b`是随机选择的整数，则`a, b`的最大公因数是1的概率是$6/pi^2$，因此第2题设计的算法会在几次头部减治之后，退化为$a >> b$的情况。在此情况下评估欧几里得算法和中华更相减损术算法的时间性能。
+ #hard 裴蜀（Bézout）定理指出对于任意两个整数`a, b`，存在整数`x, y`使得$a x+b y=gcd(a, b)$。满足条件的$x, y$可以通过如下的扩展欧几里得算法求得。证明该算法的正确性。
    ```cpp
    std::pair<int, int> operator()(int a, int b) override {
        int x { 0 }, y { 1 }, u { 1 }, v { 0 };
        while (a != 0) {
            int q { b / a }, r { b % a };
            int m { x - u * q }, n { y - v * q };
            b = a; a = r; x = u; y = v; u = m; v = n;
        }
        return { b, x };
    }
    ```
+ #veryhard 将上述扩展欧几里得算法推广到欧几里得环$ZZ[sqrt(2)]$上 @cormen2022introduction。

#h(2em)
在 @sum:correctness:array-sum 中：#linebreak()
+ #easy 对迭代算法ArraySumIterative做尾部减治，就对应了`asum.cpp`里展示的减治算法；请实现头部减治所对应的算法。
+ #easy 证明`asum.cpp`中的减治算法和分治算法的正确性，并分析它们的时间复杂度和空间复杂度。
+ #medium 在`asum.cpp`中的分治算法，将数组等分成了两个部分，然后递归地求解这两个部分的和。如果将数组等分成$k$个部分（$k >= 2$是一个常数），然后递归地求解这$k$个部分的和，会得到什么样的算法？分析它的时间复杂度和空间复杂度。
+ #easy 采用本节介绍的减治和分治方法，分别设计求一个数组最大值的算法，并分析它们的时间复杂度和空间复杂度。

#h(2em)
在 @sum:correctness:zero-point 中：#linebreak()
+ #medium 本节所述的二分算法属于分治还是减治？为什么？
+ #medium 在二分算法的示例程序中，如果把$f(l)dot f("mid") <= 0$中的小于等于改为严格小于，会造成什么结果？
+ #hard #bluetxt[实验`mid.cpp`。]在二分算法的示例程序中将`mid`赋值为了$l+(r-l)/2$。其他常见的写法还有$(l+r)/2$和$l/2+r/2$。数学上这两者是相同的，但由于计算机中的数据有位宽的限制，会导致这三种写法的实际效果有所不同。请在整型和浮点型两种场合下，分析这三种写法的优劣。


#h(2em)
在 @sum:complexity:notation 中：#linebreak()
+ #easy 证明$Theta(log _a n) = Theta(log _b n)$对一切$a, b > 1$成立。正是因为这个原因，在计算机领域通常省略底数，直接写作$Theta(log n)$。
+ #easy 证明$log n = O(n^c)$对一切$c > 0$成立。
+ #easy 证明$n^c = O(a^n)$对一切$c > 0, a > 1$成立。
+ #easy 在现代通用个人计算机上，一秒大约可以完成$10^9$数量级的原子操作。假设关于该原子操作的常数为1，那么一个$Theta(n)$的算法只有在$n <= 10^9$的条件下才能在一秒内完成。类似地，请讨论$Theta(log n), Theta(n log n), Theta(n^2), Theta(n^3), Theta(2^n)$以及$Theta(n!)$的算法分别在多大的$n$下才能在一秒内完成。
+ #easy 如果$T(n)$是等差数列，那么它的时间复杂度是什么？如果$T(n)$是等比数列，那么它的时间复杂度是什么？

#h(2em)
在 @sum:complexity:misunderstanding 中：#linebreak()
+ #medium 在$O(log(n!)), Theta(log(n!)), Omega(log(n!)), O(n log n),Theta(n log n), Omega(n log n)$之间，写出所有可以用等号连接的符号对。
+ #medium 正文中寻找第一个偶数的算法是从前向后遍历数组的，如果从后向前遍历数组，会得到什么样的结果？如何才能刻画这两种算法的效率差异？

#h(2em)
在 @sum:complexity:power2 中：#linebreak()
+ #easy 证明IsPower2Iterative的时间复杂度是$Theta(log n)$，空间复杂度是$O(1)$；而IsPower2Recursive的时间复杂度和空间复杂度均为$O(log n)$和$Omega(1)$。
+ #medium 将IsPower2Iterative转换为与其等效的递归算法，将IsPower2Recursive转换为与其等效的迭代算法。
+ #easy `int`溢出问题是否会对本节介绍的几种算法的稳健性产生影响？如果会，如何改正它？
+ #medium 如果按照“输入规模派”的观点，在判断2的幂次的问题中，问题规模应该如何定义？并在这个定义下，分析IsPower2Basic、IsPower2Recursive和IsPower2Iterative的时间复杂度和空间复杂度。
+ #hard 判断2的幂次等价于判断一个正整数的二进制表示是否只有一个1。现在我们希望输出一个正整数的二进制表示中1的数量，在不借用`<bit>`库的情况下，分别利用迭代和递归设计相应的解决方案，并分析它们的时间复杂度和空间复杂度（问题规模采用输入规模定义）。 // TODO: 和矩阵乘法联系起来
+ #hard 如果希望算法输出的是输入的正整数“按位颠倒”的结果（包括前导0但不包括符号位，如原数据为00000001 11011001 10011111 11000001；则按位颠倒之后的结果为01000001 11111100 11001101 11000000），又该如何设计算法？

#h(2em)
在 @sum:complexity:power 中：#linebreak()
+ #medium 根据正文中的递推式，将PowerBasic转换为对应的减治递归形式。从这个快速幂的例子中也可以看出分治算法相对减治的好处。
+ #medium 将PowerFastRecursive转换为对应的迭代形式。
+ #medium 借助$a^b = (a^(b/2))^2$，写出另一种快速幂的实现。// 和归并排序联系起来

#h(2em)
在 @sum:complexity:integral 和 @sum:complexity:trick 中：#linebreak()
#easy 分析以下程序的时间复杂度（不考虑编译器优化）。定义最内层循环每次执行的时间是1个单位的情况下，估算这些时间复杂度的常数。
+ ```cpp
void F1(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < n; ++j);
}
```
+ ```cpp
void F2(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < i; ++j);
}
```
+ ```cpp
void F3(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 1 }; j < n; j *= 2);
}
```
+ ```cpp
void F4(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < n; j += i);
}
```

+ ```cpp
void F5(int n) {
    for (int i { 0 }, j { 0 }; i < n; i += j, j += 2);
}
```
+ ```cpp
void F6(int n) {
    for (int i { 0 }, j { 1 }; i < n; i += j, j *= 2);
}
```
+ ```cpp
void F7(int n) {
    for (int i { 0 }, j { 1 }; i < n; i += j, j *= j);
}
```
+ ```cpp
void F8(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < n; ++j)
    for (int k { 0 }; k < n; k += j);
}
```
+ ```cpp
void F9(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < n; ++j)
    for (int k { 2 }; k < j; k *= k);
}
```
+ ```cpp
void F10(int n) {
    for (int i { 0 }; i < n; ++i)
    for (int j { 0 }; j < n; j += i)
    for (int k { 1 }; k < j; k *= 2);
}
```

== 本章小结

本书的小结部分是不全面的，我只会介绍每一章的核心要点。如果您认为有必要，应当在自己的笔记上进行更加全面、更加适合您本人学习路径的总结。

本章的核心内容是*递归*的思想方法。
    + 您可以从超限归纳法和递降法的角度，理解递归思想的数学背景。
    + 您可以利用递归的思路分析迭代算法，将迭代终止条件和递归边界联系起来，认识到递归算法和迭代算法的等效性。
    + 您了解了利用递归的思想进行正确性检验和复杂度分析的技术。
    + 您了解了减治和分治这两种经典的递归设计方法。
