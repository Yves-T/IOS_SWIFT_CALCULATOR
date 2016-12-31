import UIKit
import AVFoundation

extension Double {
    var DoubleToInt: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftNumber = ""
    var rightNumber = ""
    var result = ""

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.url(forResource: "btn", withExtension: "wav")!

        do {
            btnSound = try AVAudioPlayer(contentsOf: path)
            btnSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        } catch {
            print("unknown error")
        }

        resultLabel.text = "0"
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()

        runningNumber += "\(sender.tag)"
        resultLabel.text = runningNumber
    }

    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }

    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }

    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }

    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }

    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

    func processOperation(operation: Operation) {

        if Double(leftNumber) != nil {
            if Double(runningNumber) != nil {
                rightNumber = runningNumber
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                case Operation.Divide:
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                case Operation.Add:
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                case Operation.Subtract:
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                default:
                    print("\(operation)")
                }
            }
            leftNumber = Double(result)!.DoubleToInt
            resultLabel.text = Double(result)!.DoubleToInt
            runningNumber = ""
        } else {
            leftNumber = runningNumber
            runningNumber = ""
        }
        currentOperation = operation

        print("Oprq: \(operation)!")
        print("lnum: \(leftNumber)")
        print("rnum: \(rightNumber)")
        print("runn: " + runningNumber)

    }

}

