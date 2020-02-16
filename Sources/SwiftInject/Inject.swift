import Foundation

@propertyWrapper
public struct Inject<Value> {
    
    public var wrappedValue: Value?
    
    public init(name: SwiftInjectContainer.Key?, container: SwiftInjectContainer) {
        wrappedValue = container.resolve(Value.self, name: name)
    }
    
    public init(container: SwiftInjectContainer) {
        self.init(name: nil, container: container)
    }
    
    public init(name: SwiftInjectContainer.Key?) {
        self.init(name: name, container: .default)
    }
    
    public init() {
        self.init(name: nil, container: .default)
    }
}
