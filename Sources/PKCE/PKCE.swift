import Security
import Foundation
import CryptoKit

let BITS_IN_CHAR = 6
let BITS_IN_OCTET = 8

public struct PKCE {

    public init() {
    }
    
    /// Generates a new, random code verifier.
    /// - Parameter length: The number of characters for the code verifier. The code verifier must have a minimum of 43 characters and a maximum of 128 characters.
    /// - Returns: The generated code verifier.
    public static func generateCodeVerifier(length: Int = 128) throws -> String {
        let octetCount = length * BITS_IN_CHAR / BITS_IN_OCTET
        let octets = try generateRandomOctets(octetCount: octetCount)
        return encodeBase64URLString(octets: octets)
    }
    
    
    @available(iOS 13.0, *)
    /// Generates a code challenge for a given code verifier.
    /// - Parameter codeVerifier: The code verifier for which to generate a code challenge
    /// - Returns: The generated code challenge.
    public static func generateCodeChallenge(for codeVerifier: String) throws -> String {
        let challenge = codeVerifier
            .data(using: .ascii)
            .map { SHA256.hash(data: $0) }
            .map { encodeBase64URLString(octets: $0) }
        if let challenge = challenge {
            return challenge
        } else {
            throw PKCEError.failedToCreateCodeChallengeChallenge
        }
    }
    
    private static func generateRandomOctets(octetCount: Int) throws -> [UInt8] {
        var octets = [UInt8](repeating: 0, count: octetCount)
        let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
        if status == errSecSuccess {
            return octets
        } else {
            throw PKCEError.failedToGenerateRandomOctets
        }
    }
    
    private static func encodeBase64URLString<S>(octets: S) -> String where S: Sequence, UInt8 == S.Element {
        let data = Data(octets)
            return data
                .base64EncodedString()
                .replacingOccurrences(of: "=", with: "")
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "/", with: "_")
                .trimmingCharacters(in: .whitespaces)
    }
}

/// Errors that can occur when generating values for PKCE.
private enum PKCEError: Error {
    /// An error occured when trying to generate the random octets for the code verifier.
    case failedToGenerateRandomOctets
    /// An error occured when trying to genereate the code challenge for a given code verifier.
    case failedToCreateCodeChallengeChallenge
}
