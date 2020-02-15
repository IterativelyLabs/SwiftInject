import Foundation

public class SwiftInjectManager {
    
    public init(container: InjectionContainer = .default) {
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
        
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
        let actualClassCount: Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var dependencyInjectionModules = [SwiftInjectModule.Type]()
        for i in 0 ..< actualClassCount {
            if let currentClass = allClasses[Int(i)] {
                if (class_getSuperclass(currentClass) == SwiftInjectModule.self) {
                    dependencyInjectionModules.append(currentClass as! SwiftInjectModule.Type)
                }
            }
        }
        
        for module in dependencyInjectionModules {
            module.init(container: container)?.setUp()
        }
        
        allClasses.deallocate()
    }
}
