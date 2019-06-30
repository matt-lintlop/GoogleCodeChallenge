import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    var inputStringLeft: [String]?
    var resultStrings:[[String]]?

    init() {
        self.inputStringLeft = nil
        self.resultStrings = nil
   }
    func findCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
        guard inputStrings.count >= 2 else {
            return inputStrings
        }
        let firstString = inputStrings.first!
        self.inputStringLeft = inputStrings
        var commonStrings:[String] = [firstString]

        for index in 1..<firstString.count {
            let inputString = inputStrings[index]
            if doesString(firstString, rotateTo:inputString) {
                commonStrings.append(inputString)
            }
        }
        return commonStrings
    }
    
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        // TODO
        return nil
    }

    func getCharacter(_ char:Character, rotatedBy count:Int8) -> Character? {
        guard let charAlpahetIndex = characterAlphabetIndex(char) else {
            return nil
        }
        var rotateCount = count
        repeat {
            rotateCount += 26
        } while rotateCount < 0
        let rotatedCharAlpabetIndex = (charAlpahetIndex + UInt8(rotateCount)) % UInt8(26)
        let rotatedChar:Character = Character(UnicodeScalar(char.asciiValue! + rotatedCharAlpabetIndex))
        return rotatedChar
    }
    
    // Get a letter's index into the alphabet (0-25)
    func characterAlphabetIndex(_ char:Character) -> UInt8? {
        guard char.isASCII else {
            return nil
        }
        let charAscii = char.asciiValue!
        let upperCaseA:UInt8 = Character("A").asciiValue!
        let lowerCaseA:UInt8 = Character("a").asciiValue!
        if charAscii >= upperCaseA {
            return charAscii - upperCaseA
        }
        else {
            return charAscii - lowerCaseA
        }
    }
    
    func doesString(_ inputString:String, rotateTo rotateToString:String) -> Bool {
        guard inputString.count == rotateToString.count else {
            return false
        }
        let stringLength = inputString.count
        var firstCharRotateCount:Int8?
        for index in 0..<stringLength {
            let inputStringChar:Int8 = inputString.utf8CString[index]
            let rotateStringChar:Int8 = rotateToString.utf8CString[index]
            let charRotateCount:Int8 = rotateStringChar - inputStringChar
            if firstCharRotateCount == nil {
                 firstCharRotateCount = charRotateCount
            }
            else {
                if charRotateCount != firstCharRotateCount {
                    return false
                }
            }
        }
        return true
    }
}

let stringRotator = StringRotator()
let inputStrings = ["abbc","cdde","zaab","cat","thfg","ed","bzs"]

print("Input Strings: \(inputStrings)")

if let resultStrings = stringRotator.findCommonRotatedStrings(withStrings:inputStrings) {
    print("Result has \(resultStrings.count) strings : \(resultStrings)")
}
else {
    print("Result is nil")
}

