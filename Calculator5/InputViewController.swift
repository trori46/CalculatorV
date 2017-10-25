//
//  InputViewController.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/10/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//

import UIKit
import AVFoundation

class InputViewController: UIViewController, InputInterface {
    var delegate: InputInterfaceDelegate?
    
    @IBOutlet weak var clearButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(InputViewController.clear))//Tap function will call when user tap on button
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(InputViewController.allClear)) //Long function will call when user long press on button.
        tapGesture.numberOfTapsRequired = 1
        self.clearButton?.addGestureRecognizer(tapGesture)
        self.clearButton?.addGestureRecognizer(longGesture)
        
    }
    @objc func clear() {
        delegate?.clear(.clear)
        
    }
    @objc func allClear() {
        delegate?.allClean(.allClean)
    }
    
    func symbolPressed(_ symbol: String) {
        if symbol == "=" {
            delegate?.utilityPressed(.equal)
        }else if symbol == "-" {
            delegate?.operationPressed(.minus)
        }else if symbol == "(" || symbol == ")" || symbol == "." {
            delegate?.utilityPressed(Utility(rawValue: symbol)!)
        }else if symbol == "+" || symbol == "*" || symbol == "/" || symbol == "^" {
            delegate?.operationPressed(Operation(rawValue: symbol)!)
        } else if symbol == "x!" {
            delegate?.factorial(symbol)
        } else if symbol == "π" {
            delegate?.constansPressed(.pi)
        } else if symbol == "e" {
            delegate?.constansPressed(.e)
        }else if symbol == "1" || symbol == "2" || symbol == "3" || symbol == "4" || symbol == "5" || symbol == "6" || symbol == "7" || symbol == "8" || symbol == "9" || symbol == "0"{
            delegate?.digitPressed(Double(symbol)!)
        } else if symbol == "%"{
            delegate?.functionPressed(Function(rawValue: symbol)!)
        }
        else if symbol == "sin" || symbol == "cos" || symbol == "tg" || symbol == "ctg" || symbol == "ln" || symbol == "√" || symbol == "±" || symbol == "siNh" || symbol == "coSh" || symbol == "tGh" {
            delegate?.ifDigitAre(symbol)
        } else {
            delegate?.display(symbol)
            
            
        }
    }
    
    @IBAction func symbolPressed(_ sender: UIButton) {
        sender.flash()
        symbolPressed(sender.currentTitle!)
        playClick()
    }
    private func playClick() {
        AudioServicesPlaySystemSound(1105)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? InputViewController{
            destination.delegate = delegate
        }
    }
}


