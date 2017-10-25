//
//  Delegate.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/10/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//

import UIKit

protocol InputInterface {
    func symbolPressed(_ symbol: String)
}

protocol InputInterfaceDelegate {
    func digitPressed(_ value: Double)
    func operationPressed(_ operation: Operation)
    func functionPressed(_ function: Function)
    func utilityPressed(_ utility: Utility)
    func factorial(_ symbol: String)
    func allClean(_ clean: Memory)
    func clear(_ clean: Memory)
    func display(_ symbol: String)
    func ifDigitAre(_ symbol: String)
    func constansPressed(_ const: Constants)
    func checkIsOperation(_ value: String.Element)-> Bool
    //func procent(_ symbol: String)
    //func plusMinus(_ symbol: String)
    
}
