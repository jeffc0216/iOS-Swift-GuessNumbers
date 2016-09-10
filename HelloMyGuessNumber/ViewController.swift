//
//  ViewController.swift
//  HelloMyGuessNumber
//
//  Created by Jeff Chen on 2016/9/10.
//  Copyright © 2016年 Jeff Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessTextField: UITextField!
    @IBOutlet weak var inputATextField: UITextField!
    @IBOutlet weak var inputBTextField: UITextField!
    @IBOutlet weak var logTextView: UITextView!
    
    var host = GuessNumberHost()
    var ai = GuessNumberAI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTextView.text = "Welcome,please guess it first.\n"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userGuessSubmitBtnPressed(sender: AnyObject) {
        
        guard let userGuessString = userGuessTextField.text else {
            return
        }
        
        guard host.isValidNumber(userGuessString) else {
            logTextView.text! += "Invalid input: \(userGuessString)\n"
            return
        }
        
        // Handle user guess
        guard let resultAB = host.userGuess(userGuessString) else {
            logTextView.text! += "Fail to handle input: \(userGuessString)\n"
            return
        }
        logTextView.text! += "User Guess [\(host.userGuessCounter)]: \(userGuessString) ==> \(resultAB.A)A,\(resultAB.B)B\n"
        
        if resultAB.A == host.MAX_NUMBERS {
            logTextView.text! += "User WIN the game! \n"
            return
        }
        //It's AI's turn to guess
        guard let aiGuessString = ai.getAIGuess() else {
            logTextView.text! += "AI don't know how to guess.\n"
            return
        }
        logTextView.text! += "AI Guess [\(ai.aiGuessCounter)]: \(aiGuessString)\n"
    }

    @IBAction func replyABBtnPressed(sender: AnyObject) {
        
        guard let replyA = inputATextField.text else {
            logTextView.text! += "Field A should not be empty.\n"
            return
        }
        guard let replyB = inputBTextField.text else {
            logTextView.text! += "Field B should not be empty.\n"
            return
        }
        guard let numberA = Int(replyA) else {
            logTextView.text! += "Field A is not valid.\n"
            return
        }
        guard let numberB = Int(replyB) else {
            logTextView.text! += "Field B is not valid.\n"
            return
        }
        
        // Handle user's reply of AB
        guard let result = ai.handleUserReply(numberA, replyB: numberB) else {
            logTextView.text! += "AI don't know how to handle the AB.\n"
            return
        }
        
        if result {
            logTextView.text! += "AI WIN the game.\n"
            return
        } else {
            logTextView.text! += "==> \(numberA)A,\(numberB)B.\nYour turn to guess.\n"
            return
        }
        
    }
    
    @IBAction func restartGameBtnPressed(sender: AnyObject) {
        
        logTextView.text = "Game restarted, please guess it first.\n"
        host = GuessNumberHost()
        ai = GuessNumberAI()
        
        //clear up the fields
        userGuessTextField.text = ""
        inputATextField.text = ""
        inputBTextField.text = ""
    }
    
}












