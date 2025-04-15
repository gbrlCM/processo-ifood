//
//  ProductDetailMock.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 14/04/25.
//
import Foundation

struct DecodableMock: Decodable, Equatable {
    let name: String
    let birthDay: Int

    static var json: Data? {
        let stringData = "{ \"name\": \"John Doe\", \"birth_day\": 21 }"
        return stringData.data(using: .utf8)
    }

    static var mock: DecodableMock {
        DecodableMock(name: "John Doe", birthDay: 21)
    }
}
