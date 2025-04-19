//
//  NavigatorSpy.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import RouterInterface
import UIKit

public final class NavigatorSpy: Navigator {
    public enum Method: Equatable {
        case push, present, pop, popToRoot
    }
    
    public private(set) var methods: [Method] = []
    
    public init() {}
    
    public func push(viewController: UIViewController, animated: Bool) {
        methods.append(.push)
    }
    
    public func present(viewController: UIViewController, animated: Bool) {
        methods.append(.present)
    }
    
    public func pop() {
        methods.append(.pop)
    }
    
    public func popToRoot() {
        methods.append(.popToRoot)
    }
}
