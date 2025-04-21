import Foundation
@testable import Pokemon_Project


class MockData {
    static func loadJSONData(name fileName: String) throws -> Data {
        let bundle = Bundle(for: MockData.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
              
              let data = try? Data.init(contentsOf: url) else {
            throw NSError(domain: "FileNotFound", code: -1)
        }
        return data
    }
}
