//
//  GitHubRepository.swift
//  Models
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import Foundation

public struct GitHubRepository: Codable, Equatable, Sendable {
    public let id: UInt64
    public let name: String
    public let owner: GitHubOwner
    public let fullName: String
    public let description: String?
    public let htmlUrl: URL
    public let url: URL
    public let createdAt: Date
    public let language: String?
    public let stargazersCount: Int
    public let watchersCount: Int
    public let license: License?

    public struct License: Codable, Equatable, Sendable {
        public let name: String
        public let url: URL?

        public init(name: String, url: URL?) {
            self.name = name
            self.url = url
        }
    }
}
