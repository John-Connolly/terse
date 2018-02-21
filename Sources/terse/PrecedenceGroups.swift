//
//  PrecedenceGroups.swift
//  terse
//
//  Created by John Connolly on 2018-02-20.
//

import Foundation

precedencegroup MonadicPrecedenceLeft {
    associativity: left
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

precedencegroup MonadicPrecedenceRight {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}
