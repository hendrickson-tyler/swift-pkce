import Security
import Foundation

let BITS_IN_CHAR = 6
let BITS_IN_OCTET = 8

public struct PKCE {

    public init() {
    }
    
    /// Generates a new, random code verifier.
    /// - Parameter length: The number of characters for the code verifier. The code verifier must have a minimum of 43 characters and a maximum of 128 characters.
    /// - Returns: The generated code verifier.
    public func generateCodeVerifier(length: Int) throws -> String {
        let octetCount = length * BITS_IN_CHAR / BITS_IN_OCTET
        let octets = try generateRandomOctets(octetCount: octetCount)
        return encodeBase64URLString(octets: octets)
    }
    
    private func generateRandomOctets(octetCount: Int) throws -> [UInt8] {
        var octets = [UInt8](repeating: 0, count: octetCount)
        let status = SecRandomCopyBytes(kSecRandomDefault, octets.count, &octets)
        if status == errSecSuccess {
            return octets
        } else {
            throw PKCEError.failedToGenerateRandomOctets
        }
    }
    
    private func encodeBase64URLString<S>(octets: S) -> String where S: Sequence, UInt8 == S.Element {
        let data = Data(octets)
            return data
                .base64EncodedString() // Regular base64 encoder
                .replacingOccurrences(of: "=", with: "") // Remove any trailing '='s
                .replacingOccurrences(of: "+", with: "-") // 62nd char of encoding
                .replacingOccurrences(of: "/", with: "_") // 63rd char of encoding
                .trimmingCharacters(in: .whitespaces)
    }
}

/// Errors that can occur when generating values for PKCE.
private enum PKCEError: Error {
    /// An error occured when trying to generate the random octets for the code verifier.
    case failedToGenerateRandomOctets
}
