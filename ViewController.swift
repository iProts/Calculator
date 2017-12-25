//
//  ViewController.swift
//  Calc 2
//
//  Created by Игорь Процько on 06.10.17.
//  Copyright © 2017 Ihor Protsko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigir(_ sender: UIButton) {
        let digit = sender.currentTitle
        
        if userIsInTheMiddleOfTyping {
        let textCurrentlyInDisplay = display.text
            if (digit != ".") || (textCurrentlyInDisplay?.range(of: ".") == nil) {
            display.text = textCurrentlyInDisplay! + digit!
            }
        } else {
            display.text = digit
        }
       userIsInTheMiddleOfTyping = true
    }
    
   private var displayValue: Double {
        get {
            return Double (display.text!)!
        }
        set {
            display.text = String (newValue)
        }
    }
    private var brain = CalculatorBrain()
    
    var saveProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        saveProgram = brain.program
    }
    
    @IBAction func restore() {
        if saveProgram != nil {
            brain.program = saveProgram!
            displayValue = brain.result
        }
    }
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
     
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
}

