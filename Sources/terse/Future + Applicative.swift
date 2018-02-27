//
//  Future + Applicative.swift
//  Async
//
//  Created by John Connolly on 2018-02-26.
//

import Foundation
import Async

infix operator <*>: MonadicPrecedenceLeft

///  apply an future function to an future value
public func <*> <T, U>(f: Future<((T?) -> U)>, a: Future<T>) -> Future<U> {
    return f.flatMap(to: U.self) { f in
        return a <^> f
    }
}

///  apply an future function to an future value
public func <*> <T, U>(f: Future<((T) -> U)>, a: Future<T>) -> Future<U> {
    return f.flatMap(to: U.self) { f in
        return a <^> f
    }
}
