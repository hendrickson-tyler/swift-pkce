# Swift PKCE

Swift PKCE is a lightweight collection of commonly used, client-side code generations in an [OAuth 2.0 Authorization Code flow + PKCE](https://oauth.net/2/pkce/) implemented in Swift. Each function conforms to the [RFC 7636](https://datatracker.ietf.org/doc/html/rfc7636) protocol.

## Availability

Due to the dependency on [Apple CryptoKit](https://developer.apple.com/documentation/cryptokit), Swift PKCE is available to the following platforms:

iOS 13.0+\
iPadOS 13.0+\
macOS 10.15+\
Mac Catalyst 15.0+\
tvOS 15.0+\
watchOS 8.0+

## Usage

Import the Swift PKCE framework by adding it to the imports at the top of the file:

```swift
import PKCE
```

### Functions

**generateCodeVerifier**\
Generates a new, random code verifier with a specified length of characters.

```swift
func generateCodeVerifier(length: Int = 128) throws -> String {
```

**generateCodeChallenge**\
Generates a code challenge for a given code verifier.

```swift
func generateCodeChallenge(for: String) throws -> String
```

## Attribution

The original code for Swift PKCE was sourced from a [Bootstragram blog post](https://bootstragram.com/blog/oauth-pkce-swift-secure-code-verifiers-and-code-challenges/) written by [@dirtyhenry](https://github.com/dirtyhenry) and updated slightly.
