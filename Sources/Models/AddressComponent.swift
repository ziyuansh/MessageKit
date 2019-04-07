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

public enum AddressComponent {
    case name(String)
    case jobTitle(String)
    case organization(String)
    case street(String)
    case city(String)
    case state(String)
    case zip(String)
    case country(String)

    public var value: String {
        switch self {
        case .name(let value), .jobTitle(let value),
             .organization(let value), .street(let value),
             .city(let value), .state(let value), .zip(let value),
             .country(let value):
            return value
        }
    }

    public var sortOrder: Int {
        switch self {
        case .name:
            return 0
        case .jobTitle:
            return 1
        case .organization:
            return 2
        case .street:
            return 3
        case .city:
            return 4
        case .state:
            return 5
        case .zip:
            return 6
        case .country:
            return 7
        }
    }

    internal init?(key: NSTextCheckingKey, value: String) {
        switch key {
        case .name:
            self = .name(value)
        case .jobTitle:
            self = .jobTitle(value)
        case .organization:
            self = .organization(value)
        case .street:
            self = .street(value)
        case .city:
            self = .city(value)
        case .state:
            self = .state(value)
        case .zip:
            self = .zip(value)
        case .country:
            self = .country(value)
        default:
            return nil
        }
    }
}

public extension Array where Element == AddressComponent {
    func sorted() -> [AddressComponent] {
        return sorted(by: { $1.sortOrder < $0.sortOrder })
    }

    var orderedString: String {
        return reduce("") { (str, component) -> String in
            guard !str.isEmpty else { return component.value }
            return str + ", " + component.value
        }
    }
}
