import Foundation

public enum InjectionContainerMode {
    case alwaysNew
    case useContainer
}

typealias FunctionType = Any

class Injection {
    
    let mode: InjectionContainerMode
    let resolver: FunctionType
    
    init(mode: InjectionContainerMode, resolver: FunctionType) {
        self.mode = mode
        self.resolver = resolver
    }
}

public class InjectionContainer {
    
    public struct Key: ExpressibleByStringLiteral {
        
        public typealias StringLiteralType = String
        
        let rawValue: String
        
        public init(stringLiteral value: String) {
            self.rawValue = value
        }
    }
    
    public static let `default` = InjectionContainer()
    
    public init() { }
    
    private var registrations = [String: Injection]()
    private var savedValues = [String: Any]()
    
    private func name<T: Any>(forService service: T.Type, name: String?) -> String {
        if let name = name {
            return String(describing: service) + "-" + name
        } else {
            return String(describing: service) + #"/\"#
        }
    }
    
    public func register<T: Any>(_ service: T.Type, name: Key? = nil, mode: InjectionContainerMode,
                                 resolver: @escaping (InjectionContainer) -> T) {
        let usedName = self.name(forService: service, name: name?.rawValue)
        let injection = Injection(mode: mode, resolver: resolver)
        registrations[usedName] = injection
    }
    
    public func resolve<T: Any>(_ service: T.Type, name: Key? = nil) -> T? {
        let usedName = self.name(forService: service, name: name?.rawValue)
        guard let registration = registrations[usedName] else {
            return nil
        }
        
        if registration.mode == .useContainer, let savedValue = savedValues[usedName] as? T {
            return savedValue
        }
        
        let resolver = registration.resolver as! (InjectionContainer) -> T
        let value  = resolver(self)
        
        if registration.mode == .useContainer {
            savedValues[usedName] = value
        }
        
        return value
    }
    
    public func resolve<T: Any>(name: Key? = nil) -> T {
        guard let value = resolve(T.self, name: name) else {
            fatalError("Could not resolve service: \(String(describing: T.self))")
        }
        return value
    }
}
