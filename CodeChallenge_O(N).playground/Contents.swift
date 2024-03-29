//  Created by Matt Lintlop on 7/1/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.

import Cocoa

let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]

class StringLetterRotatorTimeOn {
    
    var stringsLetterRotationCountsDict:[String:[Int8]]?
    
    // Find all of the common rotated strings in a list of input strings .
    // Returns an array of an array of common strings.
    func findAllCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        var resultStrings:[[String]]? = []
        var remainingStrings:[String]? = inputStrings
        
        // initialize the strings letter rotation value dictionary
        // key = string
        // value = array of integer of letter rotation values for each consecitive letter in the string
        self.stringsLetterRotationCountsDict = [:]
        
        // keep looping while the are at least the minuimum # of strings remaining
        var commonRotatedStrings:[String]?
        while (remainingStrings!.count >= 2) {
            
            // get the first remaining string
            let firstString = remainingStrings!.first!
            
            // initialize the common strings = 1st string
            commonRotatedStrings = [firstString]
            
            // loop thru all strings after the 1st input string
            for index in 1..<remainingStrings!.count {
                let inputString = remainingStrings![index]
                
                // if the 1st string can be rotated tp the current input string,
                // add current input string to the list of common strings
                if canRotateString(firstString, toString:inputString) {
                    commonRotatedStrings!.append(inputString)
                }
            }
            if (commonRotatedStrings!.count >= 2) {
                // add the current common rotated strings to the results
                resultStrings!.append(commonRotatedStrings!)
             }

            // remove the common strings from the remaining strings
            if (commonRotatedStrings!.count >= 1) {
                for commonRotatedString in commonRotatedStrings! {
                    if let index = remainingStrings?.firstIndex(of: commonRotatedString) {
                        remainingStrings?.remove(at: index)
                    }
                }
            }
            commonRotatedStrings = nil
        }
  
        // return the array of strings result with all common rotated strings
        return resultStrings
    }
    
    // Determine if string #1 can be rotated to string #2 by a constant rotation value
    // ex: (+) rotation value 1 = 'a'->'b'
    // ex: (-) rotation value -1 = 'b' ->'a'
    func canRotateString(_ string1:String, toString string2:String) -> Bool {
        guard let string1LetterRotationCounts = letterRotationCountsWithString(string1) else {
            return false
        }
        guard let string2LetterRotationCounts = letterRotationCountsWithString(string2) else {
            return false
        }
        return areStringLetterRotations(string1LetterRotationCounts, equalTo: string2LetterRotationCounts)
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
        if let stringLetterRotationCounts = stringsLetterRotationCountsDict?[inputString] {
            return stringLetterRotationCounts
        }
        guard inputString.count > 0 else {
            return nil
        }

        if stringsLetterRotationCountsDict == nil {
            stringsLetterRotationCountsDict = [:]
        }
        let inputStringUTF8 = inputString.utf8CString
        var stringLetterRotationCounts:[Int8] = []
        var previousLetter:CChar?
        for index in 0..<inputString.count {
            if index == 0 {
                previousLetter = inputStringUTF8[0]
            }
            else {
                let currentLetter = inputStringUTF8[index]
                if let previousLetter = previousLetter {
                    let letterRotationCount = getLetterRotationCount(fromLetter:previousLetter, toLetter:currentLetter)
                    stringLetterRotationCounts.append(Int8(letterRotationCount))
                }
                previousLetter = currentLetter
            }
        }
        stringsLetterRotationCountsDict![inputString] = stringLetterRotationCounts
        return stringLetterRotationCounts
    }
    
    func areStringLetterRotations(_ stringLetterRotationCounts1:[Int8], equalTo stringLetterRotationCounts2:[Int8]) -> Bool {
        guard stringLetterRotationCounts1.count == stringLetterRotationCounts2.count else {
            return false
        }
        for index in 0..<stringLetterRotationCounts1.count {
            if stringLetterRotationCounts1[index] != stringLetterRotationCounts2[index] {
                return false
            }
        }
        return true
    }
 }

class StringRotatorTimeOn2 {
    
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
    

    // Find all of the common rotated strings in a list of input strings .
    // Returns an array of an array of common strings.
    func findCommonRotatedStrings(withStrings inputStrings:[String]) -> [[String]]? {
        var resultStrings:[[String]]?
        
        var remainingStrings:[String]? = inputStrings
        
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
}

//
// O(n2) Algorithm Timing Test:
// Do a timing test of this algorithm (with O(n) time performance)
//
let kAlgorithmTestIterationCount = 10
let stringLetterRotator = StringLetterRotatorTimeOn()
var testStartTime:Date = Date()
let inputStrings = ["abbc","cdde","zaab","cat","thfg","ed","bzs"]
var algorithmStartTime = Date()
var resultStrings:[[String]]?
for _ in 1...kAlgorithmTestIterationCount {
    resultStrings = stringLetterRotator.findAllCommonRotatedStrings(withStrings:inputStrings)
}
var algorithmEndTime = Date()
var algorithmElapsed:TimeInterval = algorithmEndTime.timeIntervalSince(algorithmStartTime)
var algorithmAverage:TimeInterval = algorithmElapsed/TimeInterval(kAlgorithmTestIterationCount)

print("String Letter Rotator Algorithm with O(n) performance: \(kAlgorithmTestIterationCount) iterations, average \(algorithmAverage) secs")
if let resultStrings = resultStrings {
    print("Result: \(String(describing: resultStrings))")
}
else {
    print("Result is nil")
}

//
// O(n2) Algorithm Timing Test:
// Do a timing test of this algorithm (with O(n2) performance)
//
let stringRotatorTimeOn2 = StringRotatorTimeOn2()
testStartTime = Date()
algorithmStartTime = Date()
for _ in 1...kAlgorithmTestIterationCount {
    resultStrings = stringRotatorTimeOn2.findAllCommonRotatedStrings(withStrings:inputStrings)
}
algorithmEndTime = Date()
algorithmElapsed = algorithmEndTime.timeIntervalSince(algorithmStartTime)
algorithmAverage = algorithmElapsed/TimeInterval(kAlgorithmTestIterationCount)
print("Algorithm O(n) performance: \(kAlgorithmTestIterationCount) iterations, average \(algorithmAverage) secs")

