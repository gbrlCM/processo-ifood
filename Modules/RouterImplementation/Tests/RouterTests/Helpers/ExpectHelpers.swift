//
//  ExpectHelpers.swift
//  Router
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation

enum Expectation {
    static func isInstanceOf(_ type: String, object: AnyObject) -> Bool {
        String(describing: object).contains(type)
    }
}
