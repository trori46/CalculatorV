//
//  ViewController.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/10/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InputInterfaceDelegate {
    
    
    var outputController : OutputInterface? = nil
    var calcBrain = CalcModel()
    
    func utilityPressed(_ utility: Utility) {
        
        switch utility {
        case .equal:
            if calcBrain.input.isEmpty{
                outputController?.display("0")
            } else {
            if calcBrain.isLeftBracket == false && calcBrain.countBracket == 0 {
                calcBrain.isEq = true
                calcBrain.utility(utility)
                
            } else {
                outputController?.display("")
                
                }}
        case .leftBracket:
            if calcBrain.isOp == true {
                calcBrain.countBracket += 1
                calcBrain.isLeftBracket = true
                calcBrain.isLeftBracketValue = true
                calcBrain.isOp = false
                calcBrain.utility(utility)
                outputController?.display(utility.rawValue)
                calcBrain.isEq = false
                print("isLeftBracket = true")
            } else if calcBrain.input.isEmpty {
                calcBrain.countBracket += 1
                calcBrain.isLeftBracket = true
                calcBrain.isLeftBracketValue = true
                calcBrain.isOp = false
                calcBrain.utility(utility)
                outputController?.display(utility.rawValue)
                calcBrain.isEq = false
            } else if calcBrain.isLeftBracket == true {
                calcBrain.countBracket += 1
                calcBrain.isLeftBracket = true
                calcBrain.isLeftBracketValue = true
                calcBrain.isOp = false
                calcBrain.utility(utility)
                outputController?.display(utility.rawValue)
                calcBrain.isEq = false
            } else {
                outputController?.display("")
            }
            
        case .rightBracket:
            
            if calcBrain.countBracket > 0 && calcBrain.isLeftBracket == false {
                calcBrain.countBracket -= 1
                calcBrain.utility(utility)
                outputController?.display(utility.rawValue)
                calcBrain.isLeftBracket = false
                calcBrain.isOp = false
            } else {
                outputController?.display("")
            }
        case .dot:
            let lastValue = outputController?.currentOutput()
            if calcBrain.isDot == false && !checkIsOperation((lastValue?.last!)!){
                if lastValue! != "0"{
                calcBrain.isEq = false
                calcBrain.utility(utility)
                outputController?.display(utility.rawValue)
                } else{
                    calcBrain.isEq = false
                    calcBrain.digit(0)
                    calcBrain.utility(utility)
                    outputController?.display("0.")
                }
                
            }
            else {
                outputController?.display("")
            }
            
        }
    }
    
    func operationPressed(_ operation: Operation) {
        calcBrain.isDot = false
        if calcBrain.isOp == true {
            var label = outputController?.currentOutput()
            label?.removeLast()
            outputController?.cleanLabel()
            outputController?.display(label!)
            calcBrain.operation(operation)
            outputController?.display(operation.rawValue)
            calcBrain.isEq = false
            
        } else {
            calcBrain.operation(operation)
            outputController?.display(operation.rawValue)
            calcBrain.isEq = false
            calcBrain.isOp = true
        }
        calcBrain.isLeftBracketValue = false
    }
    func constansPressed(_ const: Constants) {
        calcBrain.isDot = true
        calcBrain.isLeftBracket = false
        if calcBrain.isLeftBracket == false && calcBrain.isOp == false{
            outputController?.cleanLabel()
            calcBrain.input = ""
            outputController?.display(calcBrain.const(const))
            
            calcBrain.isEq = true
            calcBrain.isDot = true
        } else {
            outputController?.display(calcBrain.const(const))
            
            calcBrain.isEq = true
            calcBrain.isDot = true
 
        }
    }
    func functionPressed(_ function: Function) {
        calcBrain.isLeftBracket = false
        calcBrain.isDot = false
        calcBrain.function(function)
        if function.rawValue == "%" {
            calcBrain.isEq = false
            outputController?.display("%")
        }
    }
    
    func factorial(_ symbol: String) {
        calcBrain.isDot = false
        let outPut = outputController?.currentOutput()
        if let val = (Double)(outPut!) {
            if  val != Double.infinity && val != -(Double.infinity) && !(val.isNaN) {
        let value = abs((Int)(val))
        let r  = val - (Double)(value)
        if r == 0 {
            if (Int)((outputController?.currentOutput())!)! <= 170 && (Int)((outputController?.currentOutput())!)! != 0 {
                let text = outputController?.currentOutput()
                let val = abs((Double)(text!)!)
                let operation = (String)(calcBrain.factorial(val))
                outputController?.cleanLabel()
                outputController?.display(operation)
                calcBrain.isEq = true
            } else {
                outputController?.cleanLabel()
                outputController?.display("Error")
                calcBrain.isEq = true
            }
                }}}
        outputController?.display("")
    }
    
    func clear(_ clean: Memory) {
        if (outputController?.currentOutput()?.hasSuffix("cos"))! || (outputController?.currentOutput()?.hasSuffix("sin"))! || (outputController?.currentOutput()?.hasSuffix("ctg"))!  || (outputController?.currentOutput()?.hasSuffix("tgh"))!{
            calcBrain.input.removeLast()
            outputController?.clearLast()
            calcBrain.input.removeLast()
            outputController?.clearLast()
            calcBrain.input.removeLast()
            outputController?.clearLast()
        } else if (outputController?.currentOutput()?.hasSuffix("tg"))! || (outputController?.currentOutput()?.hasSuffix("ln"))!{
            calcBrain.input.removeLast()
            outputController?.clearLast()
            calcBrain.input.removeLast()
            outputController?.clearLast()
        } else if (outputController?.currentOutput()?.hasSuffix("cosh"))! || (outputController?.currentOutput()?.hasSuffix("sinh"))!   {
                calcBrain.input.removeLast()
                outputController?.clearLast()
                calcBrain.input.removeLast()
                outputController?.clearLast()
                calcBrain.input.removeLast()
                outputController?.clearLast()
            calcBrain.input.removeLast()
            outputController?.clearLast()
        } else {
            if calcBrain.input.isEmpty{
                calcBrain.input = ""
                outputController?.display("0")
            } else {
             
                if calcBrain.input.last == "." {
                    calcBrain.isDot = false
                    calcBrain.input.removeLast()
                    outputController?.clearLast()
                } else {
                calcBrain.input.removeLast()
                
                outputController?.clearLast()
                }
            }
        }
        
    }
    
    func allClean(_ clean: Memory) {
        calcBrain.input = ""
        outputController?.cleanLabel()
        calcBrain.isEq = false
        calcBrain.isDot = false
        calcBrain.isOp = false
    }
    func display(_ symbol: String){
        outputController?.display(symbol)
        calcBrain.input += symbol
    }
    
    
    func ifDigitAre(_ symbol: String) {
        //calcBrain.isDot = false
        if calcBrain.isOp == false && calcBrain.isLeftBracket != true {
            if symbol == "sin" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = sin(val)
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    calcBrain.input = ""
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            } else if symbol == "cos" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = cos(val)
                    calcBrain.input = ""
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }}
            else if symbol == "coSh" {
                    let text = outputController?.currentOutput()
                    if let val = (Double)(text!){
                        let oper = cosh(val)
                        calcBrain.input = ""
                        let operation = (String)(oper)
                        calcBrain.digit(oper)
                        outputController?.cleanLabel()
                        outputController?.display(operation)
                        calcBrain.isEq = true
                        calcBrain.isOp = false
                    } else {
                        outputController?.display("")
                    }
            }else if symbol == "siNh" {
                    let text = outputController?.currentOutput()
                    if let val = (Double)(text!){
                        let oper = sinh(val)
                        calcBrain.input = ""
                        let operation = (String)(oper)
                        calcBrain.digit(oper)
                        outputController?.cleanLabel()
                        outputController?.display(operation)
                        calcBrain.isEq = true
                        calcBrain.isOp = false
                    } else {
                        outputController?.display("")
                    }
            } else if symbol == "tg" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = tan(val)
                    calcBrain.input = ""
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            } else if symbol == "tGh" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = tanh(val)
                    calcBrain.input = ""
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            }else if symbol == "ctg" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = 1/tan(val)
                    calcBrain.input = ""
                    calcBrain.digit(oper)
                    let operation = (String)(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            }else if symbol == "ln" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = log(val)
                    calcBrain.input = ""
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            } else if symbol == "√" {
                let text = outputController?.currentOutput()
                if let val = (Double)(text!){
                    let oper = (sqrt(abs(val)))
                    calcBrain.input = ""
                    let operation = (String)(oper)
                    calcBrain.digit(oper)
                    outputController?.cleanLabel()
                    outputController?.display(operation)
                    calcBrain.isEq = true
                    calcBrain.isOp = false
                } else {
                    outputController?.display("")
                }
            } else if symbol == "±" {
                let rawvalue = outputController?.currentOutput()
                calcBrain.input = ""
                if let value = Double(rawvalue!) {
                    let result = value * -1
                    calcBrain.digit(result)
                    outputController?.cleanLabel()
                    if result != Double.infinity && result != -(Double.infinity) && !result.isNaN {
                    ifDouble(result)
                    }
                } else {
                    outputController?.display("")
                }
                }
        }else {
            functionPressed(Function(rawValue: symbol)!)
            
            if symbol == "±" {
                outputController?.display("")
            } else {
                outputController?.display(symbol)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputController"{
            let destinationVC = segue.destination as! InputViewController
            destinationVC.delegate = self
        } else if segue.identifier == "OutputController" {
            outputController = segue.destination as? OutputInterface
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calcBrain.resultClosure = { (value, error)->() in
            if value != Double.infinity && value != -(Double.infinity) && !(value?.isNaN)! {
                if (value != nil) {
                    
                    self.calcBrain.input = self.calcBrain.ifDouble(value!)
                    self.outputController?.cleanLabel()
                    
                    self.ifDoubleResult(value!)
                }    } else {
                self.allClean(Memory(rawValue: "C")!)
            }
        
        }
    }
    func ifDoubleResult(_ val: Double){ //verifing Double or Int after eque
        let value = (Int)(val)
        let r  = val - (Double)(value)
        if r == 0 {
            calcBrain.isDot = false
            let operation = (String)(value)
            outputController?.display(operation)
            
        } else {
            calcBrain.isDot = true
            let operation = (String)(val)
            outputController?.display(operation)
        }
    }
    func ifDouble(_ val: Double){ //verifing Double or Int
        let value = (Int)(val)
        let r  = val - (Double)(value)
        if r == 0 {
            let operation = (String)(value)
            outputController?.display(operation)
            
        } else {
            let operation = (String)(val)
            outputController?.display(operation)
        }
    }
    func digitPressed(_ value: Double) {
        if calcBrain.isEq == true {
            print("work")
            outputController?.cleanLabel()
            calcBrain.input = ""
            calcBrain.digit(value)
            if  value != Double.infinity && value != -(Double.infinity) && !value.isNaN {
            ifDouble(value)
            }
            calcBrain.isEq = false
            calcBrain.isOp = false
        } else {
            print("not work")
            calcBrain.digit(value)
            calcBrain.isOp = false
            if  value != Double.infinity && value != -(Double.infinity) && !value.isNaN {
                ifDouble(value)
            }
        }
        calcBrain.isLeftBracket = false
        
    }
    func checkIsOperation(_ value: String.Element)-> Bool{
        switch value {
        case "+", "-", "*", "/":
            return true
        default:
            return false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


