#pragma once

#include "framework.h"

namespace clazy_framework {

// 这个文件讨论查找这个问题
// 查找操作返回一个pair，其中bool表示是否查找到，P表示查找结果
template <typename P>
using SearchResult = pair<bool, P>;

// 基本的查找
template <typename T, typename Container, typename P>
requires (is_base_of_v<DataStructure<T>, Container>)
class Search : public Algorithm {
protected:
    virtual SearchResult<P> search(Container& C, const T& e) = 0;
public:
    virtual SearchResult<P> apply(Container& C, const T& e) {
        return search(C, e);
    }
};

// 全序集上的查找（基于比较函数）
// 在向量、列表、分块表、BST、B树、B+树、跳表上做查找都使用这个
// 散列是基于散列函数的，不使用这个
template <typename T, typename Container, typename P>
requires (is_base_of_v<DataStructure<T>, Container>)
class OrderedSearch : public Search<T, Container, P> {
protected:
    virtual SearchResult<P> search(Container& C, const T& e, const Comparator<T>& cmp) = 0;
    virtual SearchResult<P> search(Container& C, const T& e) { // 默认
        return search(C, e, less_equal<T>());
    }
public:
    virtual SearchResult<P> apply(Container& C, const T& e, const Comparator<T>& cmp) {
        return search(C, e, cmp);
    }
};

}
