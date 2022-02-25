import XCTest
@testable import PKCE

final class PKCETests: XCTestCase {
    
    func testCodeVerifierLength() throws {
        var codeVerifier = try PKCE.generateCodeVerifier(length: 43)
        XCTAssertEqual(codeVerifier.count, 43)
        codeVerifier = try PKCE.generateCodeVerifier(length: 128)
        XCTAssertEqual(codeVerifier.count, 128)
    }
    
}
