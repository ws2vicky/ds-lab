﻿module;
#include <functional>

export module Tree.Traverse.TreeLevelOrderTraverse;

import Tree.TreeNode;
import Tree.Traverse.AbstractTreeTraverse;
import Queue;

export namespace dslab {

template <typename T>
class TreeLevelOrderTraverse : public AbstractTreeTraverse<T> {
public:
    void operator()(TreeNodeConstPos<T> p, std::function<void(const T&)> visit) const override {
        if (!p) {
            return;
        }
        Queue<TreeNodeConstPos<T>> Q;
        Q.enqueue(p);
        while (!Q.empty()) {
            auto node { Q.dequeue() };
            visit(node->data());
            for (auto& child : node->children()) {
                Q.enqueue(child);
            }
        }
    }
};

}