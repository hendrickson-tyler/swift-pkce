import XCTest
@testable import PKCE

final class PKCETests: XCTestCase {

    func testInvalidLengthError() throws {
        XCTAssertThrowsError(try generateCodeVerifier(length: 42), "Generating a code verifier with a length of 43 didn't throw an error") { error in
            XCTAssertEqual(error as? PKCEError, .invalidCodeVerifierLength, "The thrown error wasn't for invalid length")
        }
        XCTAssertThrowsError(try generateCodeVerifier(length: 129), "Generating a code verifier with a length of 129 didn't throw an error") { error in
            XCTAssertEqual(error as? PKCEError, .invalidCodeVerifierLength, "The thrown error wasn't for invalid length")
        }
    }

    func testCodeVerifierLength() throws {
        var codeVerifier = try generateCodeVerifier(length: 43)
        XCTAssertEqual(codeVerifier.count, 43, "Code verifier length was not 43")
        codeVerifier = try generateCodeVerifier(length: 128)
        XCTAssertEqual(codeVerifier.count, 128, "Code verifier length was not 128")
    }

    func testCodeChallengeGeneration() throws {
        let codeVerifier = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
        XCTAssertEqual(try generateCodeChallenge(for: codeVerifier), "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM", "Code challenge wasn't generated correctly")
    }

}
