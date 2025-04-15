//
//  GitHubPullRequest.swift
//  Models
//
//  Created by Gabriel Ferreira de Carvalho on 15/04/25.
//
import Foundation

public struct GitHubPullRequest: Decodable, Equatable, Sendable {
    let nodeId: String
    let htmlUrl: URL
    let number: UInt32
    let state: State
    let title: String
    let body: String?
    let user: GitHubOwner
    let createdAt: Date
    let updatedAt: Date?
    let closedAt: Date?
    let mergedAt: Date?

    enum State: String, Decodable {
        case open, closed
    }
}
