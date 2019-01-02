//
//  Future + Monad.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation
import NIO

infix operator >>-: MonadicPrecedenceLeft

/// flatmaps a Future if the future throws an error f with never be called.
public func >>- <A, B>(a: EventLoopFuture<A>, f: @escaping (A) -> EventLoopFuture<B>) -> EventLoopFuture<B> {
    return a.then { value -> EventLoopFuture<B> in
        return f(value)
    }
}

infix operator -<<: MonadicPrecedenceRight

public func -<< <A, B>(f: @escaping (A) -> EventLoopFuture<B>, a: EventLoopFuture<A>) -> EventLoopFuture<B> {
    return a.then { value -> EventLoopFuture<B> in
        return f(value)
    }
}

infix operator >=>: MonadicPrecedenceLeft

/// left-to-right composition operator.
public func >=> <A, B, C>(f: @escaping (A) -> EventLoopFuture<B>,
                          g: @escaping (B) -> EventLoopFuture<C>) -> (A) -> EventLoopFuture<C> {
    return { a in
        f(a) >>- g
    }
}

infix operator <=<: MonadicPrecedenceRight

public func <=< <A, B, C>(f: @escaping (B) -> EventLoopFuture<C>,
                          g: @escaping (A) -> EventLoopFuture<B>) -> (A) -> EventLoopFuture<C> {
    return { a in
        g(a) >>- f
    }
}
