#include "stack_shared.h"
using namespace clazy_framework;

// 这个例子演示了共享栈的操作

template <typename T>
using SharedStack = clazy::SharedStack<T>;

int main() {
    SharedStack<int> SS; // 使用共享栈
    auto&& [S0, S1] = SS.getStacks(); // 获得共享栈中的两个栈，接下来可以对两个栈分别进行操作
    cout << "\tSS = " << SS << endl; // 输出共享栈的初始状态
    for (int i = 0; i < 3; i++) { // 观察两个栈交替插入的状态
        cout << "S0 push " << i << endl;
        S0.push(i);
        cout << "\tSS = " << SS << endl;
        cout << "S1 push " << i << endl;
        S1.push(i);
        cout << "\tSS = " << SS << endl;
    }
    while (!S0.empty()) { // 观察将左边的栈清空的过程
        cout << "S0 pop " << S0.pop() << endl;
        cout << "\tSS = " << SS << endl;
    }
    for (int i = 3; i < 10; i++) { // 观察右侧栈单侧增长至溢出的过程
        cout << "S1 push " << i << endl;
        S1.push(i);
        cout << "\tSS = " << SS << endl;
    }

    return 0;
}