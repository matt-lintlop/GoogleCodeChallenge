//  Created by Matt Lintlop on 7/1/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.

import Cocoa

var str = "Hello, Google Job for Matt"
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringRotator {
    
    // Find the first common rotated strings in a list of input strings .
    // Returns an array of common strings.
    func findCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        guard inputStrings.count >= 2 else {
            // there are < 2 input strings so just return the input strings
            return [inputStrings]
        }
        
        let reversedInputStrings = inputStrings.reversed()
        var resultStrings:[[String]] = [[]]

        for inputString1 in inputStrings {
            
            var commonStrings:[String] = []
            
            for inputString2 in reversedInputStrings {
                if inputString1 != inputString2 {
                    // if the 1st string can be rotated tp the current input string,
                    // add current input string to the list of common strings
                    if canRotateString(inputString1, toString:inputString2) {
                        print("Match: \(inputString1) & \(inputString2)")
                        if (commonStrings.contains(inputString1) == false) {
                            commonStrings.append(inputString1)
                        }
                        if (commonStrings.contains(inputString2) == false) {
                            commonStrings.append(inputString2)
                        }
                    }
                }
             }
            if (commonStrings.count > 2) {
                resultStrings.append(commonStrings)
            }
        }
        
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
}

// Do a timing test of this algorithm (with O(N) performance)
let kAlgorithmTestIterationCount = 1
let stringRotator = StringRotator()
let testStartTime:Date = Date()
let inputStrings = ["abbc","cdde","zaab","cat","thfg","ed","bzs"]
let algorithmStartTime = Date()
for _ in 1...kAlgorithmTestIterationCount {
    let resultStrings = stringRotator.findCommonRotatedStrings(withStrings:inputStrings)
    print("Result: \(resultStrings)")
}
let algorithmEndTime = Date()
let algorithmElapsed:TimeInterval = algorithmEndTime.timeIntervalSince(algorithmStartTime)
let algorithmAverage:TimeInterval = algorithmElapsed/TimeInterval(kAlgorithmTestIterationCount)
print("Algorithm O(N) performance: \(kAlgorithmTestIterationCount) iterations, average \(algorithmAverage) secs")

