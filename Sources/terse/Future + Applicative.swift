//
//  Future + Applicative.swift
//  Async
//
//  Created by John Connolly on 2018-02-26.
//

import Foundation
import NIO

infix operator <*>: ApplicativePrecedence

///  apply an future function to an future value
public func <*> <T, U>(f: EventLoopFuture<((T) -> U)>, a: EventLoopFuture<T>) -> EventLoopFuture<U> {
    return f.then { f in
        return a <^> f
    }
}
