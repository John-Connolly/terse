//
//  Future + Monad.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation
import Async

infix operator >>-: MonadicPrecedenceLeft

/// flatmaps a Future if the future throws an error f with never be called.
public func >>- <A, B>(a: Future<A>, f: @escaping (A) -> Future<B>) -> Future<B> {
    return a.flatMap(to: B.self) { value -> Future<B> in
        return f(value)
    }
}

infix operator >->: MonadicPrecedenceLeft

/// left-to-right composition operator.
public func >-> <A, B, C>(f: @escaping (A) -> Future<B>, g: @escaping (B) -> Future<C>) -> (A) -> Future<C> {
    return { a in
        f(a) >>- g
    }
}
