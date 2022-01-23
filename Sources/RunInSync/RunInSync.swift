import Foundation

public struct RunInSync {
    private let runner: () async -> Void
    private let state = State()
    private let symbol = Symbol()
    
    @discardableResult
    public init(_ runner: @escaping (() async -> Void)) {
        self.runner = runner
        
        self.run()
        self.wait()
        
        while symbol.getValue() {
            
        }
    }
    
    private func run() {
        Task {
            await state.set(false)
            await self.runner()
            await state.set(true)
        }
    }
    
    private func wait() {
        Task {
            while !(await state.finish) {
                await Task.yield()
            }
            
            symbol.set(false)
        }
    }
}

actor State {
    var finish: Bool
    
    init() {
        finish = false
    }
    
    func set(_ value: Bool) {
        self.finish = value
    }
}

class Symbol {
    private var wait = true
    private let lock = NSLock()
    
    init() {
        
    }
    
    func set(_ value: Bool) {
        lock.lock()
        wait = value
        lock.unlock()
    }
    
    func getValue() -> Bool {
        lock.lock()
        let value = wait
        lock.unlock()
        
        return value
    }
}
