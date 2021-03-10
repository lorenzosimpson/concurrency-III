import UIKit

let sharedAccessQueue = DispatchQueue(label: "Shared Resource Queue")
let lock = NSLock()

extension NSLock {
    func withLock(_ work: () -> Void) {
        lock()
        work()
        unlock()
    }
}

var sharedResource = 40


DispatchQueue.concurrentPerform(iterations: 100) { (threadNumber) in
    lock.withLock {
        print("Executing concurrent perform #\(threadNumber + 1)")
        var copyOfResource = sharedResource
        copyOfResource += 1
        sharedResource = copyOfResource
    }
    
}
print("Shared Resource: \(sharedResource)")


DispatchQueue.concurrentPerform(iterations: 5) { (threadNumber) in
    sharedAccessQueue.sync {
        print("Executing concurrent perform #\(threadNumber + 1)")
        var copyOfResource = sharedResource
        copyOfResource += 1
        sharedResource = copyOfResource
    }
    
}
print("Shared Resource: \(sharedResource)")
