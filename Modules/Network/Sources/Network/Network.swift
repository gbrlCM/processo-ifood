import Foundation

public protocol NetworkProtocol: Actor {
    func fetch<T: Decodable>(from request: URLRequest) async throws -> (T, URLResponse)
    func fetch<T: Decodable>(from url: URL) async throws -> (T, URLResponse)
    func fetch(from url: URL) async throws -> Data
}

public final actor Network: NetworkProtocol {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private let session: Session

    public init(session: Session = URLSession.shared) {
        self.session = session
    }

    public func fetch<T>(from request: URLRequest) async throws -> (T, URLResponse) where T: Decodable {
        let (data, response) = try await session.data(for: request)
        let decodedData = try self.decoder.decode(T.self, from: data)
        return (decodedData, response)
    }

    public func fetch<T>(from url: URL) async throws -> (T, URLResponse) where T: Decodable {
        let (data, response) = try await session.data(from: url)
        let decodedData = try self.decoder.decode(T.self, from: data)
        return (decodedData, response)
    }

    public func fetch(from url: URL) async throws -> Data {
        let (data, _) = try await session.data(from: url)
        return data
    }
}
