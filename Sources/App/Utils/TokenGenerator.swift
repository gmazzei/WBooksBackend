#if os(Linux)
import Glibc
import SwiftShims
#else
import Darwin
#endif

class TokenGenerator {
    
    private static let allowedChars = "$!abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    class func createRandomToken(withLength length: Int) -> String {
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNumber = Int(cs_arc4random_uniform(upperBound: allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNumber)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    }
    
    private class func cs_arc4random_uniform(upperBound: UInt32) -> UInt32 {
        #if os(Linux)
        return _swift_stdlib_arc4random_uniform(upperBound)
        #else
        return arc4random_uniform(upperBound)
        #endif
    }
}
