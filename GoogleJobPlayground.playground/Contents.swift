import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    init() {
   }
    func findCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
        guard inputStrings.count >= 2 else {
            return inputStrings
        }
        let firstString = inputStrings.first!
        var commonStrings:[String] = [firstString]

        for index in 1..<inputStrings.count {
            let inputString = inputStrings[index]
            if canRotateString(firstString, toString:inputString) {
                commonStrings.append(inputString)
            }
        }
        return commonStrings
    }
    
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        var resultStrings:[[String]]?
        var remainingStrings:[String]? = inputStrings
        var commonRotatedStrings: [String]?
        while (remainingStrings != nil) && remainingStrings!.count >= 1 {
            if let commonRotatedStrings = findCommonRotatedStrings(withStrings: remainingStrings!) {
                if commonRotatedStrings.count >= 2 {
                    if resultStrings == nil {
                        resultStrings = []
                    }
                    resultStrings?.append(commonRotatedStrings)
                }
                for commonRotatedString in commonRotatedStrings {
                    if let index = remainingStrings?.firstIndex(of: commonRotatedString) {
                        remainingStrings?.remove(at: index)
                    }
                }
            }
        }
        return resultStrings
    }
    
    func canRotateString(_ string1:String, toString string2:String) -> Bool {
        guard string1.count == string2.count else {
            return false
        }
        let stringLength = string1.count
        var firstCharRotateCount:Int8?
        for index in 0..<stringLength {
            let inputStringChar:Int8 = string1.utf8CString[index]
            let rotateStringChar:Int8 = string2.utf8CString[index]
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

