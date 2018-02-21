//
//  Future + Functor.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation
import Async

infix operator <^>: MonadicPrecedenceLeft

public func <^> <A, B>(a: Future<A>, f: @escaping (A) -> B) -> Future<B> {
    return a.map(to: B.self) { value in
        return f(value)
    }
}
