//
//  UnknownRoute.swift
//  Router
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//
import Foundation
import RouterInterface

struct UnknownRoute: Route {
    var path: String = "/unknown"
    var data: Data?
}
