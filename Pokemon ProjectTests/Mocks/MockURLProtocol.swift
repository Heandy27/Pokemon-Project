import Foundation

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?
    static var error: Error?
    static var statusCode: Int = 200
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Simula un error si está definido
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        
        // Crear respuesta HTTP incluso si no hay data
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: MockURLProtocol.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        // Enviar data si existe
        if let data = MockURLProtocol.stubResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        //
    }
}
