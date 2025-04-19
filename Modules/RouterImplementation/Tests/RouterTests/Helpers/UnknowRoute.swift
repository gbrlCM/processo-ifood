//
//  UnknownRoute.swift
//  Router
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation
import RouterInterface

struct UnknownRoute: Route {
    static let path: String = "/unknown"
    var query: [URLQueryItem] = []
}
