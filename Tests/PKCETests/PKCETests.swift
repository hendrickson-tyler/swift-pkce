import XCTest
@testable import PKCE

final class PKCETests: XCTestCase {
    
    func testCodeVerifierLength() throws {
        var codeVerifier = try PKCE.generateCodeVerifier(length: 43)
        XCTAssertEqual(codeVerifier.count, 43)
        codeVerifier = try PKCE.generateCodeVerifier(length: 128)
        XCTAssertEqual(codeVerifier.count, 128)
    }
    
    @available(iOS 13.0, *)
    func testCodeChallengeGeneration() throws {
        let codeVerifier = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
        XCTAssertEqual(try PKCE.generateCodeChallenge(for: codeVerifier), "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM")
    }

}
