//
//  GitHubPullRequest.swift
//  Models
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation

public struct GitHubPullRequest: Decodable, Equatable, Sendable {
    public let nodeId: String
    public let htmlUrl: URL
    public let number: UInt32
    public let state: State
    public let title: String
    public let body: String?
    public let user: GitHubOwner
    public let createdAt: Date
    public let updatedAt: Date?
    public let closedAt: Date?
    public let mergedAt: Date?

    public enum State: String, Decodable, Sendable {
        case open, closed
    }

    public init(
        nodeId: String,
        htmlUrl: URL,
        number: UInt32,
        state: State,
        title: String,
        body: String?,
        user: GitHubOwner,
        createdAt: Date,
        updatedAt: Date?,
        closedAt: Date?,
        mergedAt: Date?
    ) {
        self.nodeId = nodeId
        self.htmlUrl = htmlUrl
        self.number = number
        self.state = state
        self.title = title
        self.body = body
        self.user = user
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.closedAt = closedAt
        self.mergedAt = mergedAt
    }
}
