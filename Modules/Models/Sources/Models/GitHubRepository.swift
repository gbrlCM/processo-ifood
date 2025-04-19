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
    public let subscribersCount: Int?
    public let openIssues: Int?
    public let forks: Int?
    public let license: License?

    public init(
        id: UInt64,
        name: String,
        owner: GitHubOwner,
        fullName: String,
        description: String?,
        htmlUrl: URL,
        url: URL,
        createdAt: Date,
        language: String?,
        stargazersCount: Int,
        watchersCount: Int,
        subscribersCount: Int?,
        openIssues: Int?,
        forks: Int?,
        license: License?
    ) {
        self.id = id
        self.name = name
        self.owner = owner
        self.fullName = fullName
        self.description = description
        self.htmlUrl = htmlUrl
        self.url = url
        self.createdAt = createdAt
        self.language = language
        self.stargazersCount = stargazersCount
        self.watchersCount = watchersCount
        self.subscribersCount = subscribersCount
        self.openIssues = openIssues
        self.forks = forks
        self.license = license
    }

    public struct License: Codable, Equatable, Sendable {
        public let name: String
        public let url: URL?

        public init(name: String, url: URL?) {
            self.name = name
            self.url = url
        }
    }
}
