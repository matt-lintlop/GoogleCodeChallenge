import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    // Find the first common rotated strings in a list of input strings .
    // Returns an array of common strings.
    func findFirstCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
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
        while (remainingStrings!.count >= 1) {
            // find all common strings in the remaining strings
            if let commonRotatedStrings = findFirstCommonRotatedStrings(withStrings: remainingStrings!) {
                if commonRotatedStrings.count >= 2 {
                    if resultStrings == nil {
                        resultStrings = []
                    }
                    resultStrings?.append(commonRotatedStrings)
                }
                // remove the common strings from the remaining strings
                for commonRotatedString in commonRotatedStrings {
                    if let index = remainingStrings?.firstIndex(of: commonRotatedString) {
                        remainingStrings?.remove(at: index)
                    }
                }
            }
        }
        return resultStrings
    }
    
    // Determine if string #1 can be rotated to strimg #2
    func canRotateString(_ string1:String, toString string2:String) -> Bool {
        guard string1.count == string2.count else {
            return false
        }
        var firstCharRotateCount:Int8?
        for index in 0..<string1.count {
            var charRotateCount:Int8 = string2.utf8CString[index] - string1.utf8CString[index]
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

