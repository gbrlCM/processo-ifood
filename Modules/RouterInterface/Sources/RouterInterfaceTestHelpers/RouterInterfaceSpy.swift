//
//  RouterInterfaceSpy.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import RouterInterface
import UIKit

public final class RouterInterfaceSpy: RouterProtocol {
    public enum Method: Equatable {
        case view
    }

    public private(set) var methods: [Method] = []
    public private(set) var lastCalledRoute: Route?

    public init() {}

    public var viewResponse: UIViewController?
    public func view(for route: any Route) -> UIViewController? {
        methods.append(.view)
        lastCalledRoute = route
        return viewResponse
    }
}
