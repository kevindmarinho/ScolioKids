//
//  StopwatchViewController.swift
//  ScolioKids
//
//  Created by Dessana Santos on 01/06/22.
//

import UIKit

class StopwatchViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backgroundStopWatch: UIView!
    
    var timer:Timer = Timer()
    var count: Int = 0
    var timerCount: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.setTitle("Iniciar", for: .normal)
        self.startButton.backgroundColor = UIColor.init(red: 27/255, green: 188/255, blue: 130/255, alpha: 1)
        //Rounding start button
//        startButton.frame = CGRect(x: 270, y: 307, width: 80, height: 80)
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        startButton.clipsToBounds = true
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //RESET BUTTON
        resetButton.setTitle("Zerar", for: .normal)
        
        self.resetButton.backgroundColor = UIColor.white
        //Rounding reset button
//        resetButton.frame = CGRect(x: 40, y: 307, width: 80, height: 80)
        resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
        resetButton.clipsToBounds = true
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        resetButton.titleLabel?.minimumScaleFactor = 0.8
        
    }
    
    
    // RESET BUTTON
    @IBAction func resetTapped(_ sender: Any) {
        
        self.count = 0
        self.timer.invalidate()
        self.timeLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        self.startButton.setTitle("Iniciar", for: .normal)
        self.startButton.backgroundColor = UIColor.init(red: 27/255, green: 188/255, blue: 130/255, alpha: 1)
        
    }
    
    
    
    // START BUTTON
    @IBAction func startTapped(_ sender: Any) {
        
        if (timerCount) {
            
            timerCount = false
            timer.invalidate()
            startButton.setTitle("Iniciar", for: .normal)
            startButton.backgroundColor = UIColor.init(red: 27/255, green: 188/255, blue: 130/255, alpha: 1)
        } else {
            
            timerCount = true
            startButton.setTitle("Pausar", for: .normal)
            startButton.backgroundColor = UIColor.init(red: 226/255, green: 105/255, blue: 76/255, alpha: 1)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countingTime), userInfo: nil, repeats: true)
            
        }
        
    }
    
    
    @objc func countingTime() -> Void {
        
        count += 1
        
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        
        timeLabel.text = timeString
        
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        
        return (((seconds / 3600), ((seconds % 60) / 60), ((seconds % 60) % 60)))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
