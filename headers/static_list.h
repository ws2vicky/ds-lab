#pragma once

#include "list.h"
#include "vector.h"

namespace clazy {

// 这个文件引入静态链表
// 它的实现思路和动态链表有所不同
// 是基于一个向量的

// 静态列表
template <typename T, typename Node = ListNode<T>, bool Circular = false, typename Container = Vector<Node>>
requires (is_base_of_v<clazy_framework::AbstractListNode<T>, Node> && is_base_of_v<clazy_framework::AbstractVector<Node>, Container>)
class StaticList : public List<T, Node, Circular> {
protected:
    Container V;            // 在静态列表中，用向量维护

    // 重载创建新节点的接口，改为在向量中加入一个新元素
    virtual ListNodePos<T> create() const {
        V.push_back(Node());
        return (end(V) - 1).base();
    }
    virtual ListNodePos<T> create(const T& e) const {
        V.push_back(Node(e));
        return (end(V) - 1).base();
    }
    
public:
    StaticList(): List<T, Node, Circular>() {}
    StaticList(const StaticList<T, Node, Circular, Container>& L): List<T, Node, Circular>(L) {}

    // 重载删除元素，因为这里需要将pos处的元素交换到末尾删除
    virtual T remove(ListNodePos<T> pos);
};

// 删除元素，列表删除 + 向量删除
template <typename T, typename Node, bool Circular, typename Container>
T StaticList<T, Node, Circular, Container>::remove(ListNodePos<T> pos) {
    T e = List<T, Node, Circular>::remove(pos); // 先执行列表删除
    ListNodePos<T> last = (end(V) - 1).base();  // 再执行向量删除
    if (pos != last) {                          // 如果pos不在末尾，将末尾的元素移动到pos处
        ListNodePos<T> pred = last->pred(), succ = last->succ();
        pos->data() = last->data();
        pos->setPred(pred->setSucc(pos))->setSucc(succ->setPred(pos)); // 四次赋值
    }
    V.pop_back();
    return e;
}

}