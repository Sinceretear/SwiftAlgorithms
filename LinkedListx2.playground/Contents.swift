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
    
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    //call this on top of every mutating method to allow C-O-W
    //this is to implement the copy-on-write functionality, currently nodes are reference types and not value types
    //book says callying this is O(n) overhead
    // finish this on page 82
    private mutating func copyNodes() {
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
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
list.append(4)

list.pop()
list.removeLast()

list.append(5)
let node = list.node(at: 1)!
list.remove(after: node)

print(list)



extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) {$0?.next}
            return nodes.contains {$0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    public subscript(position: Index) -> Value {
        position.node!.value
    }
}

var listColl = LinkedList<Int>()

for i in 0...9 {
    listColl.append(i)
}

print(listColl)
print(listColl[listColl.startIndex])
print(Array(listColl.prefix(3)))
print(Array(listColl.suffix(3)))

let sum = listColl.reduce(0, +)
print(sum)
