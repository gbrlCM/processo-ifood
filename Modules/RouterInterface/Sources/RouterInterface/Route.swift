//
//  Route.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Foundation

public protocol Route {
    static var path: String { get }
    var query: [URLQueryItem] { get }
}

extension Route {
    public var path: String { Self.path }
}
