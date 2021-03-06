//
//  ViewController.swift
//  TecCalculator
//
//  Created by user190978 on 2/19/21.
//

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String (self)    }
}
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
       
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var current = "0"
       var operationValue = ""
       var clear = false
    var prevOp = "" //meant for continuous operations
       
       func calc(x: Double, y: Double, operation: String) -> Double {
           switch operation {
           case "+":
               return x + y
           case "-":
               return x - y
           case "×":
               return x * y
           case "÷":
               return x / y
           default:
               return y
           }
       }

       @IBAction func processNumber(_ sender: UIButton) {
               if let numberText = sender.titleLabel?.text {
                   if !clear {
                       if resultLabel.text == "0" && numberText != "." {
                        resultLabel.text = numberText
                       } else if numberText != "."{
                        resultLabel.text = resultLabel.text! + numberText
                       }
                       else if !resultLabel.text!.contains(".") {
                           resultLabel.text = resultLabel.text! + numberText
                       }
                   } else {
                       resultLabel.text = numberText
                       clear = false
                   }
                   
               }
           }
       
       @IBAction func processEquals(_ sender: UIButton) {
           prevOp = operationValue == "" ? prevOp : operationValue
           let x = Double(current)
           let y = Double(resultLabel.text!)
           let result = calc(x: x!, y: y!, operation: operationValue)
        resultLabel.text = result.clean
           current = "0"
           clear = true
           operationValue = ""
       }
       
       
       @IBAction func processClear(_ sender: UIButton) {
           resultLabel.text = "0"
           current = "0"
           clear = true
           operationValue = ""
       }
       
       @IBAction func processOperation(_ sender: UIButton) {
           if let operationText = sender.titleLabel?.text {
               if operationValue.isEmpty {
                   operationValue = operationText
                   current = resultLabel.text ?? "0"
                   clear = true
                   
               } else {
                   let x = Double(current)
                   let y = Double(resultLabel.text!)
                   let result = calc(x: x!, y: y!, operation: operationValue)
                current = result.clean
                resultLabel.text = result.clean
                   operationValue = operationText
                   clear = true
               }
           }
       }

}

