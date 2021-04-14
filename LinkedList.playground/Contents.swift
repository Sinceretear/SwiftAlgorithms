// https:// www.youtube.com/watch?v=oLXRe7JWJ5g


class Node {
    
    let value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
    
}


class LinkedList {
    
    var head: Node?
    
    func displayListItems() {
        print("your linked list is:")
        
        var curr = head
        while curr != nil {
            print("\(curr?.value ?? 15) -> " )
            curr = curr?.next
        }
        
    }
    
    func insert(value: Int) {
        if head == nil {
            head = Node(value: value, next: nil)
            return
        }
        
        var curr = head
        while curr?.next != nil {
            curr = curr?.next
        }
        
        curr?.next = Node(value: value, next: nil)
    }
    
    func delete(value: Int) {
        if head?.value == value {
            head = head?.next
        }
        
        var prev: Node?
        var curr = head
        while curr != nil && curr?.value != value {
            prev = curr
            curr = curr?.next
        }
        prev?.next = curr?.next
        
    }
    
    
    func setupDummyNodes() {
        
        let thirdNode = Node(value: 3, next: nil)
        let secondNode = Node(value: 2, next: thirdNode)
        
        head = Node(value: 1, next: secondNode)
        
    }
    
}


let sampleList = LinkedList()
sampleList.insert(value: 1)
sampleList.insert(value: 2)
sampleList.insert(value: 3)
sampleList.insert(value: 4)

sampleList.delete(value: 3)

//sampleList.setupDummyNodes()

sampleList.displayListItems()


//print(sampleList.head?.value)
//print(sampleList.head?.next?.value)
//print(sampleList.head?.next?.next?.value)
//print(sampleList.head?.next?.next?.next?.value)
