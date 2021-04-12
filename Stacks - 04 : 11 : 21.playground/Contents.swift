// Hunter Walker Apr 11 Data Structures and Algorithms in Swift.
//Stack

import UIKit

public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public init() {
        
    }
    
    mutating func push(_ element: Element) {
        self.storage.append(element)
    }
    
    mutating func pop() -> Element? {
        self.storage.removeLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public var isEmpty: Bool {
        peek() == nil
    }
    
    
}
extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ----top----
        \(storage.map{"\($0)"}.reversed().joined(separator: "\n"))
        """
    }
}


var myStack = Stack<String>()

myStack.push("1st Item")
myStack.push("2nd Item")
myStack.push("3rd Item")
myStack.push("4th Item")
print(myStack.description)
myStack.pop()
print(myStack.description)
print(myStack.isEmpty)
print(myStack.peek())


//create a function that prints the contents of an array in reversed order

struct Stack2<Element> {
    
    var storage: [Element] = []
    
    public init(arr: [Element]) {
        self.storage = arr
    }
    
    mutating func pop() -> Element?{
        storage.removeLast()
    }
    var isEmpty: Bool {
        storage.isEmpty
    }
}

func reverseArray(arr: [Any]) {
    
    var myStack = Stack2(arr: arr)
    
    for x in 0...arr.count {
        if !myStack.isEmpty {
            print(myStack.pop()!)
        }
    }
}

var myArray = [1,2,3,4,5,6,7]
reverseArray(arr: myArray)
