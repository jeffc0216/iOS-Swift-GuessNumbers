//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class GuessNumberbase {
    let MAX_NUMBERS = 4
    func isValidNumber(input:String) -> Bool {
        
        // check length
        let inputLength = input.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        guard inputLength == MAX_NUMBERS else {
            return false
        }
        
        // check if it is a number
        guard Int(input) != nil else {
            return false
        }
        
        // check if there is any duplicate number
        let inputSet = Set(input.characters)
        guard inputSet.count == MAX_NUMBERS else {
            return false
        }
        return true
    }
    
    func checkAB(testInput:String,answerInput:String) -> (A:Int,B:Int)? {
        
        // check if inputs are valid
        guard isValidNumber(testInput) && isValidNumber(answerInput) else {
            return nil
        }
        
        // check A and B
        let testArray = Array(testInput.characters)
        let answerArray = Array(answerInput.characters)
        
        var resultA = 0
        var resultB = 0
        
        for i in 0..<MAX_NUMBERS {
            for j in 0..<MAX_NUMBERS {
                
                if testArray[i] == answerArray[j] {
                    
                    if i == j {
                        resultA += 1
                    }else{
                        resultB += 1
                    }
                }
            }
        }
        return (A:resultA,B:resultB)
        
    }
}

let base = GuessNumberbase()
base.isValidNumber("123")
base.isValidNumber("123a")
base.isValidNumber("1234")
base.isValidNumber("1233")

base.checkAB("1234", answerInput: "5678")
base.checkAB("1234", answerInput: "4321")
base.checkAB("1234", answerInput: "2134")

class GuessNumberHost:GuessNumberbase {
    
    private var appNumberString = ""
    var userGuessCounter = 0
    
    override init() {
        super.init()
        generateAppNumberString()
    }
    
    private func generateAppNumberString() {
        
        var availables = ["0","1","2","3","4","5","6","7","8","9"]
        for _ in 1...MAX_NUMBERS {
            
            let tmpIndex = Int(arc4random() % UInt32(availables.count))
            let tmpNumber = availables[tmpIndex]
            appNumberString += tmpNumber
            availables.removeAtIndex(tmpIndex)
        }
        print("appNumberString: \(appNumberString)")
    }
    
}

let host1 = GuessNumberHost()
host1.appNumberString






