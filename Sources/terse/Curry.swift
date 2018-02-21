//
//  Curry.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation

public func curry<T, U, V>(_ f: @escaping (T, U) -> V) -> (T) -> (U) -> V {
    return { x in { f(x, $0) } }
}

public func curry<T, U, V, W>(_ f: @escaping (T, U, V) -> W) -> (T) -> (U) -> (V) -> W {
    return { x in curry { f(x, $0, $1) } }
}

public func curry<T, U, V, W, X>(_ f: @escaping (T, U, V, W) -> X) -> (T) -> (U) -> (V) -> (W) -> X {
    return { x in curry { f(x, $0, $1, $2) } }
}
