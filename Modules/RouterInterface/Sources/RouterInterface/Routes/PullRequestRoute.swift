//
//  PullRequestRoute.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation

public struct PullRequestRoute: Route {
    public static let path: String = "/pullrequest"
    public let query: [URLQueryItem]

    public init(path: String) {
        self.query = [
            URLQueryItem(name: "path", value: path)
        ]
    }
}
