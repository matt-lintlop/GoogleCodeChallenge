import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    // Find the first common rotated strings in a list of input strings .
    // Returns an array of common strings.
    func findFirstCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
        guard inputStrings.count >= 2 else {
            // there are < 2 input strings so just return the input strings
            return inputStrings
        }
        
        // get the first input string
        let firstString = inputStrings.first!
        
        // initialize the common strings = first string
        var commonStrings:[String] = [firstString]

        // loop thru all strings after the first input string
        for index in 1..<inputStrings.count {
            let inputString = inputStrings[index]
            // if the first string can be rotated tp the current input string,
            // add current input string to the list of common strings
            if canRotateString(firstString, toString:inputString) {
                commonStrings.append(inputString)
            }
        }
        return commonStrings
    }
    
    // Find all of the common rotated strings in a list of input strings .
    // Returns an array of an array of common strings.
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        var resultStrings:[[String]]?
        var remainingStrings:[String]? = inputStrings
        
        // keep looping while the are at least 2 strings remaining
        while (remainingStrings!.count >= 1) {
            // find the first list of common strings from the remaining strings
            if let commonRotatedStrings = findFirstCommonRotatedStrings(withStrings: remainingStrings!) {
                if commonRotatedStrings.count >= 1 {
                    if resultStrings == nil {
                        // initialize the result strings
                        resultStrings = []
                    }
                    // add the common rotated strings to the result strings
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
        // return the array of strings result with all common rotated strings
        return resultStrings
    }
    
    // Determine if string #1 can be rotated to string #2 by a constant rotation value
    // ex: (+) rotation value 1 = 'a'->'b'
    // ex: (-) rotation value -1 = 'b' ->'a'
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
            if index == 0 {
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

