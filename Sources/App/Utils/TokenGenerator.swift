#if os(OSX) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
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
        #if os(OSX) || os(iOS)
        return arc4random_uniform(upperBound)
        #elseif os(Linux)
        return _swift_stdlib_arc4random_uniform(upperBound)
        #endif
    }
}
