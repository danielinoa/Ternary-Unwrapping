import Foundation

//: # Ternary Unwrapping in Swift

//: Definition

precedencegroup Group { associativity: right }

infix operator ??: Group
func ?? <I, O>(_ input: I?,
               _ handler: (lhs: (I) -> O, rhs: () -> O)) -> O {
    guard let input = input else {
        return handler.rhs()
    }
    return handler.lhs(input)
}

infix operator |: Group
func | <I, O>(_ lhs: @escaping (I) -> O,
              _ rhs: @autoclosure @escaping () -> O) -> ((I) -> O, () -> O) {
    return (lhs, rhs)
}

//: Usage

let optionalNumber: Int? = 1

// This approach is overwrought.
let sentence: String?
if let number = optionalNumber {
    sentence = "My favorite number is \(number)"
} else {
    sentence = nil
}

// This approach force unwraps which isn't ideal.
let sentence1: String? = optionalNumber != nil ?  "My favorite number is \(optionalNumber!)" : nil

// This approach is concise and leverages the Ternary Unwrapping Operator.
let sentence2: String? = optionalNumber ?? { "My favorite number is \($0)" } | nil
