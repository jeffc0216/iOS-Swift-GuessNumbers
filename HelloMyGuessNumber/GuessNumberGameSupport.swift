//
//  GuessNumberGameSupport.swift
//  HelloMyGuessNumber
//
//  Created by Jeff Chen on 2016/9/10.
//  Copyright © 2016年 Jeff Chen. All rights reserved.
//

import Foundation

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

class GuessNumberHost:GuessNumberbase {
    
    private var appNumberString = ""
    private(set) var userGuessCounter = 0 // read only
    
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
    
    func userGuess(userInput:String) -> (A:Int,B:Int)? {
        
        let resultAB = checkAB(userInput, answerInput: appNumberString)
        guard resultAB != nil else {
            return nil
        }
        userGuessCounter += 1
        return resultAB
    }

}

class GuessNumberAI:GuessNumberbase {
    
    //暴力消去法
    private var allPossibilities = [String]()
    private(set) var lastAIGuessString:String?
    private(set) var aiGuessCounter = 0
    
    override init() {
        super.init()
        generateAllPossibilities()
    }
    
    private func generateAllPossibilities() {
        // 0123...9876
        for i in 0123...9876 {
            let tmp = String(format: "%04d", i)
            if isValidNumber(tmp) {
                allPossibilities.append(tmp)
            }
        }
        print("Total \(allPossibilities.count) possible numbers.")
    }
    
    // MARK: - Public Methods
    func getAIGuess() -> String? {
        guard allPossibilities.count > 0 else {
            return nil
        }
        let targetIndex = Int(arc4random() % UInt32(allPossibilities.count))
        lastAIGuessString = allPossibilities[targetIndex]
        aiGuessCounter += 1
        return lastAIGuessString
    }
    
    func handleUserReply(replyA:Int,replyB:Int) -> Bool? {
        
        guard allPossibilities.count > 0 && lastAIGuessString != nil else {
            return nil
        }
        
        // check if AI win the game
        if replyA == MAX_NUMBERS {
            return true
        }
        
        // filter and keep possible numbers
        var newPossibilities = [String]()
        
        for tmp in allPossibilities {
            guard let tmpAB = checkAB(tmp, answerInput: lastAIGuessString!) else {
                return nil
            }
            
            if tmpAB.A == replyA && tmpAB.B == replyB {
                newPossibilities.append(tmp)
            }
        }
        allPossibilities = newPossibilities
        print("Total \(allPossibilities.count) possibile numbers.")
        
        return false
        
    }
}












