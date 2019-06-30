import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    init() {
   }
    func findCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
        print("findCommonRotatedStrings: inputStrings  \(inputStrings)")
        guard inputStrings.count >= 2 else {
            return inputStrings
        }
        let firstString = inputStrings.first!
        var commonStrings:[String] = [firstString]

        for index in 1..<inputStrings.count {
            let inputString = inputStrings[index]
            if doesString(firstString, rotateTo:inputString) {
                commonStrings.append(inputString)
            }
        }
        return commonStrings
    }
    
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        print("findAllCommonRotatedStrings")
        var resultStrings:[[String]]?
        var remainingStrings:[String]? = inputStrings
        var commonRotatedStrings: [String]?
        while (remainingStrings != nil) && remainingStrings!.count >= 1 {
            if let commonRotatedStrings = findCommonRotatedStrings(withStrings: remainingStrings!) {
                print("Result commonRotatedStrings = \(commonRotatedStrings)")
                resultStrings?.append(commonRotatedStrings)
                for commonRotatedString in commonRotatedStrings {
                    if let index = remainingStrings?.firstIndex(of: commonRotatedString) {
                        remainingStrings?.remove(at: index)
                    }
                }
            }
        }
   
        if resultStrings != nil {
            print("Result has \(resultStrings!.count) strings : \(resultStrings!)")
        }
        else {
            print("Result is nil")
        }

        return resultStrings
    }

    func getCharacter(_ char:Character, rotatedBy count:Int8) -> Character? {
        guard let charAlpahetIndex = characterAlphabetIndex(char) else {
            return nil
        }
        var rotateCount = count
        while rotateCount < 0 {
            rotateCount += 26
        }
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
            var charRotateCount:Int8 = rotateStringChar - inputStringChar
            while charRotateCount < 0 {
                charRotateCount += 26
            }
            while charRotateCount > 25 {
                charRotateCount -= 26
            }
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

if let resultStrings = stringRotator.findAllCommonRotatedStrings(withStrings:inputStrings) {
    print("Result has \(resultStrings.count) strings : \(resultStrings)")
}
else {
    print("Result is nil")
}

