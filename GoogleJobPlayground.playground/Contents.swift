import Cocoa

var str = "Hello, Google Job for Matt"
var inputStrings:[String]?
let correctResultStrings = [["abbc","cdde","zaab"],["cat","bzs"]]
var resultStrings:[[String]]?

class StringRotator {
    
    var inputStringLeft: [String]?
    
    init() {
        self.inputStringLeft = nil
    }
    func findCommonRotatedStrings(withInput strings:[String]) -> [[String]]? {
        self.inputStringLeft = strings
        return nil
    }
    
    func getCharacter(_ char:Character, rotatedBy rotateCount:Int) -> Character {
        return char
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
if let resultStrings = stringRotator.findCommonRotatedStrings(withInput:["abbc","cdde","zaab","cat","thfg","ed","bzs"]) {
    print("Result has \(resultStrings.count) strings : \(resultStrings)")
}
else {
    print("Result is nil")
}

