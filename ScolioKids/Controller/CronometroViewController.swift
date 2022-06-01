//
//  CronometroViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 01/06/22.
//

import UIKit

class CronometroViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
        
        
        var timer:Timer = Timer()
        var count: Int = 0
        var timerCount: Bool = false
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        
            //START BUTTON
            
    //        timeLabel.font = UIFont(name: "SF-Pro-Display", size: 80)
            startButton.setTitle("Iniciar", for: .normal)
            self.startButton.backgroundColor = UIColor.systemGreen
            ///Rounding start button
    //        startButton.frame = CGRect(x: 270, y: 307, width: 80, height: 80)
            startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
            startButton.clipsToBounds = true
            startButton.titleLabel?.adjustsFontSizeToFitWidth = true
            startButton.titleLabel?.minimumScaleFactor = 0.8
            
            //RESET BUTTON
            resetButton.setTitle("Zerar", for: .normal)
            
            self.resetButton.backgroundColor = UIColor.systemBrown
            ///Rounding reset button
    //        resetButton.frame = CGRect(x: 40, y: 307, width: 80, height: 80)
            resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
            resetButton.clipsToBounds = true
            resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
            resetButton.titleLabel?.minimumScaleFactor = 0.8
            
    //        tableViewControllerSize.bounds.height(860)
        }

        // ======= RESET BUTTON ACTION
        @IBAction func resetTapped(_ sender: Any) {
     
            // Alert
    //        let alert = UIAlertController(title: "", message: "Você tem certeza que gostaria de cancelar o tempo?", preferredStyle: .alert)
            
            // Cancel Action
    //        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
    //        alert.addAction(cancelAction)
            
            
            // Confirm Action to reset the stopwatch
    //        let confirmAction = UIAlertAction(title: "Sim", style: .default, handler: { (_) in
                self.count = 0
                self.timer.invalidate()
                self.timeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
                self.startButton.setTitle("Iniciar", for: .normal)
                self.startButton.backgroundColor = UIColor.systemGreen
    //        })
    //        alert.addAction(confirmAction)
            
            
            // Present all the let alert's configuration
    //        self.present(alert, animated: true, completion: nil)
            
        }
        
        
        // ======= START BUTTON ACTION
        @IBAction func startTapped(_ sender: Any) {
            
            
            if (timerCount) {
                //Starting time
                timerCount = false // to pause time if necessary
                timer.invalidate()
                startButton.setTitle("Iniciar", for: .normal)
                startButton.backgroundColor = UIColor.systemGreen

            } else {
                
                //If time is counting, STOP button
                timerCount = true // to start counting time
                startButton.setTitle("Pausar", for: .normal)
                startButton.backgroundColor = UIColor.systemRed
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countingTime), userInfo: nil, repeats: true)

            }
            
            
        }
        
        @objc func countingTime() -> Void {
            
            //adding seconds to the count
            count += 1
           
            let time = secondsToHoursMinutesSeconds(seconds: count) //receiving minutes/seconds data
           
            let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2) //receiving string data
           
            timeLabel.text = timeString //showing string data in the label
            
            /// time gets the secondsToMinutesSeconds and pass it in makeTimeString methog which transforms de INT's into Strings. timeString gets the makeTimeString method and uses it in timeLabel.text
        }
        
        
        // CALCULATE THE MINUTES AND SECONDS
        /// it receives the INT of var count and returns the minutes and seconds
        func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
                    // minutes              //seconds
            
            return (((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60)))
    //        return (((seconds % 3600) / 60), ((seconds % 3600) % 3600))
        }
        
        func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
            
            // transforming the INTs into Strings to lately be shown at label's text
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
        }
        
        
        
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
