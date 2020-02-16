import Foundation

open class SwiftInjectModule: NSObject {
    
    public let container: SwiftInjectContainer
    
    open class func isContainerAllowed(_ container: SwiftInjectContainer) -> Bool {
        return true
    }
    
    public required init?(container: SwiftInjectContainer = .default) {
        guard type(of: self).isContainerAllowed(container) else {
            return nil
        }
        self.container = container
        super.init()
    }
    
    open func setUp() { }
}
