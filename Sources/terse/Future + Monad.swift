//
//  Future + Monad.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation
import NIO

infix operator >>-: MonadicPrecedenceLeft

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


public func pipe<A, B, C>(
    _ f: @escaping (_ a: A) -> EventLoopFuture<B>,
    _ g: @escaping (_ b: B) -> EventLoopFuture<C>
    )
    -> (A) -> EventLoopFuture<C> {
    return f >=> g
}

public func pipe<A, B, C, D>(
    _ f: @escaping (A) -> EventLoopFuture<B>,
    _ g: @escaping (B) -> EventLoopFuture<C>,
    _ h: @escaping (C) -> EventLoopFuture<D>
    )
    -> (A) -> EventLoopFuture<D> {
    return f >=> g >=> h
}

public func pipe<A, B, C, D, E>(
    _ f: @escaping (A) -> EventLoopFuture<B>,
    _ g: @escaping (B) -> EventLoopFuture<C>,
    _ h: @escaping (C) -> EventLoopFuture<D>,
    _ i: @escaping (D) -> EventLoopFuture<E>
    )
    -> (A) -> EventLoopFuture<E> {
    return f >=> g >=> h >=> i
}

public func pipe<A, B, C, D, E, F>(
    _ f: @escaping (A) -> EventLoopFuture<B>,
    _ g: @escaping (B) -> EventLoopFuture<C>,
    _ h: @escaping (C) -> EventLoopFuture<D>,
    _ i: @escaping (D) -> EventLoopFuture<E>,
    _ j: @escaping (E) -> EventLoopFuture<F>
    )
    -> (A) -> EventLoopFuture<F> {
    return f >=> g >=> h >=> i >=> j
}

public func pipe<A, B, C, D, E, F, G>(
    _ f: @escaping (A) -> EventLoopFuture<B>,
    _ g: @escaping (B) -> EventLoopFuture<C>,
    _ h: @escaping (C) -> EventLoopFuture<D>,
    _ i: @escaping (D) -> EventLoopFuture<E>,
    _ j: @escaping (E) -> EventLoopFuture<F>,
    _ k: @escaping (F) -> EventLoopFuture<G>
    )
    -> (A) -> EventLoopFuture<G> {
    return f >=> g >=> h >=> i >=> j >=> k
}
