//
//  Future+Zip.swift
//  Terse
//
//  Created by John Connolly on 2019-01-02.
//

import Foundation
import NIO

public func zip<A, B>(_ a: EventLoopFuture<A>, _ b: EventLoopFuture<B>) -> EventLoopFuture<(A,B)> {
    return a.and(b)
}

public func zip<A, B, C>(_ a: EventLoopFuture<A>,
                         _ b: EventLoopFuture<B>,
                         _ c: EventLoopFuture<C>) -> EventLoopFuture<(A,B,C)> {
    return  zip(zip(a, b), c).map { ($0.0, $0.1, $1) }
}

public func zip<A, B, C, D>(_ a: EventLoopFuture<A>,
                            _ b: EventLoopFuture<B>,
                            _ c: EventLoopFuture<C>,
                            _ d: EventLoopFuture<D>) -> EventLoopFuture<(A,B,C,D)> {
    return  zip(zip(a, b, c), d).map { ($0.0, $0.1, $0.2, $1) }
}

public func zip<A, B, C, D, E>(_ a: EventLoopFuture<A>,
                               _ b: EventLoopFuture<B>,
                               _ c: EventLoopFuture<C>,
                               _ d: EventLoopFuture<D>,
                               _ e: EventLoopFuture<E>) -> EventLoopFuture<(A,B,C,D,E)> {
    return  zip(zip(a, b, c, d), e).map { ($0.0, $0.1, $0.2, $0.3, $1) }
}
