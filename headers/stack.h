#pragma once

#include "vector.h"
#include "stack_framework.h"

namespace clazy {

// 基于已有的线性数据结构实现栈
template <typename T, typename Container = Vector<T>>
requires (clazy_framework::is_linear_structure<T, Container>)
class Stack : public clazy_framework::AbstractStack<T> {
protected:
    Container C;
public:   
    virtual void clear() { C.clear(); } // 清空栈
    virtual bool empty() const { return C.empty(); } // 判断栈是否为空
    virtual T top() const { return C.back(); } // 获取栈顶元素
    virtual T pop() { return C.pop_back(); } // 弹出栈顶元素并返回
    virtual void push(const T& e) { C.push_back(e); } // 将元素推入栈

    Stack() {} // 默认构造函数
    Stack(const Stack& S): C(S.C) {} // 复制构造函数
};

}