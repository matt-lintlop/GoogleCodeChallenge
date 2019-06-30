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
    func findCommonRotatedStrings(withStrings strings:[String]) -> [[String]]? {
        self.inputStringLeft = strings
        self.resultStrings = nil

        for string in strings {
            
        }
        return self.resultStrings
    }
    
    func getCharacter(_ char:Character, rotatedBy rotateCount:Int) -> Character {
        var charAlpahetIndex = characterAlphabetIndex(char)
        return char
    }
    
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
        let firstCharRotateCount = 1
        for inputChar in inputString {
            if inputChar != getCharacter(inputChar, rotatedBy: firstCharRotateCount) {
                return false
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

