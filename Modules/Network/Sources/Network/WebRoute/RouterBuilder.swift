//
//  RouterBuilder.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation

public struct RouterBuilder {
    public let host: Host

    public init(host: Host) {
        self.host = host
    }

    public func build(for components: URLComponents) -> URL? {
        var components = components

        components.scheme = "https"
        components.host = host.rawValue

        return components.url
    }
}

public enum Host: String {
    case api = "api.github.com"
    case web = "github.com"
}
