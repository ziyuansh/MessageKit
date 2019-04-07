/*
 MIT License

 Copyright (c) 2017-2019 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

import Foundation

public enum TransitComponent {
    case airline(String)
    case flight(String)

    public var value: String {
        switch self {
        case .airline(let value), .flight(let value):
            return value
        }
    }

    public var sortOrder: Int {
        switch self {
        case .airline:
            return 0
        case .flight:
            return 1
        }
    }

    internal init?(key: NSTextCheckingKey, value: String) {
        switch key {
        case .airline:
            self = .airline(value)
        case .flight:
            self = .flight(value)
        default:
            return nil
        }
    }
}

public extension Array where Element == TransitComponent {
    func sorted() -> [TransitComponent] {
        return sorted(by: { $1.sortOrder < $0.sortOrder })
    }

    var orderedString: String {
        return reduce("") { (str, component) -> String in
            guard !str.isEmpty else { return component.value }
            return str + " " + component.value
        }
    }
}
