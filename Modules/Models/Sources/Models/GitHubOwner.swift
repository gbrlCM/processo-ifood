//
//  GitHubOwner.swift
//  Models
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation

public struct GitHubOwner: Codable, Equatable, Sendable {
    public let login: String
    public let id: UInt64
    public let avatarUrl: URL

    public init(login: String, id: UInt64, avatarUrl: URL) {
        self.login = login
        self.id = id
        self.avatarUrl = avatarUrl
    }
}
