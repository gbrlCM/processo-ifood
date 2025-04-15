//
//  Session.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//

import Foundation

public protocol Session: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: Session {}
