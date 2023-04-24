﻿module;
#include <functional>

export module BinaryTree.Traverse.BinaryTreeLevelOrderTraverse;

import BinaryTree.BinaryTreeNode;
import BinaryTree.Traverse.AbstractBinaryTreeTraverse;
import Queue;

export namespace dslab {

template <typename T>
class BinaryTreeLevelOrderTraverse : public AbstractBinaryTreeTraverse<T> {
public:
    void operator()(BinaryTreeNodeConstPos<T> p, std::function<void(const T&)> visit) override {
        Queue<BinaryTreeNodeConstPos<T>> Q { p };
        while (!Q.empty()) {
            if (auto node { Q.dequeue() }; node) {
                this->call(visit, node);
                Q.enqueue(node->left());
                Q.enqueue(node->right());
            }
        }
    }
};

}