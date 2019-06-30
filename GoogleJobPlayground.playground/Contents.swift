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
}

let stringRotator = StringRotator()
if let resultStrings = stringRotator.findCommonRotatedStrings(withInput:["abbc","cdde","zaab","cat","thfg","ed","bzs"]) {
    print("Result has \(resultStrings.count) strings : \(resultStrings)")
}
else {
    print("Result is nil")
}

