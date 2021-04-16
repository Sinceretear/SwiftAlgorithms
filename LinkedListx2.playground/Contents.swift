//
//class Node {
//
//    let value: Int
//    var next: Node?
//
//    init(value: Int, next: Node?) {
//        self.value = value
//        self.next = next
//    }
//
//}
//let fourthNode = Node(value: 4, next: nil)
//let thirdNode = Node(value: 3, next: fourthNode)
//let secondNode = Node(value: 2, next: thirdNode)
//let firstNode = Node(value: 1, next: secondNode)
//
//func printLL(head: Node?) {
//
//    var curr = head
//    while curr != nil {
//        print(curr!.value)
//        curr = curr?.next
//    }
//
//}
//
////printLL(head: firstNode)
//
//func reverseList(head: Node?) -> Node? {
//
//    var curr = head
//    var prev: Node?
//    var next: Node?
//
//    while curr != nil {
//        next = curr?.next
//        curr?.next = prev
//
//        print("Prev: \(prev?.value ?? -1), Curr: \(curr?.value ?? -1), Next: \(next?.value ?? -1)")
//
//        prev = curr
//        curr = next
//    }
//
//    return prev
//}
//
//let myReversedList = reverseList(head: firstNode)
//
//printLL(head: myReversedList) // prints 4321


public class Node<Value> {
    
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
        
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    // will try to retrive a node at that index
    public func node(at index: Int) -> Node<Value>? {
        
        var curr =  head
        var currIndex = 0
        
        while curr != nil && currIndex < index {
            curr = curr!.next
            currIndex += 1
        }

        return curr
    }
    
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
        
    }
    
    
    
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}


var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)

print(list)
