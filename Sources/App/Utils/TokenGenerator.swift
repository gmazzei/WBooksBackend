#if os(Linux)
import SwiftShims
import Glibc
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
        return Int(_swift_stdlib_cxx11_mt19937_uniform(upperBound))
        #else
        return cs_arc4random_uniform(upperBound: upperBound)
        #endif
    }
}
