//  Created by Matt Lintlop on 7/1/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.

import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    var stringsLetterRotationCountsDict:[String:[Int8]]?
    
    // Find the first common rotated strings in a list of input strings .
    // Returns an array of common strings.
    func findFirstCommonRotatedStrings(withStrings inputStrings:[String]) -> [String]? {
        guard inputStrings.count >= 2 else {
            // there are < 2 input strings so just return the input strings
            return inputStrings
        }
        
        // get the first input string
        let firstString = inputStrings.first!
        
        // initialize the common strings = 1st string
        var commonStrings:[String] = [firstString]
        
        // loop thru all strings after the 1st input string
        for index in 1..<inputStrings.count {
            let inputString = inputStrings[index]
            
            // if the 1st string can be rotated tp the current input string,
            // add current input string to the list of common strings
            if canRotateString(firstString, toString:inputString) {
                commonStrings.append(inputString)
            }
        }
        
        // return the list of common strings result
        return commonStrings
    }
    
    // Find all of the common rotated strings in a list of input strings .
    // Returns an array of an array of common strings.
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        var resultStrings:[[String]]?
        var remainingStrings:[String]? = inputStrings
        
        // initialize the strings letter rotation value dictionary
        // key = string
        // value = array of integer of letter rotation values for each consecitive letter in the string
        self.stringsLetterRotationCountsDict = [:]
        
        // keep looping while the are at least the minuimum # of strings remaining
        let kMinCommonStringsCount = 2
        while (remainingStrings!.count >= kMinCommonStringsCount) {
            
            // find the first list of common strings from the remaining strings
            if let commonRotatedStrings = findFirstCommonRotatedStrings(withStrings: remainingStrings!) {
                if commonRotatedStrings.count >= kMinCommonStringsCount {
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
            
            // string1 & string2 are diffent length, so return false
            return false
        }
        var firstCharRotateCount:Int8?
        
        // loop thru all letters in the strings and compare each of
        // the letter rotation values
        for index in 0..<string1.count {
            
            // get the rotation value (or # of characters a letter is rotated)
            // for the current character with string1 & string2
            // in the range 0 to 25
            var charRotateCount:Int8 = string2.utf8CString[index] - string1.utf8CString[index]
            while charRotateCount < 0 {
                charRotateCount += 26
            }
            while charRotateCount > 25 {
                charRotateCount -= 26
            }
            if index == 0 {
                // initialize the rotate count of the 1st letter of string1 & string2
                firstCharRotateCount = charRotateCount
            }
            else {
                // current letter rotation value is not the same as the 1st letter rotation value
                // so string1 can not be rotated to string2
                if charRotateCount != firstCharRotateCount {
                    return false
                }
            }
        }
        // all letters in string1 & string2 have the same rotation value
        // so string1 can be rotated to string2
        return true
    }
    
    func getLetterRotationCount(fromLetter letter1:CChar, toLetter letter2:CChar) -> Int8 {
        // get the rotation count (or # of characters a letter is rotated)
        // from letter1 -> letter2  in the range 0 to 25
        // (ex: 'a' -> 'b' = 1)
        var charRotateCount:Int8 = Int8(letter2 - letter1)
        while charRotateCount < 0 {
            charRotateCount += 26
        }
        while charRotateCount > 25 {
            charRotateCount -= 26
        }
        return charRotateCount
    }
    
    func letterRotationCountsWithString(_ inputString:String) -> [Int8]? {
        guard inputString.count > 0 else { return nil }

        if stringsLetterRotationCountsDict == nil {
            stringsLetterRotationCountsDict = [:]
        }
        if let stringLetterRotationCounts = stringsLetterRotationCountsDict?[inputString] {
            return stringLetterRotationCounts
        }
        else {
            let inputStringUTF8 = inputString.utf8CString
            var stringLetterRotationCounts:[Int8] = []
            var previousLetter:CChar?
            for index in 0..<inputString.count {
                if index == 0 {
                    previousLetter = inputStringUTF8[0]
                    stringLetterRotationCounts.append(Int8(0))
                }
                else {
                    let currentLetter = inputStringUTF8[index]
                    if let previousLetter = previousLetter {
                        let letterRotationCount = getLetterRotationCount(fromLetter:previousLetter, toLetter:currentLetter)
                        stringLetterRotationCounts.append(Int8(letterRotationCount))
                    }
                }
            }
            print("inputString = \(inputString) letterRotationCounts = \(stringLetterRotationCounts)")
            return stringLetterRotationCounts
        }
    }
 }

// Do a timing test of this algorithm (with O(N) performance)
let kAlgorithmTestIterationCount = 1
let kPrintResult = true
let stringRotator = StringRotator()
let testStartTime:Date = Date()
let inputStrings = ["abbc","cdde","zaab","cat","thfg","ed","bzs"]
let algorithmStartTime = Date()
if kPrintResult {
    print("Input: \(inputStrings)")
}
for index in 1...kAlgorithmTestIterationCount {
    if let result = stringRotator.findAllCommonRotatedStrings(withStrings:inputStrings) {
        if kPrintResult && (index == 1) {
            print("Result: \(String(describing: result))")
        }
    }
    else {
        if kPrintResult && (index == 1) {
            print("result is nil")
        }
    }
}
let algorithmEndTime = Date()
let algorithmElapsed:TimeInterval = algorithmEndTime.timeIntervalSince(algorithmStartTime)
let algorithmAverage:TimeInterval = algorithmElapsed/TimeInterval(kAlgorithmTestIterationCount)
print("Algorithm O(N) performance: \(kAlgorithmTestIterationCount) iterations, average \(algorithmAverage) secs")

