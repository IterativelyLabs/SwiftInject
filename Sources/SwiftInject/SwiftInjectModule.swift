import Foundation

open class DependencyInjectionModule: NSObject {
    
    public let container: InjectionContainer
    
    open class func isContainerAllowed(_ container: InjectionContainer) -> Bool {
        return true
    }
    
    public required init?(container: InjectionContainer = .default) {
        guard type(of: self).isContainerAllowed(container) else {
            return nil
        }
        self.container = container
        super.init()
    }
    
    open func setUp() { }
}
