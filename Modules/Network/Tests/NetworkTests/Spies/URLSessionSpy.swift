//
//  URLSessionSpy.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import Foundation
@testable import Network

final actor URLSessionSpy: Session {
    public enum Method: Equatable, Sendable {
        case dataRequest(request: URLRequest)
        case dataUrl(url: URL)
    }

    private var registredResponses: [URL: Data] = [:]
    public private(set) var methods: [Method] = []

    public init() {}

    func data(from url: URL) async throws -> (Data, URLResponse) {
        methods.append(.dataUrl(url: url))
        return (try fetchResponse(from: url), URLResponse())
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        methods.append(.dataRequest(request: request))
        guard let url = request.url else { throw URLError(.badURL) }
        return (try fetchResponse(from: url), URLResponse())
    }

    private func fetchResponse(from url: URL) throws -> Data {
        if let value = registredResponses[url] {
            return value
        } else {
            throw URLError(.badServerResponse)
        }
    }

    public func registerResponse(key: URL, _ value: Data) async {
        registredResponses[key] = value
    }
}
