import Security
import Foundation
import CryptoKit

let bitsInChar = 6
let bitsInOctet = 8
let minCodeVerifierLength = 43
let maxCodeVerifierLength = 128

/// Errors that can occur when generating values for PKCE.
public enum PKCEError: Error {
    /// Requested an invalid code verifier. The requested code verifier length is not within the range of 43 to 128.
    case invalidCodeVerifierLength
    /// An error occured when trying to generate the random octets for the code verifier.
    case failedToGenerateRandomOctets
    /// An error occured when trying to genereate the code challenge for a given code verifier.
    case failedToCreateCodeChallengeChallenge
}
    
/// Generates a new, random code verifier.
/// - Parameter length: The number of characters for the code verifier. The code verifier must have a minimum of 43 characters and a maximum of 128 characters.
/// - Returns: The generated code verifier.
public func generateCodeVerifier(length: Int = 128) throws -> String {
    if length < minCodeVerifierLength || length > maxCodeVerifierLength {
        throw PKCEError.invalidCodeVerifierLength
    }
    let octetCount = length * bitsInChar / bitsInOctet
    let octets = try generateRandomOctets(octetCount: octetCount)
    return encodeBase64URLString(octets: octets)
}

/// Generates a code challenge for a given code verifier.
/// - Parameter codeVerifier: The code verifier for which to generate a code challenge.
/// - Returns: The generated code challenge.
public func generateCodeChallenge(for codeVerifier: String) throws -> String {
    let challenge = codeVerifier
        .data(using: .ascii)
        .map { SHA256.hash(data: $0) }
        .map { encodeBase64URLString(octets: $0) }
    guard let challenge = challenge else {
        throw PKCEError.failedToCreateCodeChallengeChallenge
    }
    return challenge
}

/// Generates a specified number of random octets.
/// - Parameter octetCount: The number of octets to generate.
/// - Returns: The randomly generated octets.
private func generateRandomOctets(octetCount: Int) throws -> [UInt8] {
    var octets = [UInt8](repeating: 0, count: octetCount)
    let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
    if status != errSecSuccess {
        throw PKCEError.failedToGenerateRandomOctets
    }
    return octets
}

/// Encodes a sequence of octets as a Base64 URL string.
/// - Parameter octets: The octets to be encoded.
/// - Returns: The Base64 URL-encoded string.
private func encodeBase64URLString<S>(octets: S) -> String where S: Sequence, UInt8 == S.Element {
    let data = Data(octets)
        return data
            .base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .trimmingCharacters(in: .whitespaces)
}
