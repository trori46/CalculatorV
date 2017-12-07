//
//  CalcModel.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/10/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//


import Foundation

enum Operation: String {
    case plus  = "+"
    case minus = "-"
    case mult  = "*"
    case div   = "/"
    case exp   = "^"
    
}

enum Memory: String {
    case allClean  = "C"
    case clear
}
enum Function: String {
    case sqrt    = "√"
    case sin     = "sin"
    case cos     = "cos"
    case tan     = "tg"
    case siNh     = "siNh"
    case coSh     = "coSh"
    case tGh     = "tGh"
    case ctan    = "ctg"
    case ln      = "ln"
    case sign    = "±"
    case pow     = "^"
    case percent = "%"
}


enum Utility: String {
    case dot          = "."
    case leftBracket  = "("
    case rightBracket = ")"
    case equal = "="
}

enum Constants: String {
    case pi = "π"
    case e  = "e"
}

protocol OutputInterface {
    func display(_ result: String)
    func currentOutput() -> String?
    func cleanLabel()
    func clearLast()
}

protocol CalculatorInterface {
    func digit(_ value: Double)
    func operation(_ operation: Operation)
    func function(_ function: Function)
    func utility(_ utility: Utility)
    func const(_ const: Constants) -> String
    var resultClosure: ((Double?, Error?) -> ())? { get set }
}

class CalcModel : CalculatorInterface {
    
    
    var resultClosure: ((Double?, Error?) -> ())?
    private var inputDataArray = [String]()
    private var outputData = [String]()
    var input = ""
    var isEq = false //if equal is pressed
    var isOp = false //if operation is pressed
    var isDot = false //if dot is pressed
    var isLeftBracket = false
    var isLeftBracketValue = false
    var countBracket = 0
    
    func digit(_ value: Double) {
        if value != Double.infinity && value != -(Double.infinity) && !value.isNaN {
            /*if isDot == false {
                input += (String)(value)
                print(input)
            } else {
                let val = (Int64)(value)
                input += (String)(val)
                print(input)
            }*/
            if  isValue(at: String(value)){
                if isInt(at: String(value)){
                let val = Int(value)
        let r  = value - (Double)(val)
        if r == 0 {
            input += (String)(val)
                    }
        } else {
                    isDot = true
            input += (String)(value)
                }} else {
                input += (String)(value)
            }
        print(input)
        isOp = false
        isEq = false
        } else {
            
        }
        
    }
    func const(_ const: Constants) -> String {
        if const ==  .pi {
            input += (String)(Double.pi)
            return (String)(Double.pi)
        }
        input += (String)(M_E)
        return (String)(M_E)
    }
    func operation(_ operation: Operation) {
        
        isEq = false
        if isOp == true {
            input.removeLast()
            if input == "" && operation == .minus {
                input += "0-"
            } else {
                input += operation.rawValue
            }} else
            if input == "" && operation == .minus {
                input += "0-"
            } else {
                input += operation.rawValue
        }
    }
    
    func function(_ function: Function) {
        input += function.rawValue
    }
    
    
    func utility(_ utility: Utility) {
        if utility == .equal {
            resultClosure?(CalculateRPN(),nil)
            inputDataArray = [String]()
            outputData = [String]()
            isEq = true
            isOp = false
            
        } else {
            input += utility.rawValue
        }
    }
    func ifDouble(_ val: Double) -> String {
        //verifing Double or Int
        
        let value = (Int)(val)
        let r  = val - (Double)(value)
        if r == 0 {
            let operation = (String)(value)
            return(operation)
            
        } else {
            let operation = (String)(val)
            return(operation)
            }
    }
    private func seperateInputData(){ //function seperate inputData into math components
        print(input)
        var l = true
        for ch in input{
            if ch == "-" && l == true{
                inputDataArray.append("0")
            } else {
                l = false
            }
        }
        
        
        for charachter in input{
            if isOperation(at: String(charachter)) {
                inputDataArray.append(String(charachter))
            } else if isValue(at: String(charachter)){ //determine if last charachter is number,
                if inputDataArray.count == 0 {         // if true add next charachter to thesame string
                    inputDataArray.append(String(charachter))
                } else if isValue(at: inputDataArray[inputDataArray.count - 1])  {
                    inputDataArray[inputDataArray.count - 1] += String(charachter)
        
                } else {
                    inputDataArray.append(String(charachter)) //
                }
            } else if charachter == "." {
                inputDataArray[inputDataArray.count - 1] += String(charachter)
            } else if inputDataArray.count != 0 && !isTrigonomenry(at: inputDataArray[inputDataArray.count - 1]) && !isOperation(at: inputDataArray[inputDataArray.count - 1]) {
                inputDataArray[inputDataArray.count - 1] += String(charachter) // if element of array is not fully written trigonometry func
            } else {
                inputDataArray.append(String(charachter))
            }
        }
        print(inputDataArray)
    }
    
    private func calculateData(){  //calculate reverse polish notation
        var stack = [String]() //stack for operators
        for symbol in inputDataArray{
            if !isOperation(at: symbol){ //if symbol is number
                outputData.append(String(symbol))
            } else if isOperationDM(at: String(symbol)){ //if symbol is math operation
                if stack.count == 0 || symbol == "(" { //if stack empty or symbol = (, add symbol
                    stack.append(String(symbol))
                } else if priorityBetweenOperators(first: stack.last!, second: symbol) &&  stack.last! != "(" {
                    //if last operator has higher or same precedence, pop element from stack to outputdata and push symbol
                    var i = 0
                    for element in stack.reversed() {
                        if priorityBetweenOperators(first: element, second: symbol) &&  element != "(" {
                            i+=1
                            outputData.append(String(element))
                        } else {
                            break
                        }
                    }
                    stack = Array(stack.dropLast(i))
                    stack.append(String(symbol))
                } else {
                    stack.append(String(symbol))
                }
            } else if symbol == ")" { //pop all elements until (
                var i = 0
                for element in stack.reversed() {
                    if element != "(" {
                        i += 1
                        outputData.append(String(element))
                    } else {
                        break
                    }
                }
                
                stack = Array(stack.dropLast(i+1))
            } else {
                stack.append(String(symbol))
            }
            print(outputData)
            print(stack)
            
        }
        for element in stack.reversed() {
            outputData.append(String(element))
        }
        print(outputData)
        
    }
    private func priorityFor(char:String) -> Int{ //determine priority
        if char == "+" || char == "-" {
            return 1
        } else if (char == "^") {
            return 3
        } else if isTrigonomenry(at: char) {
            return 4
        }
        return 2
    }
    
    private func priorityBetweenOperators(first:String, second:String) -> Bool { //priority between operators
        if priorityFor(char: first) >= priorityFor(char: second) {
            return true
        }
        return false
    }
    
    private func isInt(at char: String) -> Bool{// determine if number
       let val = Double(char)
        if val! <= Double(INT_MAX)
        {
            return true
        }
        return false
    }
    private func isValue(at char: String) -> Bool{// determine if number
        if let _ = Double(char) {
            return true
        }
        return false
    }
    
    private func isOperation(at char: String) -> Bool{ //determine if math symbol
        
        if isOperationDM(at: char) || char == "(" || char == ")" {
            return true
        }
        return false
    }
    
    private func isTrigonomenry(at char: String) -> Bool{ //determine if trigonometry func
        if char=="sin" || char=="cos" || char=="tg" || char=="ctg" || char=="±" || char == "%" || char=="siNh" || char=="coSh" || char=="tGh" {
            return true
        }
        return false
    }
    
    private func isOperationDM(at char: String) -> Bool{ //determine if math operator
        
        if char=="+" || char=="/" || char=="*" || char=="-" || char == "^" || char == "sin" || char == "cos" || char == "tg" || char == "ctg" || char == "√" || char == "ln" || char == "±" || char == "%" || char == "siNh" || char == "coSh" || char == "tGh"{
            return true
        }
        return false
    }
    func CalculateRPN() -> Double { //calculate RPN and return result of expression
        self.seperateInputData()
        self.calculateData()
        var stack =  [Double]()
        for value in outputData {
           
           
                switch value {
                case "+":
                    let rightValue = stack.removeLast()
                    if stack.last != nil {
                        let leftValue = stack.removeLast()
                        stack.append(leftValue + rightValue)
                    } else {
                        stack.append(rightValue)
                    }
                case "-":
                    let rightValue = stack.removeLast()
                    if stack.last != nil {
                        let leftValue = stack.removeLast()
                        stack.append(leftValue - rightValue)
                    } else {
                        stack.append(rightValue)
                    }
                case "*":
                    let rightValue = stack.removeLast()
                    if stack.last != nil {
                        let leftValue = stack.removeLast()
                        stack.append(leftValue * rightValue)
                    } else {
                        stack.append(rightValue)
                    }
                case "/":
                    if stack.last != 0 {
                        let rightValue = stack.removeLast()
                        
                        if stack.last != nil {
                            let leftValue = stack.removeLast()
                            stack.append(leftValue / rightValue)
                        } else {
                            stack.append(rightValue)
                        }
                    }
                    inputDataArray = [String]()
                    outputData = [String]()
                    input = ""
                case "^":
                    if stack.last != 0 && !stack.isEmpty {
                    let rightValue = stack.removeLast()
                    if stack.last != nil && isValue(at: String(stack.last!)){
                        let leftValue = stack.removeLast()
                        stack.append(pow(leftValue, rightValue))
                    } else {
                        stack.append(rightValue)
                        }
                    } else {
                        stack.append(0)
                    }
                case "sin":
                    let value = stack.removeLast()
                    stack.append(sin(value))
                case "siNh":
                    let value = stack.removeLast()
                    stack.append(sinh(value))
                case "±":
                    let value = stack.removeLast()
                    stack.append(-(value))
                case "%":
                    if stack.last != nil {
                    let rightValue = stack.removeLast()
                    if stack.last != nil {
                        let leftValue = stack.removeLast()
                        stack.append(((leftValue * rightValue)/100))
                    } else {
                        stack.append(rightValue)
                        }}
                case "cos":
                    let value = stack.removeLast()
                    stack.append(cos(value))
                case "coSh":
                    let value = stack.removeLast()
                    stack.append(cosh(value))
                case "tg":
                    let value = stack.removeLast()
                    stack.append(tan(value))
                case "tGh":
                    let value = stack.removeLast()
                    stack.append(tanh(value))
                case "ctg":
                    if stack.last! != 0 {
                    let value = stack.removeLast()
                    stack.append(1/tan(value))
                    }
                case "√":
                    let value = stack.removeLast()
                    stack.append(sqrt(abs(value)))
                case "ln":
                    let value = stack.removeLast()
                    stack.append(log(value))
                    
                default:
                    if Double(value) != nil{
                    stack.append(Double(value)!)
                    }
                }
                print(stack)
                
            }
        return stack[stack.count-1]
    }
    
    func factorial (_ value: Double) -> Double {
        return value > 1 ? (value * factorial(value-1)) : 1
    }
    
    
}

